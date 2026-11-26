local Assets = require("src.engine.assets")
local CardData = require("src.game.cards.carddata")
local BadEvent = require("src.game.cards.badevent")
local GoodEvent = require("src.game.cards.goodevent")
local DfbCup = require("src.game.cards.dfbcup")
local EuroCup = require("src.game.cards.eurocup")

local DeckManager = {}
DeckManager.__index = DeckManager

local deckIds = {
    "badEvent",
    "goodEvent",
    "dfbCup",
    "euroCup"
}

local cardFactories = {
    badEvent = function(cardData, deckId, backsideImage)
        return BadEvent.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData
        )
    end,
    goodEvent = function(cardData, deckId, backsideImage)
        return GoodEvent.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData
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

    local decks = {}
    for _, deckId in ipairs(deckIds) do
        local deckData = CardData[deckId]
        local createCard = cardFactories[deckId]

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