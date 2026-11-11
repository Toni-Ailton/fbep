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
    local currentPlayer = gameState:getCurrentPlayer()

end

function ActionPhase:update(dt)
    -- Wait for player to choose an action
end

function ActionPhase:finish()
    print("Action Phase finished")

    -- set next player's turn


    -- set phase back to "move"

end


return ActionPhase