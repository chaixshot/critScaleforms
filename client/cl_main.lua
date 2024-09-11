CSform = setmetatable({
	showMQ = false,
    showRP = false,
    showMI = false,
    showST = false,
    showPW = false,
    showMDone = false,
    CreditsBanner = false,
    HeistBanner = false,
    toggleSave = false,
}, CSform)
CSform.__index = CSform
CSform.__call = function()
	return "csForm"
end

RegisterNetEvent("cS.banner")
AddEventHandler("cS.banner", function(title, subtitle, waitTime, playSound)
    local showBanner = true
    local scaleform = ShowBanner(title, subtitle)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    Citizen.CreateThread(function()
        Citizen.Wait((tonumber(waitTime) * 1000) - 400)
        scaleform:CallFunction("SHARD_ANIM_OUT", 2, 0.4, 0)
        Citizen.Wait(400)
        showBanner = false
    end)

    Citizen.CreateThread(function()
        while showBanner do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end
		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.missionQuit")
AddEventHandler("cS.missionQuit", function(title, subtitle, waitTime, playSound)
    CSform.showMQ = true
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end
    showMissionQuit(title, subtitle, waitTime)
    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        CSform.showMQ = false
    end)
end)

RegisterNetEvent("cS.resultsPanel")
AddEventHandler("cS.resultsPanel", function(title, subtitle, slots, waitTime, playSound)
    local showRP = true
    local scaleform = ShowResultsPanel(title, subtitle, slots)

    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        showRP = false
    end)

    Citizen.CreateThread(function()
        while showRP do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

		scaleform:CallFunction("CLEAR_ALL_SLOTS")
		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.missionInfo")
AddEventHandler("cS.missionInfo", function(data, x, y, width, waitTime, playSound)
    CSform.showMI = true

    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    ShowMissionInfoPanel(data, x, y, width)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        CSform.showMI = false
    end)
end)

RegisterNetEvent("cS.SplashText")
AddEventHandler("cS.SplashText", function(title, waitTime, playSound)
    CSform.showST = true

    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    ShowSplashText(title, waitTime * 1000)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        CSform.showST = false
    end)
end)

RegisterNetEvent("cS.PopupWarning")
AddEventHandler("cS.PopupWarning", function(title, subtitle, errorCode, waitTime, playSound)
    CSform.showPW = true

    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    showPopupWarning(title, subtitle, errorCode)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        CSform.showPW = false
    end)
end)

