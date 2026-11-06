local Card = require("src.game.cards.card")

local BadEvent = {}
BadEvent.__index = BadEvent
setmetatable(BadEvent, {__index = Card})

function BadEvent.new(id, deckId, backsideImage, options)
    local self = Card.new(id, deckId, backsideImage)
    self.options = options
    setmetatable(self, BadEvent)
    return self
end

function BadEvent:getEventOption(eventOption)
    local option = self.options[eventOption]
    if not option then
        error("Unbekannte Event-Option '" .. tostring(eventOption) .. "' für Karte '" .. self.id .. "'.", 2)
    end
    return option
end

function BadEvent:triggerEvent(eventOption)
    local option = self:getEventOption(eventOption)
    triggerEvent(option.eventId)
end

return BadEvent