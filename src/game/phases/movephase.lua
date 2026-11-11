local MovePhase = {}
MovePhase.__index = MovePhase

function MovePhase.new(gameManager)
    local self = setmetatable({}, MovePhase)
    self.gameManager = gameManager
    return self
end

function MovePhase:enter()
    print("Entering Move Phase")
    local gameState = self.gameManager.state
    local currentPlayer = gameState:getCurrentPlayer()

end

function MovePhase:update(dt)
    -- Würfeln und Bewegung durchführen
    
    -- Ereignis auslösen

end


function MovePhase:finish()
    print("Move Phase finished")
end

return MovePhase