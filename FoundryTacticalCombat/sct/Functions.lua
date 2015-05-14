 
--[[----------------------------------------------------------
    SCROLLING COMBAT TEXT COMPONENT
  ]]----------------------------------------------------------

    FTC.SCT = {}
    FTC.SCT.Defaults = {
        ["SCTCount"]                = 20,
        ["SCTSpeed"]                = 3,
        ["SCTNames"]                = true,



        --["SCTPath"]                 = 'Arc',

        ["FTC_SCTOut"]              = {RIGHT,CENTER,-200,-50},
        ["FTC_SCTIn"]               = {LEFT,CENTER,200,-50},

        
        --["FTC_SCTStatus"]         = {TOP,FTC_UI,TOP,0,80},

        ["SCTFontSize"]             = 20,
    }
    FTC:JoinTables(FTC.Defaults,FTC.SCT.Defaults)

--[[----------------------------------------------------------
    SCT FUNCTIONS
  ]]----------------------------------------------------------

    --[[ 
     * Initialize SCT Component
     * --------------------------------
     * Called by FTC:Initialize()
     * --------------------------------
     ]]--
    function FTC.SCT:Initialize()

        -- Setup tables
        FTC.SCT.In      = {}
        FTC.SCT.Out     = {}
        FTC.SCT.Status  = {}

        -- Alterante objects
        FTC.SCT.count   = 1
        
        -- Save tiny AP gains
        --FTC.SCT.backAP    = 0
        
        -- Create controls
        FTC.SCT:Controls()
        
        -- Register init status
        FTC.init.SCT = true

        -- Activate updating
        EVENT_MANAGER:RegisterForUpdate( "FTC_SCTOut" , nil , function() FTC.SCT:Update('Out') end )
        EVENT_MANAGER:RegisterForUpdate( "FTC_SCTIn" , nil , function() FTC.SCT:Update('In') end )
    end