RegisterNetEvent("cS.Countdown")
AddEventHandler("cS.Countdown", function(_r, _g, _b, _waitTime, _playSound)
    local showCD = true
    local time = _waitTime
    local scaleform = showCountdown(time, _r, _g, _b)

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "Countdown_1", "DLC_AW_Frontend_Sounds", 0)
    end

    Citizen.CreateThread(function()
        while showCD do
            Citizen.Wait(1000)
            if time > 1 then
                time -= 1
                scaleform = showCountdown(time, _r, _g, _b)
				if _playSound ~= nil and _playSound == true then
					PlaySoundFrontend(-1, "Countdown_1", "DLC_AW_Frontend_Sounds", 0)
				end
				if time == 1 then
					PlaySoundFrontend(-1, "Countdown_Go", "DLC_AW_Frontend_Sounds", 0)
				end
            elseif time == 1 then
                time -= 1
                scaleform = showCountdown("GO", 0, 128, 255)
            else
                showCD = false
            end
        end
    end)

    Citizen.CreateThread(function()
        while showCD do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.MidsizeBanner")
AddEventHandler("cS.MidsizeBanner", function(_title, subtitle, _bannerColor, _waitTime, _playSound)
    local showMidBanner = true
    local scaleform = showMidsizeBanner(_title, subtitle, _bannerColor)

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    Citizen.CreateThread(function()
        Citizen.Wait((_waitTime * 1000) - 1000)
        scaleform:CallFunction("SHARD_ANIM_OUT", 2, 0.3, true)
        Citizen.Wait(1000)
        showMidBanner = false
    end)

    Citizen.CreateThread(function()
        while showMidBanner do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.Credits")
AddEventHandler("cS.Credits", function(_role, _nameString, _x, _y, _waitTime, _playSound)
    CSform.CreditsBanner = true

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    showCredits(_role, _nameString, _x, _y)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(_waitTime) * 1000)
        CSform.CreditsBanner = false
    end)
end)

RegisterNetEvent("cS.HeistFinale")
AddEventHandler("cS.HeistFinale", function(_initialText, _table, _money, _xp, _playSound, cb)
    CSform.HeistBanner = true

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

	local _waitTime = 2.5
	_waitTime = _waitTime+((#_table <= 7 and #_table or 7)) + 0.5

	if _money.startMoney ~= _money.finishMoney then
		_waitTime = _waitTime+3.5
	end

	if _xp.xpGained+_xp.xpBeforeGain >= _xp.maxLevelXP then
		_waitTime = _waitTime+5.5
	elseif _xp.xpGained ~= 0 then
		_waitTime = _waitTime+2.5
	end

    showHeist(_initialText, _table, _money, _xp, _waitTime)
	Citizen.Wait(tonumber(_waitTime) * 1000)

	CSform.HeistBanner = false
	if cb then
		cb()
	end
end)

RegisterNetEvent("cS.ChangePauseMenuTitle")
AddEventHandler("cS.ChangePauseMenuTitle", function(_title)
    ChangePauseMenuTitle(_title)
end)

RegisterNetEvent("cS.Saving")
AddEventHandler("cS.Saving", function(_subtitle, _type, _waitTime, _playSound)
    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    if _type == 1 then
        CSform.toggleSave = true
        showSaving(_subtitle)
    else
        ShowBusySpinnerNoScaleform(_subtitle)
    end

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(_waitTime) * 1000)
        if _type == 1 then
            CSform.toggleSave = false
        else
            BusyspinnerOff()
        end
    end)
end)

RegisterNetEvent("cS.Shutter")
AddEventHandler("cS.Shutter", function(_waitTime, _playSound)
    local showBanner = true
    local scaleform = ShowShutter()

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    Citizen.CreateThread(function()
        Citizen.Wait((tonumber(_waitTime) * 1000) - 1000)
        scaleform:CallFunction("CLOSE_THEN_OPEN_SHUTTER")
        Citizen.Wait(1000)
        showBanner = false
    end)

    Citizen.CreateThread(function()
        while showBanner do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.Warehouse")
AddEventHandler("cS.Warehouse", function(_waitTime, _playSound)
    local showBanner = true
    local scaleform = showWarehouse()

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end
    
    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        --scaleform.CallFunction(scale, false, "SET_INPUT_EVENT", 2)
        
        Citizen.Wait(2000)

        scaleform:CallFunction("GET_CURRENT_SELECTION") --we get the scaleform return

        local ret = EndScaleformMovieMethodReturnValue()
        while true do
            if IsScaleformMovieMethodReturnValueReady(ret) then --scaleform takes it's sweet time, so we need to wait for the value to be registered, or calculated or something, idk
                GetScaleformMovieMethodReturnValueInt(ret) --output value. Can be Int, String or Bool. In my case is Int, and it's the "slotID" value that you set with Scaleform:CallFunction("DISPLAY_VIEW", viewID, slotID)
                break
            end
            Citizen.Wait(0)
        end

        Citizen.Wait((tonumber(_waitTime) * 1000) - 4000)

        showBanner = false
    end)

    Citizen.CreateThread(function()
        while showBanner do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.MusicStudioMonitor")
AddEventHandler("cS.MusicStudioMonitor", function(_state, _waitTime)
    local showMonitor = true
    local scaleform = showMusicStudioMonitor(_state)

    Citizen.CreateThread(function()
        Citizen.Wait(_waitTime * 1000)
        showMonitor = false
    end)

    Citizen.CreateThread(function()
        while showMonitor do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

		scaleform:Dispose()
    end)
end)

RegisterNetEvent("cS.GameFeed")
AddEventHandler("cS.GameFeed", function(_title, _subtitle, _textblock, _textureDict, _textureName, _rightAlign, _waitTime, _playSound)
    local showBanner = true
    local scaleform = ShowGameFeed(_title, _subtitle, _textblock, _textureDict, _textureName, _rightAlign)

    if _playSound ~= nil and _playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end
    
    Citizen.CreateThread(function()
        Citizen.Wait(_waitTime * 1000)
        showBanner = false
    end)

    Citizen.CreateThread(function()
        while showBanner do
         scaleform:Draw2D()
            Citizen.Wait(0)
        end
		scaleform:Dispose()
    end)
end)
