local GameManager = {}
GameManager.__index = GameManager

local GameState = require("src.game.gamestate")
local MovePhase = require("src.game.phases.movephase")
local ActionPhase = require("src.game.phases.actionphase")

function GameManager.new()
    local self = setmetatable({}, GameManager)
    self.state = GameState.new()
    self.phases = {
        move = MovePhase.new(self),
        action = ActionPhase.new(self)
    }
   
    self.currentPhase = nil
    self:changePhase("move")

    return self
end


function GameManager:update(dt)
    if self.currentPhase then
        self.currentPhase:update(dt)
    end
end

function GameManager:changePhase(phaseName)
    local phase = self.phases[phaseName]
    if not phase then
        error("Unbekannte Phase '" .. tostring(phaseName) .. "'.", 2)
    end
    self.currentPhase = phase
end