--[[----------------------------------------------------------
    EVENT HANDLERS
 ]]-----------------------------------------------------------

    --[[ 
     * Process new SCT events
     * --------------------------------
     * Called by FTC.Damage:New()
     * --------------------------------
     ]]--
    function FTC.SCT:New( damage )

        -- Bail if nothing was passed
        if ( damage == nil ) then return end

        -- Determine context
        local context = ( damage.out ) and "Out" or "In"
        local container = _G["FTC_SCT"..context]

        -- Otherwise, see if there is an existing event to fold into
        local isNew = true
        if ( #FTC.SCT[context] ~= 0 ) then
            for i = 1, #FTC.SCT[context] do

                -- Identical damage must have the same name, heal status, crit status, and approximate timestamp
                local dam = FTC.SCT[context][i]
                if ( ( damage.ability == dam.ability ) and ( dam.heal == damage.heal ) and ( dam.crit == damage.crit ) and ( math.abs( dam.ms - damage.ms ) <= 500 ) ) then

                    -- Add the multiplier
                    local mult = FTC.SCT[context][i].mult + 1
                    FTC.SCT[context][i].mult = mult

                    -- Update labels
                    local value = ( damage.value >= 1000 ) and zo_roundToNearest( damage.value / 1000 , 0.1 ) .. "k" or damage.value
                    dam.control.value:SetText(value .. " [x" .. mult .. "]")
                    
                    -- Bail out
                    isNew = false
                    break
                end
            end
        end

        -- Otherwise ALSO insert for now
        if ( isNew ) then

            -- Assign SCT to control from pool
            local pool = FTC.SCT[context.."Pool"]
            local control, objectKey = pool:AcquireObject()
            control:ClearAnchors()
            control:SetParent(container)
            control.id = objectKey

            -- Compute starting offsets
            local  offsets = {}
            if     ( FTC.SCT.count == 1 )   then offsets = {0,-50} 
            elseif ( FTC.SCT.count == 2 )   then offsets = {100,0}
            elseif ( FTC.SCT.count == 3 )   then offsets = {0,50}
            elseif ( FTC.SCT.count == 4 )   then offsets = {-100,0} end
            control.offsetX , control.offsetY = unpack(offsets)
            control:SetDrawTier( FTC.SCT.count % 2 == 0 and DT_MEDIUM or DT_LOW )
            FTC.SCT.count = ( FTC.SCT.count % 4 == 0 ) and 1 or FTC.SCT.count + 1

            -- Determine labels
            local value = ( damage.value >= 1000 ) and zo_roundToNearest( damage.value / 1000 , 0.1 ) .. "k" or damage.value
            local size  = ( damage.crit ) and FTC.Vars.SCTFontSize + 8 or FTC.Vars.SCTFontSize
            local name  = zo_strformat("<<!aC:1>>",damage.ability)

            -- Determine color
            local color = {0.8,0,0} 
            if ( damage.heal ) then color = {0.6,0.8,0.2}
            elseif ( damage.out ) then color = {0.7,0.5,0.2} end

            -- Assign data to the control
            control.value:SetText(value)
            control.value:SetFont(FTC.UI:Font("esobold",size+2,true))
            control.value:SetColor(unpack(color))

            control.name:SetText(name)
            control.name:SetFont(FTC.UI:Font("esobold",size,true))
            control.name:SetColor(unpack(color))

            control.icon:SetTexture(damage.icon)
            control:SetHidden(false)
            control:SetAlpha(0)

            -- Add the damage to the table
            damage.control = control
            table.insert( FTC.SCT[context] , damage ) 

            -- Start fade animation
            FTC.SCT:Fade(control)
        end
    end


--[[----------------------------------------------------------
    UPDATING FUNCTIONS
 ]]-----------------------------------------------------------

    --[[ 
     * Render Scrolling Combat Text
     * --------------------------------
     * Called by FTC.SCT:Initialize()
     * --------------------------------
     ]]--
    function FTC.SCT:Update(context)

        -- Get the SCT UI element
        local parent  = _G["FTC_SCT"..context]
        local Damages = FTC.SCT[context]

        -- Bail if no damage is present
        if ( #Damages == 0 ) then return end
        
        -- Get the game time
        local ms = GetGameTimeMilliseconds()
        
        -- Traverse damage table back-to-front
        for i = #Damages,1,-1 do

            -- Get the control and it's damage value
            local damage    = Damages[i]
            local control   = damage.control

            -- Compute the animation duration ( speed = 10 -> 0.5 second, speed = 1 -> 5 seconds )
            local lifespan  = ( ms - damage.ms ) / 1000
            local duration  = ( 11 - FTC.Vars.SCTSpeed ) / 2

            -- Purge expired damages
            if ( lifespan > duration ) then
                table.remove(FTC.SCT[context],i) 
                local pool = FTC.SCT[context.."Pool"]
                pool:ReleaseObject(control.id)

            -- Otherwise go ahead
            else 

                -- Get the starting offsets
                local height    = parent:GetHeight()
                local width     = parent:GetWidth()
                local offsetX   = control.offsetX           
                local offsetY   = control.offsetY + ( -1 * height ) * ( lifespan / duration )   

                -- Horizontal arcing
                if ( true ) then
                    local ease      = lifespan / duration
                    local arc       = width * ( ( 4 * ease * ease ) - ( 4 * ease ) + 1 ) 
                    offsetX         = ( damage.out ) and offsetX + arc or offsetX - arc
                end

                -- Adjust the position
                control:SetAnchor(BOTTOM,parent,BOTTOM,offsetX,offsetY)

            
            --[[
                -- Flag blocked damage
                if ( damage.result == ACTION_RESULT_BLOCKED_DAMAGE ) then
                    dam     = "|c990000(" .. dam .. ")|"
                
                -- Flag damage immunity
                elseif ( damage.result == ACTION_RESULT_IMMUNE ) then
                    dam     = "|c990000(Immune)|"
                    
                -- Dodges
                elseif ( damage.result == ACTION_RESULT_DODGED ) then
                    dam     = "|c990000(Dodge)|"
                    
                -- Misses
                elseif ( damage.result == ACTION_RESULT_MISS ) then
                    dam     = "|c990000(Miss)|"
                
                -- Flag heals
                elseif( damage.heal == true ) then
                    dam = "|c99DD93" .. dam .. "|"
                    if string.match( damage.name , "Potion" ) then damage.name = "Health Potion" end
                
                -- Magic damage
                elseif ( damage.type ~= DAMAGE_TYPE_PHYSICAL    ) then
                    dam = ( context == "Out" ) and "|c336699" .. dam .. "|" or "|c990000" .. dam .. "|"
                
                -- Standard hits
                else
                    dam = ( context == "Out" ) and "|cAA9F83" .. dam .. "|" or "|c990000" .. dam .. "|"
                end 
                ]]
            end
        end
    end