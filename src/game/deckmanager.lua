local Assets = require("src.engine.assets")
local CardData = require("src.game.cards.carddata")
local BadEvent = require("src.game.cards.badevent")
local GoodEvent = require("src.game.cards.goodevent")
local DfbCup = require("src.game.cards.dfbcup")
local EuroCup = require("src.game.cards.eurocup")

local DeckManager = {}
DeckManager.__index = DeckManager

local eventResolutions = {
    immediate = true,
    holdUntilTrigger = true
}

local function validateEventOption(eventData, cardId, optionName)
    if type(eventData) ~= "table" or type(eventData.eventId) ~= "string" then
        error("Ungültige Eventdaten für '" .. tostring(cardId) .. "' (" .. optionName .. ").", 3)
    end
    if not eventResolutions[eventData.resolution] then
        error("Ungültige Event-Auflösung für '" .. tostring(cardId) .. "' (" .. optionName .. ").", 3)
    end
    if type(eventData.mayKeep) ~= "boolean" then
        error("mayKeep muss für '" .. tostring(cardId) .. "' (" .. optionName .. ") true oder false sein.", 3)
    end
end

local deckIds = {
    "badEvent",
    "goodEvent",
    "dfbCup",
    "euroCup"
}

local cardFactories = {
    badEvent = function(cardData, deckId, backsideImage)
        if type(cardData.options) ~= "table" then
            error("Event-Optionen für '" .. tostring(cardData.id) .. "' fehlen.", 2)
        end
        for optionName, eventData in pairs(cardData.options) do
            validateEventOption(eventData, cardData.id, optionName)
        end
        return BadEvent.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData.options
        )
    end,
    goodEvent = function(cardData, deckId, backsideImage)
        validateEventOption(cardData.event, cardData.id, "event")
        return GoodEvent.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData.event
        )
    end,
    dfbCup = function(cardData, deckId, backsideImage)
        return DfbCup.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData.matchId
        )
    end,
    euroCup = function(cardData, deckId, backsideImage)
        return EuroCup.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData.matchIdChampion,
            cardData.matchIdUefa
        )
    end
}

function DeckManager.new(gameState)
    if type(gameState) ~= "table" or type(gameState.decks) ~= "table" then
        error("Der DeckManager benötigt einen GameState mit initialisierten decks.", 2)
    end

    local self = setmetatable({}, DeckManager)
    self.gameState = gameState
    return self
end

function DeckManager:shuffleDeck(deckId)
    local deck = self.gameState.decks[deckId]
    if type(deck) ~= "table" then
        error("Der Kartenstapel '" .. tostring(deckId) .. "' ist nicht initialisiert.", 2)
    end

    for index = #deck, 2, -1 do
        local swapIndex = math.random(index)
        deck[index], deck[swapIndex] = deck[swapIndex], deck[index]
    end
end

function DeckManager:initialize()
    if not Assets.cards or not Assets.cards.backsideImages then
        error("Assets müssen vor der Initialisierung der Kartenstapel geladen werden.", 2)
    end

    for deckId in pairs(CardData) do
        if not cardFactories[deckId] then
            error("Unbekannter Kartentyp in carddata.lua: " .. tostring(deckId), 2)
        end
    end

    local decks = {}
    for _, deckId in ipairs(deckIds) do
        local deckData = CardData[deckId]
        local createCard = cardFactories[deckId]
        if type(deckData) ~= "table" then
            error("Der Kartenstapel '" .. deckId .. "' fehlt in carddata.lua.", 2)
        end
        if type(deckData.cards) ~= "table" or #deckData.cards == 0 then
            error("Der Kartenstapel '" .. deckId .. "' enthält keine Karten.", 2)
        end

        local backsideImage = Assets.cards.backsideImages[deckData.backsideImage]
        if not backsideImage then
            error(
                "Kein Rückseitenbild '" .. tostring(deckData.backsideImage)
                    .. "' für den Kartenstapel '" .. deckId .. "' gefunden.",
                2
            )
        end

        decks[deckId] = {}
        for index, cardData in ipairs(deckData.cards) do
            if type(cardData) ~= "table" or cardData.id == nil then
                error(
                    "Ungültige Kartendaten an Position " .. index .. " im Stapel '" .. deckId .. "'.",
                    2
                )
            end
            decks[deckId][index] = createCard(cardData, deckId, backsideImage)
        end
    end

    self.gameState.decks = decks

    -- Shuffle all decks after initialization
    for _, deckId in ipairs(deckIds) do
        self:shuffleDeck(deckId)
    end
end

return DeckManager