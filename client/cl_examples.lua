RegisterCommand("ba", function() --shows big banner
    TriggerEvent("CSform.banner", "~y~Test Banner~s~.", "You ~g~can ~r~use ~y~colors ~b~here ~s~too.", 5, true)
end, false)

RegisterCommand("mq", function() --"Mission Quit" scaleform. Low opacity black background with title and subtitle.
    TriggerEvent("CSform.missionQuit", "~y~Test Scaleform~s~.", "You ~g~can ~r~use ~y~colors ~b~here ~s~too.", 5, true)
end, false)

RegisterCommand("st", function() --"Splash Text" scaleform. This is a simple text in the middle of the scree, with cursive font.
    TriggerEvent("CSform.SplashText", "~y~Test Scaleform~s~.", 5, true)
end, false)

RegisterCommand("pw", function() --Popup Warning. Opaque black background, with Title, subtitle and an "error text" on the bottom left.
    TriggerEvent("CSform.PopupWarning", "~y~Test Scaleform~s~.", "You ~g~can ~r~use ~y~colors ~b~here ~s~too.", "ERROR 420: Scaleforms too hot.", 5, true)
end, false)

RegisterCommand("cd", function() --Race countdown. waitTime is also the starting number. Plays sound only at the start.
    TriggerEvent("CSform.Countdown", 0, 150, 200, 10, true)
end, false)

RegisterCommand("me", function() --midsize banner. Same as big banner, but midsized.
    TriggerEvent("CSform.MidsizeBanner", "~y~Test Scaleform~s~.", "You ~g~can ~r~use ~y~colors ~b~here ~s~too.", 2, 9, true)
end, false)

RegisterCommand("rp", function() --Results panel. _slots argument needs to be a table. slots[i].state can be 0 or 2 for "not selected" and 1 or 3 for "selected".
    local slots = {
        {name = "test1", state = 0},
        {name = "test2", state = 1},
        {name = "test3", state = 2},
        {name = "test4", state = 3},
    }
    TriggerEvent("CSform.resultsPanel", "~y~Test Scaleform~s~.", "You ~g~can ~r~use ~y~colors ~b~here ~s~too.", slots, 5, true)
end, false)

RegisterCommand("mi", function() --Mission info panel
    local data = {
        name = "Mission name",
        type = "Mission type",
        percentage = "15",
        rockstarVerified = true,
        playersRequired = "3",
        rp = 0,
        cash = 0,
        time = ""
    }
    TriggerEvent("CSform.missionInfo", data, 100, 300, 600, 500, 5, true)
end, false)

RegisterCommand("heist", function()
    --All 4 tables are required in order to proprer syncronize the scaleform.
    local _initialText = { --first slide. Consists of 3 text lines.
        missionTextLabel = "~y~BANK HEIST~s~", 
        passFailTextLabel = "PASSED.",
        messageLabel = "I don't even know why we have a third message.",
    }
    local _table = { --second slide. You can add as many "stats" as you want. They will appear from botton to top, so keep that in mind.
        -- {stat = "1", value = "1"},
        -- {stat = "2", value = "2"},
        -- {stat = "3", value = "3"},
        -- {stat = "4", value = "4"},
        -- {stat = "5", value = "5"},
        -- {stat = "6", value = "6"},
        -- {stat = "7", value = "7"},
        -- {stat = "8", value = "8"},
        -- {stat = "9", value = "9"},
        -- {stat = "10", value = "10"},
        -- {stat = "11", value = "11"},
        -- {stat = "12", value = "12"},
    }
    local _money = { --third slide. Incremental money. It will start from startMoney and increment to finishMoney. top and bottom text appear above/below the money string.
        startMoney = 3000,
        finishMoney = 53000,
        topText = "",
        bottomText = "",
        rightHandStat = "woah",
        rightHandStatIcon = 0, --0 or 1 = checked, 2 = X, 3 = no icon
    }
    local _xp = { --fourth and final slide. XP Bar slide. Will start with currentRank and a xp bar filled with (xpBeforeGain - minLevelXP) and will add xpGained. If you rank up, it goes to "Level Up" slide.
        xpGained = 8000,
        xpBeforeGain = 0,
        minLevelXP = 0,
        maxLevelXP = 0,
        currentRank = 0,
        nextRank = 0,
        rankTextSmall = "LEVEL UP.",
        rankTextBig = "~b~Nice.~s~",
    }
    TriggerEvent("CSform.HeistFinale", _initialText, _table, _money, _xp, true)
end, false)

RegisterCommand("credits", function() --Credit Block. You can add a role, and how many people you want. 8 _waitTimeSeconds should be the standard.
    --If you want more names in the namesString field, separate them with \n like in the example
    Citizen.CreateThread(function()
        TriggerEvent("CSform.Credits", "Test Role", "Name1 \n   Name 2", 0.4, 0.5, 8, true)
        Citizen.Wait(10*1000)
        TriggerEvent("CSform.Credits", "Decompiled scaleforms provided by", "Vespura", 0.7, 0.2, 8, false)
        Citizen.Wait(10*1000)
        TriggerEvent("CSform.Credits", "Third Credit Block", "Just for looks", 1.0, 0.15, 8, false)
    end)
end, false)

RegisterCommand("title", function(source, args)
    if args[1] ~= nil then
        local str = ""
        for k, v in pairs(args) do
            if k ~= nil then
                str = string.format("%s %s", str, tostring(args[k]))
            else
                break
            end
        end
        TriggerEvent("CSform.ChangePauseMenuTitle", str)
    else
        TriggerEvent("CSform.ChangePauseMenuTitle", "Please type a name after ~y~/title~s~.")
    end
end, false)

RegisterCommand("save", function(source, args) --Usage: /save You can write anything here
    local _message = ""
    for k, v in pairs(args) do
        if k ~= nil then
            _message = string.format("%s %s", _message, tostring(args[k]))
        else
            break
        end
    end
    TriggerEvent("CSform.Saving", _message, 1, 7, true) --type 1 = scalefrom. 2 or other = non-scaleform.
end, false)

RegisterCommand("save2", function(source, args) --Usage: /save You can write anything here
    local _message = ""
    for k, v in pairs(args) do
        if k ~= nil then
            _message = string.format("%s %s", _message, tostring(args[k]))
        else
            break
        end
    end
    TriggerEvent("CSform.Saving", _message, 2, 7, true) --type 1 = scalefrom. 2 or other = non-scaleform.
end, false)


RegisterCommand("shutter", function(source, args)
    TriggerEvent("CSform.Shutter", 7, true)
end, false)

RegisterCommand("whouse", function(source, args)
    TriggerEvent("CSform.Warehouse", 20, true)
end, false)

RegisterCommand("msm", function(source, args) --Usage: /msm STATE (0 = OFF | 1 = EDIT | 2 = PLAY)
    TriggerEvent("CSform.MusicStudioMonitor", tonumber(args[1]), 20)
end, false)

RegisterCommand("gamefeed", function(source, args)
    TriggerEvent("CSform.GameFeed", "_title", "_subtitle", "_textblock", "v_73_fib01_txd", "xj_v_fibscreen", false, 7, true)
end, false)
