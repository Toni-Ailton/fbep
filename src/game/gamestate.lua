local GameState = {}
GameState.__index = GameState

function GameState.new(players)
    if players ~= nil and type(players) ~= "table" then
        error("Spieler müssen als Tabelle übergeben werden.", 2)
    end

    local self = setmetatable({}, GameState)
    self.currentPlayer = nil
    self.players = players or {}
    self.decks = {}
    self.gameover = false

    if #self.players > 0 then
        self.currentPlayer = 1
    end

    return self
end

function GameState:getCurrentPlayer()
    return self.currentPlayer
end

function GameState:nextPlayer()
    if #self.players == 0 then
        error("Spieler müssen vor dem Wechsel eingerichtet werden.", 2)
    end
    if not self.currentPlayer then
        error("Es ist kein aktueller Spieler gesetzt.", 2)
    end

    self.currentPlayer = (self.currentPlayer % #self.players) + 1
end


return GameState