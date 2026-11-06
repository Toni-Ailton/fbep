local Card = {}
Card.__index = Card

function Card.new(id, deckId, backsideImage)
    local self = setmetatable({}, Card)
    self.id = id
    self.deckId = deckId
    self.image = backsideImage
    return self
end

return Card