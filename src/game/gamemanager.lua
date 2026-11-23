local GameManager = {}
GameManager.__index = GameManager

local GameState = require("src.game.gamestate")
local DeckManager = require("src.game.deckmanager")
local MovePhase = require("src.game.phases.movephase")
local ActionPhase = require("src.game.phases.actionphase")

function GameManager.new(gameSetup)
    gameSetup = gameSetup or {}

    local self = setmetatable({}, GameManager)
    self.setup = gameSetup
    self.state = GameState.new(gameSetup.clubs)
    self.deckManager = DeckManager.new(self.state)
    self.deckManager:initialize()

    self.phases = {
        move = MovePhase.new(self),
        action = ActionPhase.new(self)
    }
   
    self.currentPhase = nil
    self.currentPhaseName = nil
    self:changePhase("move")

    return self
end


function GameManager:update(dt)
    if self.currentPhase then
        self.currentPhase:update(dt)
    end
end

function GameManager:completeCurrentPhase()
    local nextPhaseName
    local advanceClub = false

    if self.currentPhaseName == "move" then
        nextPhaseName = "action"
    elseif self.currentPhaseName == "action" then
        nextPhaseName = "move"
        advanceClub = true
    else
        error("Keine aktive Phase zum Abschließen.", 2)
    end

    self:changePhase(nextPhaseName, advanceClub)
end

function GameManager:changePhase(phaseName, advanceClub)
    local phase = self.phases[phaseName]
    if not phase then
        error("Unbekannte Phase '" .. tostring(phaseName) .. "'.", 2)
    end

    if self.currentPhase then
        self.currentPhase:finish()
    end
    if advanceClub then
        self.state:nextClub()
    end

    self.currentPhase = phase
    self.currentPhaseName = phaseName
    self.currentPhase:enter()
end

return GameManager