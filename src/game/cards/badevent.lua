local Card = require("src.game.card")

local BadEvent = {}
BadEvent.__index = BadEvent
setmetatable(BadEvent, {__index = Card})

function BadEvent.new(id, deckId, backsideImage, eventIdYellow, eventIdRed)
    local self = Card.new(id, deckId, backsideImage)
    self.eventIdYellow = eventIdYellow
    self.eventIdRed = eventIdRed
    setmetatable(self, BadEvent)
    return self
end

function BadEvent:triggerEvent(eventOption) -- Referenz auf Spielzustand, Spieler oder ähnliches
    if eventOption == "yellow" then
        triggerEvent(self.eventIdYellow)
    elseif eventOption == "red" then
        triggerEvent(self.eventIdRed)
    end
end

return BadEvent