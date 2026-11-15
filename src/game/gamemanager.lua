local GameManager = {}
GameManager.__index = GameManager

local GameState = require("src.game.gamestate")
local DeckManager = require("src.game.deckmanager")
local MovePhase = require("src.game.phases.movephase")
local ActionPhase = require("src.game.phases.actionphase")

function GameManager.new(gameSetup)
    if gameSetup ~= nil and type(gameSetup) ~= "table" then
        error("Die Spielkonfiguration muss als Tabelle übergeben werden.", 2)
    end
    gameSetup = gameSetup or {}

    local self = setmetatable({}, GameManager)
    self.setup = gameSetup
    self.state = GameState.new(gameSetup.players)
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
    local advancePlayer = false

    if self.currentPhaseName == "move" then
        nextPhaseName = "action"
    elseif self.currentPhaseName == "action" then
        nextPhaseName = "move"
        advancePlayer = true
    else
        error("Keine aktive Phase zum Abschließen.", 2)
    end

    self:changePhase(nextPhaseName, advancePlayer)
end

function GameManager:changePhase(phaseName, advancePlayer)
    local phase = self.phases[phaseName]
    if not phase then
        error("Unbekannte Phase '" .. tostring(phaseName) .. "'.", 2)
    end

    if self.currentPhase then
        self.currentPhase:finish()
    end
    if advancePlayer then
        self.state:nextPlayer()
    end

    self.currentPhase = phase
    self.currentPhaseName = phaseName
    self.currentPhase:enter()
end

return GameManager