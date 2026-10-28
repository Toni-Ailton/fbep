local Layout = require("src.config.layout")

-- sceneManager.lua
local SceneManager = {}

SceneManager.currentScene = nil
SceneManager.scenes = {}

SceneManager.transitionAlpha = 0
SceneManager.targetScene = nil
SceneManager.fadeState = "idle" -- "idle", "out", "in"

-- Szene registrieren
function SceneManager:addScene(name, scene)
    self.scenes[name] = scene
end

-- Szene wechseln
function SceneManager:switch(sceneName, noFade) -- schöner wäre hier die Übergabe einer optionalen Fading-Routine
    if noFade then
        self:executeSceneChange(sceneName)
        self.transitionAlpha = 0
        self.fadeState = "idle"
    elseif self.fadeState == "idle" then
        self.targetScene = sceneName
        self.fadeState = "out"
    end
end

-- Weiterleitungen
function SceneManager:update(dt)
    local speed = 7 -- Höhere Zahl = schnellerer Blitz

    -- Fading-Mechanik für den Übergang
    if self.fadeState == "out" then
        self.transitionAlpha = self.transitionAlpha + dt * speed
        if self.transitionAlpha >= 1 then
            self.transitionAlpha = 1
            
            -- eigentlicher Szenenwechsel
            self:executeSceneChange(self.targetScene)
            
            self.fadeState = "in"
        end
    elseif self.fadeState == "in" then
        self.transitionAlpha = self.transitionAlpha - dt * speed
        if self.transitionAlpha <= 0 then
            self.transitionAlpha = 0
            self.fadeState = "idle"
        end
    end

    -- Update der aktuellen Szene (wichtig für Animationen etc.)
    if self.currentScene and self.currentScene.update then
        self.currentScene:update(dt)
    end
end

function SceneManager:executeSceneChange(sceneName)
    if self.scenes[sceneName] then
        self.currentScene = self.scenes[sceneName]
        if self.currentScene.enter then 
            self.currentScene:enter() 
        end
    end
end

function SceneManager:draw()
    if self.currentScene and self.currentScene.draw then
        self.currentScene:draw()
        self:drawVersion()
    end

    -- Standard-Szenen-Übergang (weiß)
    if self.transitionAlpha > 0 then
        love.graphics.push("all")
            -- Weiß mit dem aktuellen Alpha-Wert
            -- Nutzt deine colors.lua oder einfach direkte Werte:
            love.graphics.setColor(1, 1, 1, self.transitionAlpha)
            
            -- Über den gesamten Bildschirm (Screen-Space)
            love.graphics.rectangle("fill", 0, 0, Layout.base_width, Layout.base_height)
        love.graphics.pop()
    end
end

function SceneManager:drawVersion()
    love.graphics.push("all")
        local version = "Version 0.01"
        -- Wir nutzen einen deiner geladenen Fonts
        --love.graphics.setFont(Assets.fonts.small or love.graphics.newFont(14))
        
        -- Da wir im Viewport (1600x900) sind, nutzen wir Layout-Konstanten
        local padding = 10
        local tw = love.graphics.getFont():getWidth(version)
        local th = love.graphics.getFont():getHeight()
        
        -- Position fixiert auf die rechte untere Ecke der 1600x900 Welt
        local x = 1600 - tw - padding
        local y = 900 - th - padding

        -- Schatten für bessere Lesbarkeit
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.print(version, x + 1, y + 1)
        
        -- Dezent hellgrau/weiß
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.print(version, x, y)
    love.graphics.pop()
end

function SceneManager:mousepressed(x, y, button, isTouch)
    if self.currentScene and self.currentScene.mousepressed then
        self.currentScene:mousepressed(x, y, button, isTouch)
    end
end

function SceneManager:mousemoved(x, y, dx, dy, isTouch)
    if self.fadeState ~= "idle" then return end
    if self.currentScene and self.currentScene.mousemoved then
        self.currentScene:mousemoved(x, y, dx, dy, isTouch)
    end
end

return SceneManager
