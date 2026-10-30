local Colors = require("src.config.colors")
local Layout = require("src.config.layout")
local Viewport = require("src.engine.viewport")
local Assets = require("src.engine.assets")
local Coroutines = require("src.engine.coroutines")

local Board = {}

function Board:load()
    -- re-Initialisierung, anderernfalls würden bei Neustart weitere Elemente per insert an die Tabellen angehängt werden!
end

--=====================
-- Load-Funktionen
--=====================


--=====================
-- Update / Draw
--=====================

function Board:update(dt)

end

function Board:draw()

end


--=====================
-- Update-Funktionen
--=====================


--=====================
-- Draw-Funktionen
--=====================


--=====================
-- Button-Funktionen
--=====================


return Board