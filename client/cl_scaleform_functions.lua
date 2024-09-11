scalformTimer = {
    ['ShowBanner'] = {isShown = false, timer = 0},
    ['ShowSplashText'] = {isShown = false, timer = 0},
    ['ShowResultsPanel'] = {isShown = false, timer = 0},
    ['showMissionQuit'] = {isShown = false, timer = 0},
    ['showPopupWarning'] = {isShown = false, timer = 0},
    ['showCountdown'] = {isShown = false, timer = 0},
    ['showMidsizeBanner'] = {isShown = false, timer = 0},
    ['showSaving'] = {isShown = false, timer = 0},
}


function ShowBanner(_text1, _text2)
    local scaleform = Scaleform.Request('MP_BIG_MESSAGE_FREEMODE')
    scaleform:CallFunction("SHOW_SHARD_CENTERED_MP_MESSAGE")
    scaleform:CallFunction("SHARD_SET_TEXT", _text1, _text2, 0)
    return scaleform
end

function ShowSplashText(_text1, _fadeout)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request('SPLASH_TEXT')
        scaleform:CallFunction("SET_SPLASH_TEXT", _text1, 5000, 255, 255, 255, 255)
        scaleform:CallFunction("SPLASH_TEXT_LABEL", _text1, 255, 255, 255, 255)
        scaleform:CallFunction("SPLASH_TEXT_COLOR", 255, 255, 255, 255)
        scaleform:CallFunction("SPLASH_TEXT_TRANSITION_OUT", _fadeout, 0)
        while CSform.showST do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end
        scaleform:Dispose()
    end)
end

function ShowResultsPanel(_title, _subtitle, _slots)
    local scaleform = Scaleform.Request('MP_RESULTS_PANEL')
    scaleform:CallFunction("SET_TITLE", _title)
    scaleform:CallFunction("SET_SUBTITLE", _subtitle)
    for i, k in ipairs(_slots) do
        scaleform:CallFunction("SET_SLOT", i, _slots[i].state, _slots[i].name)
    end
    return scaleform
end

function ShowMissionInfoPanel(data, _x, _y, _width)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request('MP_MISSION_NAME_FREEMODE')
        scaleform:CallFunction("SET_MISSION_INFO", data.name, data.type, "", data.percentage, "", data.rockstarVerified, data.playersRequired, data.rp, data.cash, data.time)

        while CSform.showMI do
            local x = 0.5
            local y = 0.5
            local width = 1280
            local height = 720
            scaleform:Render2DScreenSpace(x, y, width, height)
            Citizen.Wait(0)
        end
        
        scaleform:Dispose()
    end)
end

function showMissionQuit(title, subtitle, duration)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request('MISSION_QUIT')
        scaleform:CallFunction("SET_TEXT", title, subtitle)
        scaleform:CallFunction("TRANSITION_IN", 0)
        scaleform:CallFunction("TRANSITION_OUT", 3000)
        
        while CSform.showMQ do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

        scaleform:Dispose()
    end)
end

function showPopupWarning(title, subtitle, errorCode)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request('POPUP_WARNING')
        scaleform:CallFunction("SHOW_POPUP_WARNING", 500.0, title, subtitle, "", true, 0, errorCode)

        while CSform.showPW do
            scaleform:Draw2D()
            Citizen.Wait(0)
        end

        scaleform:Dispose()
    end) 
end

function showCountdown(_number, _r, _g, _b)
    local scaleform = Scaleform.Request('COUNTDOWN')

    scaleform:CallFunction("SET_MESSAGE", _number, _r, _g, _b, true)
    scaleform:CallFunction("FADE_MP", _number, _r, _g, _b)

    return scaleform
end

function showMidsizeBanner(_title, _subtitle, _bannerColor)
    local scaleform = Scaleform.Request('MIDSIZED_MESSAGE')

    scaleform:CallFunction("SHOW_COND_SHARD_MESSAGE", _title, _subtitle, _bannerColor, true)

    return scaleform
end

function showCredits(role, name, x, y)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request("OPENING_CREDITS")
        scaleform:CallFunction("TEST_CREDIT_BLOCK", role, name, 'left', 0.0, 50.0, 1, 5, 10, 10)
        
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

        while CSform.CreditsBanner do
            scaleform:Render2DScreenSpace(x, y, 1280, 720)
            Citizen.Wait(0)
        end

        scaleform:Dispose()
    end)
end --NEED TO BE REWORKED

