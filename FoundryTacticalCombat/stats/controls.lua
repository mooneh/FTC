 
--[[----------------------------------------------------------
    DAMAGE STATISTICS CONTROLS
  ]]----------------------------------------------------------
  
function FTC.Stats:Controls()
	
	--[[----------------------------------------------------------
		MINI DAMAGE METER
	  ]]----------------------------------------------------------

	local DM 		= FTC.UI:Control(   "FTC_MiniMeter", 					FTC_UI, 	{240,32}, 				FTC.Vars.FTC_MiniMeter, 		false )
    DM.backdrop     = FTC.UI:Backdrop(  "FTC_MiniMeter_BG",               	DM,         "inherit",      		{CENTER,CENTER,0,0},            {0,0,0,0.25}, {0,0,0,0.5}, nil, false )
	DM:SetMouseEnabled( true )
	DM:SetMovable( true )
	DM:SetHandler( "OnMouseUp", function( self ) FTC.Menu:SaveAnchor( self ) end )
	DM:SetHandler( "OnMouseDoubleClick", function() FTC.Stats:Toggle() end )

	local damage	= FTC.UI:Control(   "FTC_MiniMeter_Dam", 				DM, 		{80,32}, 				{LEFT,LEFT,0,0}, 				false )
	damage.label	= FTC.UI:Label( 	"FTC_MiniMeter_DamLabel", 			damage, 	{48,32}, 				{RIGHT,RIGHT,0,0}, 				FTC.UI:Font("standard",16,true), {1,1,1,1}, {0,1}, "0", false )
	damage.icon     = FTC.UI:Texture(   "FTC_MiniMeter_DamIcon",       		damage,     {32,32},  				{LEFT,LEFT,0,-1},  				'/esoui/art/icons/poi/poi_battlefield_complete.dds', false )
	DM.damage		= damage

	local healing	= FTC.UI:Control(   "FTC_MiniMeter_Heal", 				DM, 		{80,32}, 				{LEFT,RIGHT,0,0,damage}, 		false )
	healing.label	= FTC.UI:Label( 	"FTC_MiniMeter_HealLabel", 			healing, 	{48,32}, 				{RIGHT,RIGHT,0,0}, 				FTC.UI:Font("standard",16,true), {1,1,1,1}, {0,1}, "0", false )
	healing.icon    = FTC.UI:Texture(   "FTC_MiniMeter_HealIcon",       	healing,    {26,26},  				{LEFT,LEFT,3,0},  				'/esoui/art/buttons/gamepad/pointsplus_up.dds', false )
	DM.healing		= healing

	local time		= FTC.UI:Control(   "FTC_MiniMeter_Time", 				DM, 		{80,32}, 				{LEFT,RIGHT,0,0,healing}, 		false )
	time.label		= FTC.UI:Label( 	"FTC_MiniMeter_TimeLabel", 			time, 		{48,32}, 				{RIGHT,RIGHT,0,0}, 				FTC.UI:Font("standard",16,true), {1,1,1,1}, {0,1}, "0:00" , false )
	time.icon    	= FTC.UI:Texture(   "FTC_MiniMeter_TimeIcon",       	time,    	{28,28},  				{LEFT,LEFT,2,0},  				'/esoui/art/mounts/timer_icon.dds', false )
	DM.time  		= time
	
	--[[----------------------------------------------------------
		EXPANDED ANALYTICS
	  ]]----------------------------------------------------------
	local FM 		= FTC.UI:TopLevelWindow( "FTC_Report", 					GuiRoot, 	{1000,1000}, 			{CENTER,CENTER,0,-50}, 			true )
	FM.backdrop 	= FTC.UI:Backdrop( 	"FTC_Report_Backdrop", 				FM, 		"inherit", 				{CENTER,CENTER,0,0}, 			{0,0,0,0.6}, {0,0,0,0.9}, nil, false )
	FM.dtitle 		= FTC.UI:Label( 	"FTC_Report_DamageTitle", 			FM, 		{950,50}, 				{TOPLEFT,TOPLEFT,25,25}, 		"ZoFontWindowTitle", {1,1,1,1}, {0,1}, GetString(FTC_DReport), false )
	FM.htitle		= FTC.UI:Label( 	"FTC_Report_HealingTitle", 			FM, 		{950,50}, 				{BOTTOMLEFT,BOTTOMLEFT,25,25}, 	"ZoFontWindowTitle", {1,1,1,1}, {0,1}, GetString(FTC_HReport), false )
	FM.close		= FTC.UI:Button(   	"FTC_Report_Close" ,    			FM,    		{48,48}, 				{TOPRIGHT,TOPRIGHT,-10,20},		BSTATE_NORMAL, nil, nil, nil, nil, nil, false )
	FM.close:SetNormalTexture('/esoui/art/buttons/closebutton_up.dds')
	FM.close:SetMouseOverTexture('/esoui/art/buttons/closebutton_mouseover.dds')
	FM.close:SetHandler("OnClicked", FTC.Stats.Toggle )
	FM.post			= FTC.UI:Button(   	"FTC_Report_Post" ,    				FM,    		{48,48}, 				{TOPRIGHT,TOPRIGHT,-75,10},		BSTATE_NORMAL, nil, nil, nil, nil, nil, false )
	FM.post:SetNormalTexture('/esoui/art/chatwindow/chat_notification_up.dds')
	FM.post:SetMouseOverTexture('/esoui/art/chatwindow/chat_notification_over.dds')
	FM.post:SetDisabledTexture('/esoui/art/chatwindow/chat_notification_disabled.dds')
	FM.post:SetHandler("OnClicked", FTC.Stats.Post )
	FM:SetMouseEnabled( true )

	-- Abilities Detail
	local abilities	= FTC.UI:Control(  "FTC_Report_Ability",   				FM,			{FM:GetWidth()-50,200}, {TOP,TOP,0,0}, 					true )
    local header  	= FTC.UI:Control(  "FTC_Report_Ability_Header",			abilities,	{FM:GetWidth()-50,50}, 	{TOP,TOP,0,0}, 					false )
    header.name   	= FTC.UI:Label(    "FTC_Report_Ability_Name",   		header,  	{225,50},  				{LEFT,LEFT,100,0}, 				FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, GetString(FTC_Ability), false )
    header.count 	= FTC.UI:Label(    "FTC_Report_Ability_Count",  		header,  	{50,50},  				{LEFT,RIGHT,0,0,header.name},  	FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, "#", false )
    header.total 	= FTC.UI:Label(    "FTC_Report_Ability_Total",  		header,  	{150,50},  				{LEFT,RIGHT,0,0,header.count},  FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, GetString(FTC_Damage), false )
    header.dps 		= FTC.UI:Label(    "FTC_Report_Ability_DPS",  			header,  	{100,50},  				{LEFT,RIGHT,0,0,header.total},  FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, GetString(FTC_DPS), false )
    header.crit 	= FTC.UI:Label(    "FTC_Report_Ability_Crit",   		header,  	{100,50},  				{LEFT,RIGHT,0,0,header.dps},  	FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, GetString(FTC_Crit), false )
    header.avg		= FTC.UI:Label(    "FTC_Report_Ability_Avg",   			header,  	{100,50},  				{LEFT,RIGHT,0,0,header.crit},  	FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, GetString(FTC_Average), false )
    header.max 		= FTC.UI:Label(    "FTC_Report_Ability_Max",   			header,  	{100,50},  				{LEFT,RIGHT,0,0,header.avg},  	FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, GetString(FTC_Max), false )
    abilities.header= header
    FM.abilities	= abilities

    -- Setup Target Pool
    if ( FTC.Stats.TargetPool == nil ) then FTC.Stats.TargetPool = ZO_ObjectPool:New( FTC.Stats.CreateTarget , function(object) FTC.Stats:Release(object) end ) end

    -- Setup Ability Pool
    if ( FTC.Stats.AbilityPool == nil ) then FTC.Stats.AbilityPool = ZO_ObjectPool:New( FTC.Stats.CreateAbility , function(object) FTC.Stats:Release(object) end ) end
