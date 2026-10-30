local Card = require("src.game.card")

local GoodEvent = {}
GoodEvent.__index = GoodEvent
setmetatable(GoodEvent, {__index = Card})

function GoodEvent.new(id, deckId, backsideImage, eventId)
    local self = Card.new(id, deckId, backsideImage)
    self.eventId = eventId
    setmetatable(self, GoodEvent)
    return self
end

function GoodEvent:triggerEvent() -- Referenz auf Spielzustand, Spieler oder ähnliches
    triggerEvent(self.eventId)
end

return GoodEvent