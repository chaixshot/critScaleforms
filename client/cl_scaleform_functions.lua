---@class CSform
CSform = setmetatable({}, CSform)
CSform.__index = CSform
CSform.__call = function()
	return "csForm"
end

---Desplay countdown timer on center of screen
---@param red integer Red 0-255
---@param green integer Green 0-255
---@param blue integer Blue 0-255
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:Countdown
function CSform:Countdown(red, green, blue, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    end

    self.Show = true
    self.waitTime = waitTime
    self.scaleform = Scaleform.Request('COUNTDOWN')
    self.scaleform:CallFunction("SET_MESSAGE", self.waitTime, red, green, blue, true)
    self.scaleform:CallFunction("FADE_MP", self.waitTime, red, green, blue)

    self.Stop = function()
        self.Show = false
    end
 
    Citizen.CreateThread(function()
        while self.Show do
            Citizen.Wait(1000)
            if self.Show then
                if self.waitTime > 1 then
                    self.waitTime -= 1
                    self.scaleform:CallFunction("SET_MESSAGE", self.waitTime, red, green, blue, true)
                    self.scaleform:CallFunction("FADE_MP", self.waitTime, red, green, blue)

                    if playSound then
                      PlaySoundFrontend(-1, "MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    end
                elseif self.waitTime == 1 then
                    self.waitTime -= 1
                    self.scaleform:CallFunction("SET_MESSAGE", "GO", 0, 128, 255, true)
                    self.scaleform:CallFunction("FADE_MP", "GO", 0, 128, 255)
                else
                    self.Show = false
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end
		self.scaleform:Dispose()
    end)

    return self
end

---Shows big banner
---@param title string Text of title
---@param subtitle string Text of sub title
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowBanner
function CSform:ShowBanner(title, subtitle, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true
    self.scaleform = Scaleform.Request('MP_BIG_MESSAGE_FREEMODE')
    self.scaleform:CallFunction("SHOW_SHARD_CENTERED_MP_MESSAGE")
    self.scaleform:CallFunction("SHARD_SET_TEXT", title, subtitle, 0)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        Citizen.Wait((tonumber(waitTime) * 1000) - 400)
        self.scaleform:CallFunction("SHARD_ANIM_OUT", 2, 0.4, 0)
        Citizen.Wait(400)
        self.Show = false
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end
		self.scaleform:Dispose()
    end)

    return self
end

---This is a simple text in the middle of the scree, with cursive font
---@param title string Text of title
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowSplashText
function CSform:ShowSplashText(title, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true
    self.scaleform = Scaleform.Request('SPLASH_TEXT')
    self.scaleform:CallFunction("SET_SPLASH_TEXT", title, 5000, 255, 255, 255, 255)
    self.scaleform:CallFunction("SPLASH_TEXT_LABEL", title, 255, 255, 255, 255)
    self.scaleform:CallFunction("SPLASH_TEXT_COLOR", 255, 255, 255, 255)
    self.scaleform:CallFunction("SPLASH_TEXT_TRANSITION_OUT", waitTime*1000, 0)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end
        self.scaleform:Dispose()
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        self.Show = false
    end)

    return self
end

---comment
---@param title string Text of title
---@param subtitle string Text of sub title
---@param slots table Argument needs to be a table. slots[i].state can be 0 or 2 for "not selected" and 1 or 3 for "selected".
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowResultsPanel
function CSform:ShowResultsPanel(title, subtitle, slots, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true
    self.scaleform = Scaleform.Request('MP_RESULTS_PANEL')
    self.scaleform:CallFunction("SET_TITLE", title)
    self.scaleform:CallFunction("SET_SUBTITLE", subtitle)
    for i, k in ipairs(slots) do
        self.scaleform:CallFunction("SET_SLOT", i, slots[i].state, slots[i].name)
    end

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        self.Show = false
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end

		self.scaleform:CallFunction("CLEAR_ALL_SLOTS")
		self.scaleform:Dispose()
    end)

    return self
end


---Mission info panel
---@param data table<string, string, string, boolean, string, integer, integer, string>: { name, type, percentage, rockstarVerified, playersRequired, rp, cash, time }
---@param x integer X postion on screen
---@param y integer X postion on screen
---@param width integer Screen resolution width
---@param height integer Screen resolution width
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowMissionInfoPanel
function CSform:ShowMissionInfoPanel(data, x, y, width, height, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true
    self.scaleform = Scaleform.Request('MP_MISSION_NAME_FREEMODE')
    self.scaleform:CallFunction("SET_MISSION_INFO", data.name, data.type, "", data.percentage, "", data.rockstarVerified, data.playersRequired, data.rp, data.cash, data.time)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Render2DScreenSpace(x, y, width, height)
            Citizen.Wait(0)
        end
        
        self.scaleform:Dispose()
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        self.Show = false
    end)

    return self
end

---Low opacity black background with title and subtitle.
---@param title string Text of title
---@param subtitle string Text of sub title
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowMissionQuit
function CSform:ShowMissionQuit(title, subtitle, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end
    
    self.Show = true
    self.scaleform = Scaleform.Request('MISSION_QUIT')
    self.scaleform:CallFunction("SET_TEXT", title, subtitle)
    self.scaleform:CallFunction("TRANSITION_IN", 0)
    self.scaleform:CallFunction("TRANSITION_OUT", 3000)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end

        self.scaleform:Dispose()
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        self.Show = false
    end)

    return self
end

---Opaque black background, with Title, subtitle and an "error text" on the bottom left.
---@param title string Text of title
---@param subtitle string Text of sub title
---@param errorCode string
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowPopupWarning
function CSform:ShowPopupWarning(title, subtitle, errorCode, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end
    
    self.Show = true
    self.scaleform = Scaleform.Request('POPUP_WARNING')
    self.scaleform:CallFunction("SHOW_POPUP_WARNING", 500.0, title, subtitle, "", true, 0, errorCode)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end

        self.scaleform:Dispose()
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        self.Show = false
    end)

    return self
end

---Same as big banner, but midsized.
---@param title string Text of title
---@param subtitle string Text of sub title
---@param bannerColor integer https://docs.fivem.net/docs/game-references/hud-colors/
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowMidsizeBanner
function CSform:ShowMidsizeBanner(title, subtitle, bannerColor, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true
    self.scaleform = Scaleform.Request('MIDSIZED_MESSAGE')
    self.scaleform:CallFunction("SHOW_COND_SHARD_MESSAGE", title, subtitle, bannerColor, true)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end

		self.scaleform:Dispose()
    end)

    Citizen.CreateThread(function()
        Citizen.Wait((waitTime * 1000) - 1000)
        if self.Show then
            self.scaleform:CallFunction("SHARD_ANIM_OUT", 2, 0.3, true)
            Citizen.Wait(1000)
            self.Show = false
        end
    end)

    return self
end

---Credit Block. You can add a role, and how many people you want. 8 waitTime should be the standard.
---@param role string
---@param nameString string
---@param x integer X postion on screen
---@param y integer X postion on screen
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowCredits
function CSform:ShowCredits(role, nameString, x, y, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true
    self.scaleform = Scaleform.Request("OPENING_CREDITS")
    self.scaleform:CallFunction("TEST_CREDIT_BLOCK", role, nameString, 'left', 0.0, 50.0, 1, 5, 10, 10)

    self.Stop = function()
        self.Show = false
    end

    Citizen.CreateThread(function()
        --=================================--
            --SETUP_CREDIT_BLOCK might give more customization, but further testing needs to be done.
            --"HIDE" function completly breaks SETUP_CREDIT_BLOCK, which means to we need to rely on stopping the scaleform draw.
        --=================================--

        --ID | x_location | y_location | align (LEFT, CENTER, RIGHT) | fade_in_duration | fade_out_duration 
        --Scaleform:CallFunction("SETUP_CREDIT_BLOCK", 1, 0.0, 0.0, "LEFT", 10, 10)

        --ID | role | x_offset | colour | is_raw_text | language (ja / japanese, ko / korean, zh / chinese, default)
        --Scaleform:CallFunction("ADD_ROLE_TO_CREDIT_BLOCK", 1, role, 0.0, 4, true, "")

        --ID | list_of_names_divided_by_delimiter | x_offset | delimiter | is_raw_text
        --Scaleform:CallFunction("ADD_NAMES_TO_CREDIT_BLOCK", 1, name, 100.1, ";", true)

        --ID | step_duration | anim_in_style (X, Y, xrotation, yrotation, default) | anim_in_value
        --Scaleform:CallFunction("SHOW_CREDIT_BLOCK", 1, 2, "X", 1)

        --=================================================--
            --This is a single line text (duh). Text below combines "name" font and "role" color from credit block.
        --=================================================--
        
        --ID | fade_in_duration | fade_out_duration | x_location |  y_location | align (LEFT, CENTER, RIGHT)
        --Scaleform:CallFunction("SETUP_SINGLE_LINE", 1, 10, 10, 0.0, 0.0, "LEFT")

        --ID | text | font ($font2, $font5) | colour | is_raw_text | language (ja / japanese, ko / korean, zh / chinese, default) | y_offset
        --Scaleform:CallFunction("ADD_TEXT_TO_SINGLE_LINE", 1, "TEXT", "$font2", 4, true, "", 0.0)

        --ID | anim_in_style (X, Y, xrotation, yrotation, default) | anim_in_value
        --Scaleform:CallFunction("SHOW_SINGLE_LINE", 1, "X", 1)

        --ID | step_duration | anim_out_style (X, Y, xrotation, yrotation, default) | anim_out_value
        --Scaleform:CallFunction("SHOW_SINGLE_LINE", 1, 10, "X", 1)

        while self.Show do
            self.scaleform:Render2DScreenSpace(x, y, 1280, 720)
            Citizen.Wait(0)
        end

        self.scaleform:Dispose()
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        CSform.CreditsBanner = false
    end)

    return self
end

---comment
---@param initialText table<string, string, string>: { missionTextLabel, passFailTextLabel, messageLabel }
---@param dataTable table
---@param money table startMoney, finishMoney, topText, bottomText, rightHandStat, rightHandStatIcon
---@param xp table xpGained, xpBeforeGain, minLevelXP, maxLevelXP, currentRank, nextRank, rankTextSmall, rankTextBig 
---@param playSound boolean Play sound?
---@param cb function|nil
---@return CSform:ShowHeist
function CSform:ShowHeist(initialText, dataTable, money, xp, playSound, cb)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    local _waitTime = 2.5
	_waitTime = _waitTime+((#dataTable <= 7 and #dataTable or 7)) + 0.5
	if money.startMoney ~= money.finishMoney then
		_waitTime = _waitTime+3.5
	end
	if xp.xpGained+xp.xpBeforeGain >= xp.maxLevelXP then
		_waitTime = _waitTime+5.5
	elseif xp.xpGained ~= 0 then
		_waitTime = _waitTime+2.5
	end

    self.Show = true
    self.scaleform = Scaleform.Request('MP_CELEBRATION')
    self.scaleform_bg = Scaleform.Request('MP_CELEBRATION_FG')
    self.background = Scaleform.Request("MP_CELEBRATION_BG")
    self.background:CallFunction("SET_PAUSE_DURATION", _waitTime-1.0)
    self.background:CallFunction("CREATE_STAT_WALL", "ch", "HUD_COLOUR_BLACK", -1)
    self.background:CallFunction("ADD_SCORE_TO_WALL", "ch")
    self.background:CallFunction("ADD_BACKGROUND_TO_WALL", "ch", 80, 5)
    self.background:CallFunction("SHOW_STAT_WALL", "ch")

    self.Stop = function ()
        self.Show = false
    end

    Citizen.CreateThread(function()
        local scaleform_list = {
            self.scaleform,
            self.scaleform_bg,
        }

        for key, handle in pairs(scaleform_list) do
            handle:CallFunction("CREATE_STAT_WALL", 1, "HUD_COLOUR_FREEMODE_DARK", 1)
            handle:CallFunction("ADD_BACKGROUND_TO_WALL", 1, 80, 5)

            handle:CallFunction("ADD_MISSION_RESULT_TO_WALL", 1, initialText.missionTextLabel, initialText.passFailTextLabel, initialText.messageLabel, true, true, true)

            if dataTable[1] ~= nil then
                handle:CallFunction("CREATE_STAT_TABLE", 1, 20)

                for i, k in pairs(dataTable) do
                    if i <=7 then
                        handle:CallFunction("ADD_STAT_TO_TABLE", 1, 20, dataTable[i].stat, dataTable[i].value, true, true, false, false, 0)
                    end
                end

                handle:CallFunction("ADD_STAT_TABLE_TO_WALL", 1, 20)
            end

            if money.startMoney ~= money.finishMoney then
                handle:CallFunction("CREATE_INCREMENTAL_CASH_ANIMATION", 1, 20)
                handle:CallFunction("ADD_INCREMENTAL_CASH_WON_STEP", 1, 20, money.startMoney, money.finishMoney, money.topText, money.bottomText, money.rightHandStat, money.rightHandStatIcon, 3)
                handle:CallFunction("ADD_INCREMENTAL_CASH_ANIMATION_TO_WALL", 1, 20)
            end

            if xp.xpGained ~= 0 then
                handle:CallFunction("ADD_REP_POINTS_AND_RANK_BAR_TO_WALL", 1, xp.xpGained, xp.xpBeforeGain, xp.minLevelXP, xp.maxLevelXP, xp.currentRank, xp.nextRank, xp.rankTextSmall, xp.rankTextBig)
            end

            handle:CallFunction("SHOW_STAT_WALL", 1)
            handle:CallFunction("createSequence", 1, 1, 1)
        end

        while self.Show do
            DrawScaleformMovieFullscreen(self.background.handle, 255, 255, 255, 50, 0)
            HideHudAndRadarThisFrame()
            self.scaleform:Draw2D()
            self.scaleform_bg:Draw2D()

            Citizen.Wait(0)
        end

        self.scaleform:CallFunction("CLEANUP", 1)
        self.scaleform_bg:CallFunction("CLEANUP", 1)
        self.background:CallFunction("CLEANUP", "ch")
        self.scaleform:Dispose()
        self.scaleform_bg:Dispose()
        self.background:Dispose()

        AnimpostfxPlay("HeistCelebToast", 0, false)

        if cb then
            cb()
        end
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(_waitTime) * 1000)
        if self.Show then
            self.Show = false
        end
    end)

    return self
end

---Change pause menu title text
---@param title string Text of title
function CSform:ChangePauseMenuTitle(title)
    AddTextEntry('FE_THDR_GTAO', title)
end

---You can write anything here
---@param subtitle string Text of sub title
---@param saveType integer 1-2
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowSaving
function CSform:ShowSaving(subtitle, saveType, waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.saveType = saveType
    
    self.Stop = function ()
        if self.saveType == 1 then
            self.Show = false
        else
            BusyspinnerOff()
        end
    end

    if self.saveType == 1 then
        Citizen.CreateThread(function()
            self.Show = true
            self.scaleform = Scaleform.Request('HUD_SAVING')
            self.scaleform:CallFunction("SET_SAVING_TEXT_STANDALONE", 1, subtitle)
            self.scaleform:CallFunction("SHOW")

            while self.Show do
                self.scaleform:Render2DScreenSpace(680.0, 900.0, 350, 30)
                Citizen.Wait(0)
            end
        end)
    else
        BeginTextCommandBusyspinnerOn("STRING")
        AddTextComponentSubstringPlayerName(subtitle)
        EndTextCommandBusyspinnerOn(1)
    end

    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(waitTime) * 1000)
        if self.saveType == 1 then
            self.Show = false
        else
            BusyspinnerOff()
        end
    end)

    return self
end

---comment
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowWarehouse
function CSform:ShowWarehouse(waitTime, playSound)
    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end

    self.Show = true 
    self.scaleform = Scaleform.Request('WAREHOUSE')
    self.scaleform:CallFunction("SET_WAREHOUSE_DATA", 'nameLabel', 'locationLabel', 'txd', 'large', 16, 16, 50000, 1, 0)
    self.scaleform:CallFunction("SET_PLAYER_DATA", 'gamerTag', 'organizationName', 'sellerRating', 'numSales', 'totalEarnings')
    self.scaleform:CallFunction("SET_BUYER_DATA", 'buyerOrganization0', 'amount0', 'offerPrice0', 'buyerOrganization1', 'amount1', 'offerPrice1', 'buyerOrganization2', 'amount2', 'offerPrice2', 'buyerOrganization3', 'amount3', 'offerPrice3')

    self.scaleform:CallFunction("SHOW_OVERLAY", 'titleLabel', 'messageLabel', 'acceptButtonLabel', 'cancelButtonLabel', 'success')
    self.scaleform:CallFunction("SET_MOUSE_INPUT", 0.6, 0.6)


    self.Stop = function ()
        self.Show = false
    end

    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        --self.scaleform.CallFunction(scale, false, "SET_INPUT_EVENT", 2)
        Citizen.Wait(2000)
        self.scaleform:CallFunction("GET_CURRENT_SELECTION") --we get the scaleform return

        local ret = EndScaleformMovieMethodReturnValue()
        while true do
            if IsScaleformMovieMethodReturnValueReady(ret) then --scaleform takes it's sweet time, so we need to wait for the value to be registered, or calculated or something, idk
                GetScaleformMovieMethodReturnValueInt(ret) --output value. Can be Int, String or Bool. In my case is Int, and it's the "slotID" value that you set with Scaleform:CallFunction("DISPLAY_VIEW", viewID, slotID)
                break
            end
            Citizen.Wait(0)
        end

        Citizen.Wait((tonumber(waitTime) * 1000) - 4000)

        self.Show = false
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end

		self.scaleform:Dispose()
    end)

    return self
end

---comment
---@param state integer 0 = OFF, 1 = EDIT, 2 = PLAY
---@param waitTime integer 1-inf How long show on screen in second
---@return CSform:ShowMusicStudioMonitor
function CSform:ShowMusicStudioMonitor(state, waitTime)
    self.Show = true
    self.scaleform = Scaleform.Request('MUSIC_STUDIO_MONITOR')
    self.scaleform:CallFunction("SET_STATE", state)

    self.Stop = function ()
        self.Show = false
    end

    Citizen.CreateThread(function()
        Citizen.Wait(waitTime * 1000)
        self.Show = false
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            
            Citizen.Wait(0)
        end

		self.scaleform:Dispose()
    end)

    return self
end

---comment
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowShutter
function CSform:ShowShutter(waitTime, playSound)
    self.Show = true
    self.scaleform = Scaleform.Request('CAMERA_GALLERY')
    self.scaleform:CallFunction("CLOSE_THEN_OPEN_SHUTTER")
    self.scaleform:CallFunction("SHOW_PHOTO_FRAME", 1)
    self.scaleform:CallFunction("SHOW_REMAINING_PHOTOS", 1)
    self.scaleform:CallFunction("FLASH_PHOTO_FRAME")

    self.Stop = function ()
        self.Show = false
    end

    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end

    Citizen.CreateThread(function()
        Citizen.Wait((tonumber(waitTime) * 1000) - 1000)
        if self.Show then
            self.scaleform:CallFunction("CLOSE_THEN_OPEN_SHUTTER")
            Citizen.Wait(1000)
            self.Show = false
        end
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end

		self.scaleform:Dispose()
    end)

    return self
end

---comment
---@param title string Text of title
---@param subtitle string Text of sub title
---@param textblock string
---@param textureDirectory string
---@param textureName string
---@param rightAlign boolean
---@param waitTime integer 1-inf How long show on screen in second
---@param playSound boolean Play sound?
---@return CSform:ShowGameFeed
function CSform:ShowGameFeed(title, subtitle, textblock, textureDirectory, textureName, rightAlign, waitTime, playSound)
    self.Show = true
    self.scaleform = Scaleform.Request('GTAV_ONLINE')
    self.scaleform:CallFunction("SETUP_BIGFEED", rightAlign)
    self.scaleform:CallFunction("HIDE_ONLINE_LOGO")
    self.scaleform:CallFunction("SET_BIGFEED_INFO", "footer", textblock, 0, "", "", subtitle, "URL", title, 0)

    RequestStreamedTextureDict(textureDirectory, false)
    while not HasStreamedTextureDictLoaded(textureDirectory) do
        Citizen.Wait(0)
    end

    if playSound ~= nil and playSound == true then
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
    end
    
    self.scaleform:CallFunction("SET_BIGFEED_IMAGE", textureDirectory, textureName)
    self.scaleform:CallFunction("SET_NEWS_CONTEXT", 0)
    self.scaleform:CallFunction("FADE_IN_BIGFEED")

    self.Stop = function ()
        self.Show = false
    end

    Citizen.CreateThread(function()
        Citizen.Wait(waitTime * 1000)
        self.Show = false
    end)

    Citizen.CreateThread(function()
        while self.Show do
            self.scaleform:Draw2D()
            Citizen.Wait(0)
        end
		self.scaleform:Dispose()
    end)

    return self
end
