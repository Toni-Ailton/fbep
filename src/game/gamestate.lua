local GameState = {}
GameState.__index = GameState

function GameState.new()
    local self = setmetatable({}, GameState)
    self.currentPlayer = nil
    self.players = {}
    self.deck = {}
    self.gameover = false
    return self
end

function GameState:getCurrentPlayer()
    return self.currentPlayer
end

function GameState:nextPlayer()
    self.currentPlayer = (self.currentPlayer % #self.players) + 1
end


return GameState