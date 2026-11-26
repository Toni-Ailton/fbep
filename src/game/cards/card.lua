local Card = {}
Card.__index = Card

function Card.new(id, deckId, backsideImage, cardData)
    local self = setmetatable({}, Card)
    self.id = id
    self.deckId = deckId
    self.image = backsideImage
    self.respondsToBadEvent = cardData and cardData.respondsToBadEvent
    self.optional = cardData and cardData.optional
    return self
end

return Card