local GameState = {}
GameState.__index = GameState

function GameState.new(clubs)
    if clubs ~= nil and type(clubs) ~= "table" then
        error("Clubs müssen als Tabelle übergeben werden.", 2)
    end

    local self = setmetatable({}, GameState)
    self.currentClub = nil
    self.clubs = {}
    self.decks = {}
    self.gameover = false

    for clubIndex, clubSetup in ipairs(clubs or {}) do
        self.clubs[clubIndex] = {
            controller = clubSetup.controller,
            pawnImagePath = "assets/sprites/players/dummy_club_" .. clubIndex .. ".png",
            money = 1000000,
            points = 0,
            squarePosition = 0,
            dfbCup = true,
            euroCup = true,
            playersByStrength = {
                [1] = 1,
                [2] = 4,
                [3] = 3,
                [4] = 2,
                [5] = 1
            },
            cardHand = {}
        }
    end

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