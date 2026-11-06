local Card = require("src.game.cards.card")

local GoodEvent = {}
GoodEvent.__index = GoodEvent
setmetatable(GoodEvent, {__index = Card})

function GoodEvent.new(id, deckId, backsideImage, event)
    local self = Card.new(id, deckId, backsideImage)
    self.event = event
    setmetatable(self, GoodEvent)
    return self
end

function GoodEvent:getEventOption()
    return self.event
end

function GoodEvent:triggerEvent()
    local event = self:getEventOption()
    triggerEvent(event.eventId)
end

return GoodEvent