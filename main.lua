local Colors = require("src.config.colors")
local Layout = require("src.config.layout")
local Viewport = require("src.engine.viewport")
local Assets = require("src.engine.assets")
local Coroutines = require("src.engine.coroutines")
local SceneManager = require("src.engine.scenemanager")

local MenuScene = require("src.scenes.menu")

local Board = require("src.game.board")

SceneManager:addScene("menu", MenuScene)
SceneManager:switch("menu", true)

function love.load()
    math.randomseed(os.time())
    Assets:load()
    Viewport:update()
end

function love.resize(width, height)
    Viewport:update()
end

function love.update(dt)
    SceneManager:update(dt)
end

function love.draw()
    Viewport:apply()
    SceneManager:draw()
    Viewport:reset()
end

function love.mousepressed(x, y, button, isTouch)
    local mx, my = Viewport:screenToWorld(x, y)
    SceneManager:mousepressed(mx, my, button, isTouch)
end

function love.mousemoved(x, y, dx, dy, isTouch)
    local mx, my = Viewport:screenToWorld(x, y)
    local mdx = dx / Viewport.scale
    local mdy = dy / Viewport.scale
   
    SceneManager:mousemoved(mx, my, mdx, mdy, isTouch)
end