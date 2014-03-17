 
 --[[----------------------------------------------------------
	MENU CONTROLS
	-----------------------------------------------------------
	* Set up controls for the menu component of FTC
	* Uses ZeniMax own virtual controls to create elements
	* Modifies addon saved variables
  ]]--

function FTC.Menu:Controls()
	
	-- Addon heading
	LAM:AddHeader( FTC.Menu.id , "FTC_Settings_Subtitle", "Foundry Tactical Combat - Version "  .. FTC.version )
	FTC_Settings_SubtitleLabel:SetHeight( 32 )
	FTC_Settings_SubtitleLabel:SetVerticalAlignment(1)
	FTC_Settings_SubtitleLabel:SetHorizontalAlignment(1)
	
	local desc = "Please use this menu to configure addon options."
	local label	= FTC.UI.Label( "FTC_Settings_SubtitleDescription" , FTC_Settings_Subtitle , { FTC_Settings_Subtitle:GetWidth() , 24} , {TOP,BOTTOM,0,0,FTC_Settings_SubtitleLabel} , "ZoFontGame" , nil , {1,1} , desc , false )	
	
	-- Toggle components
	LAM:AddHeader( FTC.Menu.id , "FTC_Settings_ComponentsHeader", "Configure Components")

	LAM:AddCheckbox( FTC.Menu.id , "FTC_Settings_ComponentsFrames", "Enable Frames", "Enable custom unit frames component?", function() return FTC.vars.EnableFrames end , function() FTC.Menu:Toggle( 'EnableFrames' , true ) end , true , "Reloads UI" )

	LAM:AddCheckbox( FTC.Menu.id , "FTC_Settings_ComponentsBuffs", "Enable Buffs", "Enable active buff tracking component?", function() return FTC.vars.EnableBuffs end , function() FTC.Menu:Toggle( 'EnableBuffs' , true ) end , true , "Reloads UI" )
	
	LAM:AddCheckbox( FTC.Menu.id , "FTC_Settings_ComponentsCastbar", "Enable Castbar", "Enable castbars component?", function() return FTC.vars.EnableCastbar end , function() FTC.Menu:Toggle( 'EnableCastbar' , true ) end , true , "Reloads UI" )
	
	LAM:AddCheckbox( FTC.Menu.id , "FTC_Settings_ComponentsSCT", "Enable Combat Text", "Enable scrolling combat text component?", function() return FTC.vars.EnableSCT end , function() FTC.Menu:Toggle( 'EnableSCT' , true ) end , true , "Reloads UI" )

	-- Unit frames settings
	if ( FTC.vars.EnableFrames ) then 
		LAM:AddHeader( FTC.Menu.id , "FTC_Settings_FramesHeader", "Unit Frames Settings")
		
		LAM:AddCheckbox( FTC.Menu.id , "FTC_Settings_FramesUnlock", "Lock Positions", "Modify unit frame positions?" , function() return not FTC.Frames.move end , function() FTC.Menu:MoveFrames() end )
	end

	--[[ Buffs settings
	if ( FTC.vars.EnableBuffs ) then 
		LAM:AddHeader( FTC.Menu.id , "FTC_Settings_BuffsHeader", "Buff Tracker Settings")
	end
	]]--
	
	-- Scrolling combat text settings
	if ( FTC.vars.EnableSCT ) then 
		LAM:AddHeader( FTC.Menu.id , "FTC_Settings_SCTHeader", "Scrolling Combat Text Settings")
		
		LAM:AddSlider( FTC.Menu.id , "FTC_Settings_SCTSpeed", "Combat Text Scroll Speed", "Adjust combat text scroll speed.", 1, 10, 1, function() return FTC.vars.SCTSpeed end, function( value ) FTC.Menu:Slider( "SCTSpeed" , value ) end )
		
		LAM:AddCheckbox( FTC.Menu.id , "FTC_Settings_SCTNames", "Display Ability Names", "Display ability names in combat text?", function() return FTC.vars.SCTNames end , function() FTC.Menu:Toggle( 'SCTNames' ) end , true , "Reloads UI" )
	end
	
	-- Restore defaults
	LAM:AddHeader( FTC.Menu.id , "FTC_Settings_ResetHeader", "Reset Settings")
	LAM:AddButton( FTC.Menu.id , "FTC_Settings_ResetButton", "Restore Defaults", "Restore FTC to default settings.", function() FTC.Menu:Reset() end , true , "Reloads UI" )

end