
--[[----------------------------------------------------------
    MENU OPTIONS COMPONENT
  ]]----------------------------------------------------------

    --[[ 
     * Initialize Menu Component
     * --------------------------------
     * Called by FTC:Initialize()
     * --------------------------------
     ]]--
    FTC.Menu = {}
    LAM2     = LibStub("LibAddonMenu-2.0")      
    function FTC.Menu:Initialize()

        -- Configure the master panel
        FTC.Menu.panel = { 
            type                = "panel", 
            name                = FTC.tag, 
            displayName         = GetString(FTC_ShortInfo),
            author              = "Atropos", 
            version             = FTC.version, 
            registerForRefresh  = true,
            registerForDefaults = true,
        }

        -- Setup the initial panel
        LAM2:RegisterAddonPanel( "FTC_Menu" , FTC.Menu.panel )

        -- Configure menu control options
        FTC.Menu:Controls()

        -- Setup the menus
        LAM2:RegisterOptionControls( "FTC_Menu", FTC.Menu.options )

        -- Register callback to detect when the menu is open
        CALLBACK_MANAGER:RegisterCallback("LAM-RefreshPanel" , function(panel) FTC.Menu:Reposition(panel) end )

        -- Register a callback to detect when the menu closes
        FTC_Menu:SetHandler( "OnHide", function(panel) FTC.Menu:Reposition(panel) end)
    end

    --[[ 
     * Reposition Elements During Menu
     * --------------------------------
     * Called by callback LAM-RefreshPanel
     * Called by handler FTC_Menu:OnHide()
     * --------------------------------
     ]]--
    function FTC.Menu:Reposition(panel)
        
        -- Bail if it's some other panel
        if ( panel ~= FTC_Menu ) then return end

        -- If the menu is shown, move some objects to the right side of the screen
        if ( not panel:IsHidden() ) then

            -- Unit Frames Display
            if ( FTC.init.Frames ) then 

                -- Show the player frame
                FTC_PlayerFrame:ClearAnchors()
                FTC_PlayerFrame:SetAnchor(LEFT,FTC_UI,CENTER,25,0)
                FTC_PlayerFrame:SetHidden(false)

                -- Spoof a shield on the player frame
                FTC.Frames:UpdateShield( 'player', math.floor(FTC.Player.health.max*.75) ,  FTC.Player.health.max )
            end

            -- Buff Tracking Display
            if ( FTC.init.Buffs ) then 

                -- Move buffs
                local offsetY = ( FTC.Vars.FrameHeight ~= nil ) and ( FTC.Vars.FrameHeight / 2 ) + 6 or 106
                FTC_PlayerBuffs:ClearAnchors()
                FTC_PlayerBuffs:SetAnchor(TOPLEFT,FTC_UI,CENTER,25,offsetY)
                FTC_PlayerDebuffs:ClearAnchors()
                FTC_PlayerDebuffs:SetAnchor(BOTTOMLEFT,FTC_UI,CENTER,25,-1 * offsetY)

                -- Spoof player buffs
                FTC.Buffs.Target = {}
                FTC.Menu.buffCounter = 1
                EVENT_MANAGER:RegisterForUpdate( "FTC_MenuBuffs" , 100 , function() FTC.Menu:FakeBuffs() end )
            end

            -- Combat Text Display
            if ( FTC.init.SCT ) then
                FTC_SCTIn:SetAnchor(LEFT,FTC_UI,CENTER,500,-50)
                EVENT_MANAGER:RegisterForUpdate( "FTC_MenuSCT" , 1000 , function() FTC.Menu:FakeSCT() end )
            end

            -- Combat Log Display
            if ( FTC.init.Log ) then 
                FTC_CombatLog:SetHidden(true) 
            end

            -- Show the UI layer
            FTC.inMenu = true
            FTC_UI:SetHidden(false)
            
        -- Otherwise, restore their positions
        else

            -- Unit Frames Display
            if ( FTC.init.Frames ) then 

                -- Reset the player frame
                FTC_PlayerFrame:ClearAnchors()
                local anchor = FTC.Vars.FTC_PlayerFrame
                FTC_PlayerFrame:SetAnchor(anchor[1],FTC_UI,anchor[2],anchor[3],anchor[4])

                -- Restore the correct shield
                local value, maxValue = GetUnitAttributeVisualizerEffectInfo('player',ATTRIBUTE_VISUAL_POWER_SHIELDING,STAT_MITIGATION,ATTRIBUTE_HEALTH,POWERTYPE_HEALTH)
                FTC.Frames:UpdateShield( 'player', value or 0 , maxValue or 0)
            end

            -- Buff Tracking Display
            if ( FTC.init.Buffs ) then 

                -- Move buffs
                FTC_PlayerBuffs:ClearAnchors()
                local anchor = FTC.Vars.FTC_PlayerBuffs
                FTC_PlayerBuffs:SetAnchor(anchor[1],FTC_UI,anchor[2],anchor[3],anchor[4])
                FTC_PlayerDebuffs:ClearAnchors()
                local anchor = FTC.Vars.FTC_PlayerDebuffs
                FTC_PlayerDebuffs:SetAnchor(anchor[1],FTC_UI,anchor[2],anchor[3],anchor[4])

                -- Restore buffs for player
                FTC.Buffs.Player = {}
                EVENT_MANAGER:UnregisterForUpdate( "FTC_MenuBuffs" )
                FTC.Buffs:GetBuffs('player')
            end

            -- Combat Text Display
            if ( FTC.init.SCT ) then
                local anchor    = FTC.Vars.FTC_SCTIn
                FTC_SCTIn:ClearAnchors()
                FTC_SCTIn:SetAnchor(anchor[1],FTC_UI,anchor[2],anchor[3],anchor[4])
                EVENT_MANAGER:UnregisterForUpdate( "FTC_MenuSCT" )
            end

            -- Combat Log Display
            if ( FTC.init.Log and not FTC.Vars.AlternateChat ) then FTC_CombatLog:SetHidden( false ) end

            -- Toggle visibility
            FTC.inMenu = false
            FTC:ToggleVisibility()
        end
    end

    --[[ 
     * Toggle Binary Variable
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:Toggle( setting , reload )
        
        -- Update the database
        FTC.Vars[setting] = not FTC.Vars[setting]
        
        -- Re-configure some things
        if ( FTC.init.Frames ) then FTC.Frames:SetupPlayer() end
        
        -- Maybe reload
        if reload then ReloadUI() end
    end

    --[[ 
     * Update Saved Variable
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:Update( setting , value , reload )
        FTC.Vars[setting] = value
        
        -- Maybe reload
        if reload then ReloadUI() end
    end

    --[[ 
     * Reset Settings to Default
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:Reset(context)

        -- Reset everything
        if ( context == nil ) then
            for var , value in pairs( FTC.Defaults ) do
                FTC.Vars[var] = value   
            end
            ReloadUI()

        -- Reset unit frames
        elseif ( context == "Frames" ) then
            for var , value in pairs( FTC.Frames.Defaults ) do
                FTC.Vars[var] = value   
            end
            FTC.Menu:UpdateFrames()

        -- Reset buff tracking
        elseif ( context == "Buffs" ) then
            for var , value in pairs( FTC.Buffs.Defaults ) do
                FTC.Vars[var] = value   
            end
            FTC.Menu:UpdateBuffs()

        -- Reset combat log
        elseif ( context == "Log" ) then
            for var , value in pairs( FTC.Log.Defaults ) do
                FTC.Vars[var] = value   
            end
            FTC.Menu:UpdateLog()            

        -- Reset combat text
        elseif ( context == "SCT" ) then
            for var , value in pairs( FTC.SCT.Defaults ) do
                FTC.Vars[var] = value   
            end

        -- Reset hotbar

        -- Reset damage statistics
        elseif ( context == "Stats" ) then
             for var , value in pairs( FTC.Stats.Defaults ) do
                FTC.Vars[var] = value   
            end
            FTC.Menu:UpdateStats()
        end
    end


--[[----------------------------------------------------------
     UNIT FRAMES
  ]]----------------------------------------------------------

    --[[ 
     * Live Update Unit Frames
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:UpdateFrames(setting,value,...)

        -- Maybe apply a new setting
        if ( setting ~= nil and value ~= nil ) then
            FTC.Vars[setting] = value
        end

        -- Rebuild the frames dynamically
        FTC.Frames:Controls()

        -- Reset the fade animation
        FTC.Frames.resetAnim = true

        -- Re-populate the frames
        FTC.Frames:SetupPlayer()
        FTC.Frames:SetupGroup()

        -- Position the frame for menu display
        FTC.Menu:Reposition(FTC_Menu)
    end



--[[----------------------------------------------------------
    BUFF TRACKING
  ]]----------------------------------------------------------

    --[[ 
     * Live Update Buff Tracking
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:UpdateBuffs(setting,value)

        -- Maybe apply a new setting
        if ( setting ~= nil and value ~= nil ) then
            FTC.Vars[setting] = value
        end

        -- Rebuild the frames dynamically
        FTC.Buffs:Controls()

        -- Change fonts for active buffs
        for _ , buff in pairs(FTC.Buffs.Pool.m_Active) do 
            buff.label = FTC.UI:Label( "FTC_Buff"..buff.id.."_Label", buff, {50,20},  {BOTTOM,BOTTOM,-1,-4}, FTC.UI:Font(FTC.Vars.BuffsFont1,FTC.Vars.BuffsFontSize,true) , {0.8,1,1,1}, {1,1}, nil, false )
            buff.name  = FTC.UI:Label( "FTC_Buff"..buff.id.."_Name",  buff, {450,20}, {LEFT,RIGHT,10,0},     FTC.UI:Font(FTC.Vars.BuffsFont2,FTC.Vars.BuffsFontSize,true) , {1,1,1,1}, {0,1}, "Buff Name", true )
        end

        -- Change fonts for free buffs
        for _ , buff in pairs(FTC.Buffs.Pool.m_Free) do 
            buff.label = FTC.UI:Label( "FTC_Buff"..buff.id.."_Label", buff, {50,20},  {BOTTOM,BOTTOM,-1,-4}, FTC.UI:Font(FTC.Vars.BuffsFont1,FTC.Vars.BuffsFontSize,true) , {0.8,1,1,1}, {1,1}, nil, false )
            buff.name  = FTC.UI:Label( "FTC_Buff"..buff.id.."_Name",  buff, {450,20}, {LEFT,RIGHT,10,0},     FTC.UI:Font(FTC.Vars.BuffsFont2,FTC.Vars.BuffsFontSize,true) , {1,1,1,1}, {0,1}, "Buff Name", true )
        end

        -- Position the frame for menu display
        FTC.Menu:Reposition(FTC_Menu)
    end

    --[[ 
     * Translate Buff Format Into Nicename
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:GetBuffFormat(value)

        -- Return the translated string
        if ( value == "disabled" )   then return GetString(FTC_BuffFormat0)
        elseif ( value == "htiles" ) then return GetString(FTC_BuffFormat1)
        elseif ( value == "vtiles" ) then return GetString(FTC_BuffFormat2)
        elseif ( value == "dlist" )  then return GetString(FTC_BuffFormat3)
        elseif ( value == "alist" )  then return GetString(FTC_BuffFormat4) end
    end

    --[[ 
     * Update Saved Buff Format
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:UpdateBuffFormat(setting,value)

        -- Assign the new variable setting
        if ( value == GetString(FTC_BuffFormat0) )     then FTC.Vars[setting] = "disabled"
        elseif ( value == GetString(FTC_BuffFormat1) ) then FTC.Vars[setting] = "htiles"
        elseif ( value == GetString(FTC_BuffFormat2) ) then FTC.Vars[setting] = "vtiles"
        elseif ( value == GetString(FTC_BuffFormat3) ) then FTC.Vars[setting] = "dlist"
        elseif ( value == GetString(FTC_BuffFormat4) ) then FTC.Vars[setting] = "alist" end

        -- Reconstruct the buff tracking component
        FTC.Menu:UpdateBuffs()
    end

    --[[ 
     * Fake Buffs and Debuffs for Examples
     * --------------------------------
     * Called by FTC.Menu:Reposition()
     * --------------------------------
     ]]--
    function FTC.Menu:FakeBuffs() 

        -- Get the time
        local time = GetFrameTimeSeconds()

        -- Fake Player Buff 1
        if ( FTC.Menu.buffCounter == 1 ) then
            if ( FTC.Buffs.Player["Player Buff 1"] == nil ) then
                local ability = {
                    ["owner"]   = FTC.Player.name,
                    ["name"]    = GetString(FTC_PlayerBuff) .. " 1",
                    ["dur"]     = 8000, 
                    ["cast"]    = 0,
                    ["debuff"]  = false,
                    ["tex"]     = '/esoui/art/icons/ability_rogue_006.dds',
                }
                FTC.Buffs:NewEffect( ability )
            elseif ( FTC.Buffs.Player["Player Buff 1"]["ends"] <= time + 1 ) then FTC.Buffs.Player["Player Buff 1"]["ends"] = time + 8 end

        -- Fake Player Buff 2
        elseif ( FTC.Menu.buffCounter == 2 ) then
            if ( FTC.Buffs.Player["Player Buff 2"] == nil ) then
                local ability = {
                    ["owner"]   = FTC.Player.name,
                    ["name"]    = GetString(FTC_PlayerBuff) .. " 2",
                    ["dur"]     = 12000, 
                    ["cast"]    = 0,
                    ["debuff"]  = false,
                    ["tex"]     = '/esoui/art/icons/ability_rogue_048.dds',
                }
                FTC.Buffs:NewEffect( ability )
            elseif ( FTC.Buffs.Player["Player Buff 2"]["ends"] <= time + 1 ) then FTC.Buffs.Player["Player Buff 2"]["ends"] = time + 12 end

        -- Fake Player Debuff 1
        elseif ( FTC.Menu.buffCounter == 3 ) then
            if ( FTC.Buffs.Player["Player Debuff 1"] == nil ) then
                local ability = {
                    ["owner"]   = FTC.Player.name,
                    ["name"]    = GetString(FTC_PlayerDebuff) .. " 1",
                    ["dur"]     = 7000, 
                    ["cast"]    = 0,
                    ["debuff"]  = true,
                    ["tex"]     = '/esoui/art/icons/ability_rogue_007.dds',
                }
                FTC.Buffs:NewEffect( ability )
            elseif ( FTC.Buffs.Player["Player Debuff 1"]["ends"] <= time + 1 ) then FTC.Buffs.Player["Player Debuff 1"]["ends"] = time + 7 end

        -- Fake Player Debuff 2
        elseif ( FTC.Menu.buffCounter == 4 ) then
            if ( FTC.Buffs.Player["Player Debuff 2"] == nil ) then
                local ability = {
                    ["owner"]   = FTC.Player.name,
                    ["name"]    = GetString(FTC_PlayerDebuff) .. " 2",
                    ["dur"]     = 6000, 
                    ["cast"]    = 0,
                    ["debuff"]  = true,
                    ["tex"]     = '/esoui/art/icons/ability_rogue_018.dds',
                }
                FTC.Buffs:NewEffect( ability )
            elseif ( FTC.Buffs.Player["Player Debuff 2"]["ends"] <= time + 1 ) then FTC.Buffs.Player["Player Debuff 2"]["ends"] = time + 6 end
        end

        -- Increment the counter
        FTC.Menu.buffCounter = ( FTC.Menu.buffCounter <= 4 ) and FTC.Menu.buffCounter + 1 or 1
    end


--[[----------------------------------------------------------
    COMBAT TEXT
  ]]----------------------------------------------------------

    --[[ 
     * Fake Scrolling Combat Text
     * --------------------------------
     * Called by FTC.Menu:Reposition()
     * --------------------------------
     ]]--
    function FTC.Menu:FakeSCT() 

        -- Register a fake SCT damage
        local damage    = {
            ["out"]     = false,
            ["result"]  = ACTION_RESULT_DAMAGE,
            ["target"]  = "fake",
            ["source"]  = FTC.Player.name,
            ["ability"] = GetString(FTC_FakeDamage),
            ["value"]   = 9100,
            ["ms"]      = GetGameTimeMilliseconds(),
            ["crit"]    = false,
            ["heal"]    = false,
            ["icon"]    = '/esoui/art/icons/ability_rogue_007.dds',
            ["mult"]    = 1, 
            ["weapon"]  = false,
        }
        FTC.SCT:Damage(damage)

        -- Register a fake SCT heal
        local heal    = {
            ["out"]     = false,
            ["result"]  = ACTION_RESULT_HEAL,
            ["target"]  = "fake",
            ["source"]  = FTC.Player.name,
            ["ability"] = GetString(FTC_FakeHeal),
            ["value"]   = 4300,
            ["ms"]      = GetGameTimeMilliseconds() + 500,
            ["crit"]    = true,
            ["heal"]    = true,
            ["icon"]    = '/esoui/art/icons/ability_mage_054.dds',
            ["mult"]    = 1, 
            ["weapon"]  = false,
        }
        FTC.SCT:Damage(heal)
    end

--[[----------------------------------------------------------
     COMBAT LOG
  ]]----------------------------------------------------------

    --[[ 
     * Update Combat Log Size and Position
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:MoveLog()

        -- Get the log
        local log = FTC_CombatLog
        
        -- Get the new position and dimensions
        local isValidAnchor, point, relativeTo, relativePoint, offsetX, offsetY = log:GetAnchor()
        local width , height = log:GetDimensions()

        -- Save the new settings
        if ( isValidAnchor ) then FTC.Vars[log:GetName()] = {point,relativeTo,relativePoint,offsetX,offsetY} end
        FTC.Vars.LogWidth = width
        FTC.Vars.LogHeight = height
    end

    --[[ 
     * Live Combat Log
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:UpdateLog(setting,value)

        -- Maybe apply a new setting
        if ( setting ~= nil and value ~= nil ) then
            FTC.Vars[setting] = value
        end

        -- Rebuild the log dynamically
        FTC.Log:Initialize()
    end

--[[----------------------------------------------------------
     DAMAGE STATISTICS
  ]]----------------------------------------------------------

    --[[ 
     * Update Statistics
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:UpdateStats(setting,value)

        -- Maybe apply a new setting
        if ( setting ~= nil and value ~= nil ) then
            FTC.Vars[setting] = value
        end

        -- Rebuild the log dynamically
        FTC.Stats:Controls()
    end

--[[----------------------------------------------------------
     REPOSITION ELEMENTS
  ]]----------------------------------------------------------

    --[[ 
     * Enable Re-Positioning Unit Frames
     * --------------------------------
     * Called by FTC.Menu:Controls()
     * --------------------------------
     ]]--
    function FTC.Menu:MoveFrames( move )

        -- Start by returning to the normal UI
        if ( SCENE_MANAGER:IsInUIMode() and not WINDOW_MANAGER:IsSecureRenderModeEnabled() ) then SCENE_MANAGER:SetInUIMode(false) end
        
        -- Unit Frames
        if ( FTC.init.Frames ) then
            local frames = { FTC_PlayerFrame , FTC_TargetFrame , FTC_GroupFrame , FTC_RaidFrame }
            for _ , frame in pairs(frames) do
                frame:SetMouseEnabled( move )
                frame:SetHidden( false )
                frame:SetAlpha(1)
                if ( frame.backdrop ~= nil ) then frame.backdrop:SetHidden(not move) end
                if ( frame.label ~= nil ) then frame.label:SetHidden(not move) end
            end

            -- If we are done moving, make sure frame visibility is correct
            if ( not move ) then FTC.Frames:SetupTarget() end
            if ( not move ) then FTC.Frames:SetupGroup() end
        end
        
        -- Buff Tracking
        if ( FTC.init.Buffs ) then
            local frames = { FTC_PlayerBuffs , FTC_PlayerDebuffs , FTC_LongBuffs , FTC_TargetBuffs , FTC_TargetDebuffs }
            for _ , frame in pairs(frames) do
                frame:SetMouseEnabled( move )
                frame:SetHidden( false )
                frame:SetAlpha(1)
                if ( frame.backdrop ~= nil ) then frame.backdrop:SetHidden(not move) end
                if ( frame.label ~= nil ) then frame.label:SetHidden(not move) end
            end
        end
      
        -- Display SCT
        if ( FTC.init.SCT ) then
            local frames = { FTC_SCTOut , FTC_SCTIn , FTC_SCTAlerts }
            for _ , frame in pairs(frames) do
                frame:SetMouseEnabled( move )
                frame:SetHidden( false )
                frame:SetAlpha(1)
                if ( frame.backdrop ~= nil ) then frame.backdrop:SetHidden(not move) end
                if ( frame.label ~= nil ) then frame.label:SetHidden(not move) end
            end            
        end

        -- Toggle the move status
        FTC.move = move
    end

    --[[ 
     * Update Saved Element Position
     * --------------------------------
     * Called by OnMouseUp() on movable elements
     * --------------------------------
     ]]--
    function FTC.Menu:SaveAnchor( control )
        
        -- Get the new position
        local isValidAnchor, point, relativeTo, relativePoint, offsetX, offsetY = control:GetAnchor()

        -- Save the anchors
        if ( isValidAnchor ) then FTC.Vars[control:GetName()] = {point,relativePoint,offsetX,offsetY,relativeTo} end
    end