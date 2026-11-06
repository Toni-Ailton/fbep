-- src/game/cards/card_data.lua
return {
    badEvent = {
        backsideImage = "badEvent",
        cards = {
            {
                id = "bad_event_01",
                eventIdYellow = "event_001",
                eventIdRed = "event_002"
            }
        }
    },

    goodEvent = {
        backsideImage = "goodEvent",
        cards = {
            {
                id = "good_event_01",
                eventId = "event_003"
            }
        }
    },

    dfbCup = {
        backsideImage = "dfbCup",
        cards = {
            {
                id = "dfb_cup_01",
                matchId = "match_001"
            }
        }
    },

    euroCup = {
        backsideImage = "euroCup",
        cards = {
            {
                id = "euro_cup_01",
                matchIdChampion = "match_002",
                matchIdUefa = "match_003"
            }
        }
    }
}