end


--[[----------------------------------------------------------
    POOL FUNCTIONS
  ]]----------------------------------------------------------


	--[[ 
	 * Add New Target to Report Pool
	 * --------------------------------
	 * Called by FTC.Stats.TargetPool
	 * --------------------------------
	 ]]--
	function FTC.Stats.CreateTarget()

	    -- Get the pool and counter
	    local pool 		= FTC.Stats.TargetPool
	    local counter   = pool:GetNextControlId()
	    local parent	= FTC_Report

	    -- Create target
	    local control  	= FTC.UI:Control(  "FTC_Report_Target"..counter,     			parent,		{parent:GetWidth()-50,50},  {CENTER,CENTER,0,0}, 					false )
        control.backdrop= FTC.UI:Backdrop( "FTC_Report_Target"..counter.."_BG",         control,    "inherit",      			{TOP,TOP,0,0},            				{0,0,0,0.6}, {0,0,0,1}, FTC.UI.Textures["grainy"] , false )
	    control.name   	= FTC.UI:Label(    "FTC_Report_Target"..counter.."_Name",   	control,  	{350,50},  					{LEFT,LEFT,25,0,control.backdrop}, 		FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, "Target Name", false )
	    control.total 	= FTC.UI:Label(    "FTC_Report_Target"..counter.."_Total",  	control,  	{400,50},  					{LEFT,RIGHT,0,0,control.name},  		FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, "Total Damage", false )
	    control.dps 	= FTC.UI:Label(    "FTC_Report_Target"..counter.."_DPS",  		control,  	{200,50},  					{RIGHT,RIGHT,-25,0,control.backdrop},  	FTC.UI:Font("esobold",20,true), {1,1,1,1}, {0,1}, "DPS", false )
		control.expand	= FTC.UI:Button(   "FTC_Report_Target"..counter.."_Expand" ,    control,    {32,32}, 					{RIGHT,RIGHT,-25,0,control.backdrop},	BSTATE_NORMAL, nil, nil, nil, nil, nil, false )
		control.expand:SetNormalTexture('/esoui/art/buttons/pointsplus_up.dds')
		control.expand:SetMouseOverTexture('/esoui/art/buttons/pointsplus_over.dds')
		control.expand:SetPressedTexture('/esoui/art/buttons/pointsminus_up.dds')
		control.expand:SetPressedMouseOverTexture('/esoui/art/buttons/pointsminus_over.dds')
		control.expand:SetDisabledTexture('/esoui/art/buttons/pointsplus_disabled.dds')
		control.expand:SetDisabledPressedTexture('/esoui/art/buttons/pointsminus_disabled.dds')
		control.expand:SetHandler("OnClicked", FTC.Stats.ExpandTarget )

		-- Store some data
		control.state	= "collapsed"

	    -- Return target to pool
	    return control
	end

	--[[ 
	 * Add New Ability to Report Pool
	 * --------------------------------
	 * Called by FTC.Stats.AbilityPool
	 * --------------------------------
	 ]]--
	function FTC.Stats.CreateAbility()

	    -- Get the pool and counter
	    local pool 		= FTC.Stats.AbilityPool
	    local counter   = pool:GetNextControlId()
	    local parent	= FTC_Report_Ability

	    -- Create ability
	    local control  	= FTC.UI:Control(  "FTC_Report_Ability"..counter,     			parent,		{parent:GetWidth()-50,50}, 	{CENTER,CENTER,0,0}, 				false )
	    control.icon    = FTC.UI:Texture(  "FTC_Report_Ability"..counter.."_Icon",   	control,   	{48,48},  					{LEFT,LEFT,0,0},					'/esoui/art/icons/icon_missing.dds', false )
	    control.frame   = FTC.UI:Texture(  "FTC_Report_Ability"..counter.."_Frame",  	control,   	{50,50},    				{CENTER,CENTER,0,0,control.icon}, 	'/esoui/art/actionbar/icon_metal04.dds', false )
	    control.name   	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_Name",   	control,  	{225,50},  					{LEFT,RIGHT,25,0,control.frame}, 	FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "Ability Name", false )
	    control.count 	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_Count",  	control,  	{50,50},  					{LEFT,RIGHT,0,0,control.name},  	FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "Count", false )
	    control.total 	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_Total",  	control,  	{150,50},  					{LEFT,RIGHT,0,0,control.count},  	FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "Total", false )
	    control.dps 	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_DPS",  		control,  	{100,50},  					{LEFT,RIGHT,0,0,control.total},  	FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "DPS", false )
	    control.crit 	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_Crit",   	control,  	{100,50},  					{LEFT,RIGHT,0,0,control.dps},  		FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "Crit", false )
	    control.avg 	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_Avg",   	control,  	{100,50},  					{LEFT,RIGHT,0,0,control.crit},  	FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "Avg", false )
	    control.max 	= FTC.UI:Label(    "FTC_Report_Ability"..counter.."_Max",   	control,  	{100,50},  					{LEFT,RIGHT,0,0,control.avg},  		FTC.UI:Font("standard",20,true), {1,1,1,1}, {0,1}, "Max", false )
	    control.frame:SetDrawLayer(DL_OVERLAY)

	    -- Return ability to pool
	    return control
	end

	--[[ 
	 * Release Control to Pool Callback
	 * --------------------------------
	 * Called by FTC.Stats.TargetPool
	 * Called by FTC.Stats.AbilityPool
	 * --------------------------------
	 ]]--
	function FTC.Stats:Release(object)
	    object:SetHidden(true)
	end