function showHeist(_initialText, _table, money, xp, _waitTime)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request('MP_CELEBRATION')
        local scaleform_bg = Scaleform.Request('MP_CELEBRATION_FG')
        local background = Scaleform.Request("MP_CELEBRATION_BG")
        background:CallFunction("SET_PAUSE_DURATION", _waitTime-1.0)
        background:CallFunction("CREATE_STAT_WALL", "ch", "HUD_COLOUR_BLACK", -1)
        background:CallFunction("ADD_SCORE_TO_WALL", "ch")
        background:CallFunction("ADD_BACKGROUND_TO_WALL", "ch", 80, 5)
        background:CallFunction("SHOW_STAT_WALL", "ch")

        local scaleform_list = {
            scaleform,
            scaleform_bg,
        }

        for key, handle in pairs(scaleform_list) do
            handle:CallFunction("CREATE_STAT_WALL", 1, "HUD_COLOUR_FREEMODE_DARK", 1)
            handle:CallFunction("ADD_BACKGROUND_TO_WALL", 1, 80, 5)

            handle:CallFunction("ADD_MISSION_RESULT_TO_WALL", 1, _initialText.missionTextLabel, _initialText.passFailTextLabel, _initialText.messageLabel, true, true, true)

            if _table[1] ~= nil then
                handle:CallFunction("CREATE_STAT_TABLE", 1, 20)

                for i, k in pairs(_table) do
                    if i <=7 then
                        handle:CallFunction("ADD_STAT_TO_TABLE", 1, 20, _table[i].stat, _table[i].value, true, true, false, false, 0)
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

        local timer = GetGameTimer()
        while CSform.HeistBanner do
            DrawScaleformMovieFullscreen(background.handle, 255, 255, 255, 50, 0)
            HideHudAndRadarThisFrame()
            scaleform:Draw2D()
            scaleform_bg:Draw2D()

            Citizen.Wait(0)
        end

        scaleform:CallFunction("CLEANUP", 1)
        scaleform_bg:CallFunction("CLEANUP", 1)
        background:CallFunction("CLEANUP", "ch")
        scaleform:Dispose()
        scaleform_bg:Dispose()
        background:Dispose()

        AnimpostfxPlay("HeistCelebToast", 0, false)
    end)
end

function ChangePauseMenuTitle(title)
    AddTextEntry('FE_THDR_GTAO', title)
end

function showSaving(subtitle)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.Request('HUD_SAVING')
        scaleform:CallFunction("SET_SAVING_TEXT_STANDALONE", 1, subtitle)
        scaleform:CallFunction("SHOW")

        while CSform.toggleSave do
            scaleform:Render2DScreenSpace(680.0, 900.0, 350, 30)
            Citizen.Wait(0)
        end
    end)
end

function showWarehouse()
    local scaleform = Scaleform.Request('WAREHOUSE')
    scaleform:CallFunction("SET_WAREHOUSE_DATA", 'nameLabel', 'locationLabel', 'txd', 'large', 16, 16, 50000, 1, 0)
    scaleform:CallFunction("SET_PLAYER_DATA", 'gamerTag', 'organizationName', 'sellerRating', 'numSales', 'totalEarnings')
    scaleform:CallFunction("SET_BUYER_DATA", 'buyerOrganization0', 'amount0', 'offerPrice0', 'buyerOrganization1', 'amount1', 'offerPrice1', 'buyerOrganization2', 'amount2', 'offerPrice2', 'buyerOrganization3', 'amount3', 'offerPrice3')

    scaleform:CallFunction("SHOW_OVERLAY", 'titleLabel', 'messageLabel', 'acceptButtonLabel', 'cancelButtonLabel', 'success')
    scaleform:CallFunction("SET_MOUSE_INPUT", 0.6, 0.6)

    return scaleform
end

function showMusicStudioMonitor(state)
    local scaleform = Scaleform.Request('MUSIC_STUDIO_MONITOR')
    scaleform:CallFunction("SET_STATE", state)

    return scaleform
end

function ShowBusySpinnerNoScaleform(_text)
    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(_text)
    EndTextCommandBusyspinnerOn(1)
end

function ShowShutter()
    local scaleform = Scaleform.Request('CAMERA_GALLERY')
    scaleform:CallFunction("CLOSE_THEN_OPEN_SHUTTER")
    scaleform:CallFunction("SHOW_PHOTO_FRAME", 1)
    scaleform:CallFunction("SHOW_REMAINING_PHOTOS", 1)
    scaleform:CallFunction("FLASH_PHOTO_FRAME")

    return scaleform
end

function ShowGameFeed(title, subtitle, textblock, textureDirectory, textureName, rightAlign)
    local scaleform = Scaleform.Request('GTAV_ONLINE')

    scaleform:CallFunction("SETUP_BIGFEED", rightAlign)
    scaleform:CallFunction("HIDE_ONLINE_LOGO")
    scaleform:CallFunction("SET_BIGFEED_INFO", "footer", textblock, 0, "", "", subtitle, "URL", title, 0)

    RequestStreamedTextureDict(textureDirectory, false)
    while not HasStreamedTextureDictLoaded(textureDirectory) do
        Citizen.Wait(0)
    end
    
    scaleform:CallFunction("SET_BIGFEED_IMAGE", textureDirectory, textureName)
    scaleform:CallFunction("SET_NEWS_CONTEXT", 0)
    scaleform:CallFunction("FADE_IN_BIGFEED")
    
    return scaleform
end
