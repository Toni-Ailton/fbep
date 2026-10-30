local Card = require("src.game.card")

local DfbCup = {}
DfbCup.__index = DfbCup
setmetatable(DfbCup, {__index = Card})

function DfbCup.new(id, deckId, backsideImage, matchId)
    local self = Card.new(id, deckId, backsideImage)
    self.matchId = matchId
    setmetatable(self, DfbCup)
    return self
end

function DfbCup:triggerEvent() -- Referenz auf Spielzustand, Spieler oder ähnliches
    triggerEvent(self.matchId)
end

return DfbCup