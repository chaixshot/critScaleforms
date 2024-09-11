RegisterNetEvent("CSform.banner")
AddEventHandler("CSform.banner", function(title, subtitle, waitTime, playSound)
    CSform:ShowBanner(title, subtitle, waitTime, playSound)
end)

RegisterNetEvent("CSform.missionQuit")
AddEventHandler("CSform.missionQuit", function(title, subtitle, waitTime, playSound)
    CSform:ShowMissionQuit(title, subtitle, waitTime, playSound)
end)

RegisterNetEvent("CSform.resultsPanel")
AddEventHandler("CSform.resultsPanel", function(title, subtitle, slots, waitTime, playSound)
    CSform:ShowResultsPanel(title, subtitle, slots, waitTime, playSound)
end)

RegisterNetEvent("CSform.missionInfo")
AddEventHandler("CSform.missionInfo", function(data, x, y, width, height, waitTime, playSound)
    CSform:ShowMissionInfoPanel(data, x, y, width, height, waitTime, playSound)
end)

RegisterNetEvent("CSform.SplashText")
AddEventHandler("CSform.SplashText", function(title, waitTime, playSound)
    CSform:ShowSplashText(title, waitTime, playSound)
end)

RegisterNetEvent("CSform.PopupWarning")
AddEventHandler("CSform.PopupWarning", function(title, subtitle, errorCode, waitTime, playSound)
    CSform:ShowPopupWarning(title, subtitle, errorCode, waitTime, playSound)
end)

RegisterNetEvent("CSform.Countdown")
AddEventHandler("CSform.Countdown", function(red, green, blue, waitTime, playSound)
    CSform:Countdown(red, green, blue, waitTime, playSound)
end)

RegisterNetEvent("CSform.MidsizeBanner")
AddEventHandler("CSform.MidsizeBanner", function(title, subtitle, bannerColor, waitTime, playSound)
    CSform:ShowMidsizeBanner(title, subtitle, bannerColor, waitTime, playSound)
end)

RegisterNetEvent("CSform.Credits")
AddEventHandler("CSform.Credits", function(role, nameString, x, y, waitTime, playSound)
    CSform:ShowCredits(role, nameString, x, y, waitTime, playSound)
end)

RegisterNetEvent("CSform.HeistFinale")
AddEventHandler("CSform.HeistFinale", function(initialText, table, money, xp, playSound, cb)
    CSform:ShowHeist(initialText, table, money, xp, playSound, cb)
end)

RegisterNetEvent("CSform.ChangePauseMenuTitle")
AddEventHandler("CSform.ChangePauseMenuTitle", function(title)
    CSform:ChangePauseMenuTitle(title)
end)

RegisterNetEvent("CSform.Saving")
AddEventHandler("CSform.Saving", function(subtitle, saveType, waitTime, playSound)
    CSform:ShowSaving(subtitle, saveType, waitTime, playSound)
end)

RegisterNetEvent("CSform.Shutter")
AddEventHandler("CSform.Shutter", function(waitTime, playSound)
    CSform:ShowShutter(waitTime, playSound)
end)

RegisterNetEvent("CSform.Warehouse")
AddEventHandler("CSform.Warehouse", function(waitTime, playSound)
    CSform:ShowWarehouse(waitTime, playSound)
end)

RegisterNetEvent("CSform.MusicStudioMonitor")
AddEventHandler("CSform.MusicStudioMonitor", function(state, waitTime)
    CSform:ShowMusicStudioMonitor(state, waitTime)
end)

RegisterNetEvent("CSform.GameFeed")
AddEventHandler("CSform.GameFeed", function(title, subtitle, textblock, textureDirectory, textureName, rightAlign, waitTime, playSound)
    CSform:ShowGameFeed(title, subtitle, textblock, textureDirectory, textureName, rightAlign, waitTime, playSound)
end)
