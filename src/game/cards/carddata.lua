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
                        maxResolutions = 1
                    },
                    red = {
                        displayText = "Dummy Red Card",
                        eventId = "event_002",
                        resolution = "immediate",
                        maxResolutions = 1
                    }
                }
            },
            {
                id = "bad_event_02",
                options = {
                    yellow = {
                        displayText = "Dummy Yellow Card",
                        eventId = "event_003",
                        resolution = "immediate",
                        maxResolutions = 1
                    },
                    red = {
                        displayText = "Dummy Red Card",
                        eventId = "event_004",
                        resolution = "holdUntilTrigger",
                        trigger = "homeMatch",
                        maxResolutions = 1
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
                optional = false,
                event = {
                    displayText = "Dummy Good Event",
                    eventId = "event_003",
                    resolution = "immediate",
                    maxResolutions = 1
                }
            },
            {
                id = "good_event_02",
                optional = true,
                respondsToBadEvent = "yellow"
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