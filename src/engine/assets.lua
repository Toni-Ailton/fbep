-- assets.lua
local Assets = {}

function Assets:load()
    self.cards = {
        backsideImages = {
        goodEvent = love.graphics.newImage("assets/sprites/cards/event_good.png"),
        badEvent = love.graphics.newImage("assets/sprites/cards/event_bad.png"),
        dfbCup = love.graphics.newImage("assets/sprites/cards/event_dfb.png"),
        euroCup = love.graphics.newImage("assets/sprites/cards/event_euro.png")
        }
    }
end

return Assets