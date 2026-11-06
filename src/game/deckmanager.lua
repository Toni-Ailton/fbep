local Assets = require("src.engine.assets")
local CardData = require("src.game.cards.card_data")
local BadEvent = require("src.game.cards.badevent")
local GoodEvent = require("src.game.cards.goodevent")
local DfbCup = require("src.game.cards.dfbcup")
local EuroCup = require("src.game.cards.eurocup")

local DeckManager = {
    decks = {}
}

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
            cardData.eventIdYellow,
            cardData.eventIdRed
        )
    end,
    goodEvent = function(cardData, deckId, backsideImage)
        return GoodEvent.new(
            cardData.id,
            deckId,
            backsideImage,
            cardData.eventId
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

function DeckManager:initialize()
    if not Assets.cards or not Assets.cards.backsideImages then
        error("Assets müssen vor der Initialisierung der Kartenstapel geladen werden.", 2)
    end

    for deckId in pairs(CardData) do
        if not cardFactories[deckId] then
            error("Unbekannter Kartentyp in card_data.lua: " .. tostring(deckId), 2)
        end
    end

    local decks = {}
    for _, deckId in ipairs(deckIds) do
        local deckData = CardData[deckId]
        local createCard = cardFactories[deckId]
        if type(deckData) ~= "table" then
            error("Der Kartenstapel '" .. deckId .. "' fehlt in card_data.lua.", 2)
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

    self.decks = decks
end

return DeckManager