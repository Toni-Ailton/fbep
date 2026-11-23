local GameState = {}
GameState.__index = GameState

function GameState.new(clubs)
    if clubs ~= nil and type(clubs) ~= "table" then
        error("Clubs müssen als Tabelle übergeben werden.", 2)
    end

    local self = setmetatable({}, GameState)
    self.currentClub = nil
    self.clubs = clubs or {}
    self.decks = {}
    self.gameover = false

    if #self.clubs > 0 then
        self.currentClub = 1
    end

    return self
end

function GameState:getCurrentClub()
    return self.currentClub
end

function GameState:nextClub()
    if #self.clubs == 0 then
        error("Clubs müssen vor dem Wechsel eingerichtet werden.", 2)
    end
    if not self.currentClub then
        error("Es ist kein aktueller Club gesetzt.", 2)
    end

    self.currentClub = (self.currentClub % #self.clubs) + 1
end


return GameState