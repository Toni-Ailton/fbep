local Card = require("src.game.card")

local EuroCup = {}
EuroCup.__index = EuroCup
setmetatable(EuroCup, {__index = Card})

function EuroCup.new(id, deckId, backsideImage, matchIdChampion, matchIdUefa)
    local self = Card.new(id, deckId, backsideImage)
    self.matchIdChampion = matchIdChampion
    self.matchIdUefa = matchIdUefa
    setmetatable(self, EuroCup)
    return self
end

function EuroCup:triggerMatch(matchOption) -- Referenz auf Spielzustand, Spieler oder ähnliches
    if matchOption == "champion" then
        triggerMatch(self.matchIdChampion)
    elseif matchOption == "uefa" then
        triggerMatch(self.matchIdUefa)
    end
end

return EuroCup