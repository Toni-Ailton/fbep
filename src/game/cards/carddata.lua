-- src/game/cards/carddata.lua
return {
    badEvent = {
        backsideImage = "badEvent",
        cards = {
            {
                id = "bad_event_01",
                options = {
                    yellow = {
                        displayText = "Dummy Yellow Card",
                        eventId = "event_001",
                        resolution = "immediate",
                        mayKeep = false,
                        duration = 1
                    },
                    red = {
                        displayText = "Dummy Red Card",
                        eventId = "event_002",
                        resolution = "holdUntilTrigger",
                        mayKeep = false,
                        duration = 1
                    }
                }
            }
        }
    },

    goodEvent = {
        backsideImage = "goodEvent",
        cards = {
            {
                id = "good_event_01",
                event = {
                    displayText = "Dummy Good Event",
                    eventId = "event_003",
                    resolution = "immediate",
                    mayKeep = false,
                    duration = 1
                }
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