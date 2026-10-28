-- viewport.lua
local Viewport = {}

Viewport.scale = 1
Viewport.offset_x = 0
Viewport.offset_y = 0

local BASE_W = 1600
local BASE_H = 900

function Viewport:update()
    local win_w, win_h = love.graphics.getDimensions()

    -- Proportional skalieren (Letterbox)
    Viewport.scale = math.min(
        win_w / BASE_W,
        win_h / BASE_H
    )

    -- Zentrieren
    Viewport.offset_x = (win_w - BASE_W * Viewport.scale) / 2
    Viewport.offset_y = (win_h - BASE_H * Viewport.scale) / 2
end

-- Vor dem Zeichnen aufrufen
function Viewport:apply()
    love.graphics.push()
    love.graphics.translate(self.offset_x, self.offset_y)
    love.graphics.scale(self.scale, self.scale)
end

-- Nach dem Zeichnen aufrufen
function Viewport:reset()
    love.graphics.pop()
end

function Viewport:screenToWorld(x, y)
    local wx = (x - self.offset_x) / self.scale
    local wy = (y - self.offset_y) / self.scale
    return wx, wy
end

return Viewport
