-- scenes/start.lua
local MenuScene = {}

local Colors = require("src.config.colors")
local Layout = require("src.config.layout")
local Viewport = require("src.engine.viewport")
local SceneManager = require("src.engine.scenemanager")
local Assets = require("src.engine.assets")

local gameSetup = {
    players = {
        { controller = "human" },
        { controller = "ai" },
        { controller = "ai" },
        { controller = "ai" }
    }
}

local startGameForTesting = true

function MenuScene:enter()
    self.startTriggered = false
end

function MenuScene:update(dt)
    if startGameForTesting and not self.startTriggered then
        self.startTriggered = true
        if type(self.onStartGame) ~= "function" then
            error("Für das Menü ist kein Spielstart-Callback eingerichtet.", 2)
        end
        self.onStartGame(gameSetup)
    end
end

function MenuScene:draw()
    love.graphics.setColor(Colors.grey)
    love.graphics.print("Hello World", 100, 100)
end

--function MenuScene:mousepressed(mx, my, button)
--    print("MenuScene erhält Klick bei:", mx, my, "Button:", button)
--    for _, btn in ipairs(self.buttons) do
--        if btn:mousepressed(mx, my, button) then
--            break 
--        end
--    end
--end
--
--function MenuScene:mousemoved(mx, my, dx, dy, isTouch)
--    for _, btn in ipairs(self.buttons) do
--        btn:mousemoved(mx, my, dx, dy, isTouch)
--    end
--end

return MenuScene
