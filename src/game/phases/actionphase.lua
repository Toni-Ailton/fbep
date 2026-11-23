local ActionPhase = {}
ActionPhase.__index = ActionPhase

function ActionPhase.new(gameManager)
    local self = setmetatable({}, ActionPhase)
    self.gameManager = gameManager
    return self
end

function ActionPhase:enter()
    print("Entering Action Phase")
    local gameState = self.gameManager.state
    local currentClub = gameState:getCurrentClub()

end

function ActionPhase:update(dt)
    -- Wait for player to choose an action
    -- Sobald die Aktion abgeschlossen ist:
    self.gameManager:completeCurrentPhase()
end

function ActionPhase:finish()
    print("Action Phase finished")
end


return ActionPhase