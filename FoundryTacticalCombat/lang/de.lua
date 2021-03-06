
--[[----------------------------------------------------------
    GERMAN LANGUAGE LOCALIZATION
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Name",               "Foundry Tactical Combat")
ZO_CreateStringId("FTC_ShortInfo",          "Foundry Tactical Combat by Atropos")
ZO_CreateStringId("FTC_LongInfo",           "Du benutzt die Foundry Tactical Combat Version " .. FTC.version .. " entwickelt von Atropos der Tamriel Foundry.")

--[[----------------------------------------------------------
    KEYBINDINGS
  ]]----------------------------------------------------------
ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_COMBAT_LOG", "Aktiviere den Kampflog")
--ZO_CreateStringId("SI_BINDING_NAME_DISPLAY_DAMAGE_REPORT",  "Display Damage Report")
--ZO_CreateStringId("SI_BINDING_NAME_POST_DAMAGE_RESULTS",    "Post Damage Results")

--[[----------------------------------------------------------
    DAMAGE WORDS
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Falling",            "Fallschaden")
ZO_CreateStringId("FTC_Dead",               "Dead")
ZO_CreateStringId("FTC_Offline",            "Offline")

--[[----------------------------------------------------------
    MENU CORE
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Menu_Configure",     "Addon Komponenten Einstellungen")
ZO_CreateStringId("FTC_Menu_Reload",        "Durch die Veränderung dieser Einstellung wird das UI neu gelanden")
ZO_CreateStringId("FTC_Menu_NeedReload",    "Veränderungen an dieser Einstellung werden erst aktiv nachdem das UI neu geladen wurde!")

local default = ( FTC.Defaults.EnableFrames ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_Frames",        "Anzeigeelemente aktivieren")
ZO_CreateStringId("FTC_Menu_FramesDesc",    "Aktiviere die Anzeigeelemente? [Standard: "..default.."]")

local default = ( FTC.Defaults.EnableBuffs ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_Buffs",         "Buffs aktivieren")
ZO_CreateStringId("FTC_Menu_BuffsDesc",     "Aktiviere die Anzeige der aktiven Buffs? [Standard: "..default.."]")
 
local default = ( FTC.Defaults.EnableLog ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_Log",           "Kampflog aktivieren")
ZO_CreateStringId("FTC_Menu_LogDesc",       "Aktiviere die Kampflog Anzeige? [Standard: "..default.."]")
 
local default = ( FTC.Defaults.EnableSCT ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_SCT",           "Kampflauftext aktivieren") 
ZO_CreateStringId("FTC_Menu_SCTDesc",       "Aktiviere den Kampflauftext [Standard: "..default.."]")

local default = ( FTC.Defaults.EnableMeter ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_Damage",        "Schadensstatistik aktivieren")
ZO_CreateStringId("FTC_Menu_DamageDesc",    "Aktiviere die Anzeige der Schadensstatistik? [Standard: "..default.."]")
 
--local default = ( FTC.Defaults.EnableHotbar ) and "Enabled" or "Disabled"
--ZO_CreateStringId("FTC_Menu_Hotbar",        "Enable Advanced Hotbar")
--ZO_CreateStringId("FTC_Menu_HotbarDesc",    "Enable advanced tooltips displayed over the default hotbar? [Default: "..default.."]")

--ZO_CreateStringId("FTC_Menu_Move",          "Unlock Positions")
--ZO_CreateStringId("FTC_Menu_MoveDesc",      "Modify the position of FTC interface elements.")

--[[----------------------------------------------------------
    UNIT FRAMES
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Menu_FHeader",       "Anzeigeeinstellungen")
 
ZO_CreateStringId("FTC_Menu_FWidth",        "Anzeigeelemente Breite")
ZO_CreateStringId("FTC_Menu_FWidthDesc",    "Ändert die Breite der Anzeigeelemente. [Standard: "..FTC.Defaults.FrameWidth.."]")
 
ZO_CreateStringId("FTC_Menu_FHeight",       "Anzeigeelemente Höhe")
ZO_CreateStringId("FTC_Menu_FHeightDesc",   "Ändert die Höhe der Anzeigeelemente. [Standard: "..FTC.Defaults.FrameHeight.."]")
 
ZO_CreateStringId("FTC_Menu_FOpacIn",       "Deckkraft im Kampf")
ZO_CreateStringId("FTC_Menu_FOpacInDesc",   "Ändert die Deckkraft der Anzeigeelemente während eines Kampfes. [Standard: "..FTC.Defaults.FrameOpacityIn.."]")
 
ZO_CreateStringId("FTC_Menu_FOpacOut",      "Deckkraft außerhalb eines Kampfes")
ZO_CreateStringId("FTC_Menu_FOpacOutDesc",  "Ändert die Deckkraft der Anzeigeelemente außerhalb eines Kampfes. Je niedriger desto durchsichtiger. [Standard: "..FTC.Defaults.FrameOpacityOut.."]")
 
ZO_CreateStringId("FTC_Menu_FFont1",        "Primäre Schriftart")
ZO_CreateStringId("FTC_Menu_FFont1Desc",    "Ändert die primäre Schriftart der FTC Anzeigeelemente. [Standard: "..FTC.UI:TranslateFont(FTC.Defaults.FrameFont1).."]")
 
ZO_CreateStringId("FTC_Menu_FFont2",        "Sekundäre Schriftart")
ZO_CreateStringId("FTC_Menu_FFont2Desc",    "Ändert die sekundäre Schriftart der FTC Anzeigeelemente. [Standard: "..FTC.UI:TranslateFont(FTC.Defaults.FrameFont2).."]")
 
ZO_CreateStringId("FTC_Menu_FFontS",        "Schriftgröße")
ZO_CreateStringId("FTC_Menu_FFontSDesc",    "Ändert die Schriftgröße der FTC Anzeigeelemente. [Standard: "..FTC.Defaults.FrameFontSize.."]")
 
ZO_CreateStringId("FTC_Menu_Exceute",       "Hinrichten Schwelle")
ZO_CreateStringId("FTC_Menu_ExecuteDesc",   "Ändert den Wert der erreicht werden muss damit ein Alarm angezeigt wird. [Standard: "..FTC.Defaults.ExecuteThreshold.."]")

local default = ( FTC.Defaults.DefaultTargetFrame ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_FShowDef",      "Standard Zielanzeige anzeigen")
ZO_CreateStringId("FTC_Menu_FShowDefDesc",  "Standard ESO Zielanzeige weiterhin anzeigen? [Standard: "..default.."]")
 
local default = ( FTC.Defaults.EnableNameplate ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_FShowName",     "Spieler Namen anzeigen")
ZO_CreateStringId("FTC_Menu_FShowNameDesc", "Eigenen Namen über der FTC Anzeigeelemente anzeigen? [Standard: "..default.."]")

local default = ( FTC.Defaults.EnableXPBar ) and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_FShowXP",       "Mini Erfahrungsleiste aktivieren")
ZO_CreateStringId("FTC_Menu_FShowXPDesc",   "Zeige eine kleine Erfahrungsleiste unter dem FTC Spielerelement an? [Standard: "..default.."]")

local default = math.floor(FTC.Defaults.FrameHealthColor[1]*255)..","..math.floor(FTC.Defaults.FrameHealthColor[2]*255)..","..math.floor(FTC.Defaults.FrameHealthColor[3]*255)
ZO_CreateStringId("FTC_Menu_FHealthC",      "Farbe der Lebensleiste")
ZO_CreateStringId("FTC_Menu_FHealthCDesc",  "Ändert die Farbe der Lebensleiste der FTC Anzeigeelemente. [Standard: "..default.."]")

local default = math.floor(FTC.Defaults.FrameMagickaColor[1]*255)..","..math.floor(FTC.Defaults.FrameMagickaColor[2]*255)..","..math.floor(FTC.Defaults.FrameMagickaColor[3]*255)
ZO_CreateStringId("FTC_Menu_FMagickaC",     "Farbe der Magieleiste")
ZO_CreateStringId("FTC_Menu_FMagickaCDesc", "Ändert die Farbe der Magieleiste der FTC Anzeigeelemente. [Standard: "..default.."]")
 
local default = math.floor(FTC.Defaults.FrameShieldColor[1]*255)..","..math.floor(FTC.Defaults.FrameShieldColor[2]*255)..","..math.floor(FTC.Defaults.FrameShieldColor[3]*255)
ZO_CreateStringId("FTC_Menu_FStaminaC",     "Farbe der Ausdauerleiste")
ZO_CreateStringId("FTC_Menu_FStaminaCDesc", "Ändert die Farbe der Ausdauerleiste der FTC Anzeigeelemente. [Standard: "..default.."]")
 
local default = math.floor(FTC.Defaults.FrameShieldColor[1]*255)..","..math.floor(FTC.Defaults.FrameShieldColor[2]*255)..","..math.floor(FTC.Defaults.FrameShieldColor[3]*255)
ZO_CreateStringId("FTC_Menu_FShieldC",      "Farbe der Schildleiste")
ZO_CreateStringId("FTC_Menu_FShieldCDesc",  "Ändert die Farbe der Schildleiste der FTC Anzeigeelemente. [Standard: "..default.."]")

local default = ( FTC.Defaults.EnableGroupFrames ) and "Ein" or "Aus"
--ZO_CreateStringId("FTC_Menu_FGroup",        "Enable Small Group Frames")
--ZO_CreateStringId("FTC_Menu_FGroupDesc",    "Use custom group unit frames when in a group of size 4 or less. [Default: "..default.."]")

--ZO_CreateStringId("FTC_Menu_FGWidth",       "Group Frames Width")
--ZO_CreateStringId("FTC_Menu_FGWidthDesc",   "Set the width of FTC small group frames. [Default: "..FTC.Defaults.GroupWidth.."]")

--ZO_CreateStringId("FTC_Menu_FGHeight",      "Group Frames Height")
--ZO_CreateStringId("FTC_Menu_FGHeightDesc",  "Set the height of FTC small group frames. [Default: "..FTC.Defaults.GroupHeight.."]")

--ZO_CreateStringId("FTC_Menu_FGFontS",       "Group Frame Font Size")
--ZO_CreateStringId("FTC_Menu_FGFontSDesc",   "Change the scale of the fonts used in FTC small group frames. [Default: "..FTC.Defaults.GroupFontSize.."]")

local default = ( FTC.Defaults.GroupHidePlayer ) and "Ein" or "Aus"
--ZO_CreateStringId("FTC_Menu_FGHideP",       "Hide Player in Group Frame")
--ZO_CreateStringId("FTC_Menu_FGHidePDesc",   "Do not show your own health bar in small group frame? [Default: " .. default .."]")

local default = ( FTC.Defaults.ColorRoles ) and "Ein" or "Aus"
--ZO_CreateStringId("FTC_Menu_FColorR",       "Color Frames by Role")
--ZO_CreateStringId("FTC_Menu_FColorRDesc",   "Use different colors for each combat role in FTC group and raid frames? [Default: "..default.."]")

local default = math.floor(FTC.Defaults.FrameTankColor[1]*255)..","..math.floor(FTC.Defaults.FrameTankColor[2]*255)..","..math.floor(FTC.Defaults.FrameTankColor[3]*255)
--ZO_CreateStringId("FTC_Menu_FTankC",        "Tank Role Color")
--ZO_CreateStringId("FTC_Menu_FTankCDesc",    "Set the color displayed for tanks in FTC group and raid frames. [Default: "..default.."]")

local default = math.floor(FTC.Defaults.FrameHealerColor[1]*255)..","..math.floor(FTC.Defaults.FrameHealerColor[2]*255)..","..math.floor(FTC.Defaults.FrameHealerColor[3]*255)
--ZO_CreateStringId("FTC_Menu_FHealerC",      "Healer Role Color")
--ZO_CreateStringId("FTC_Menu_FHealerCDesc",  "Set the color displayed for healers in FTC group and raid frames. [Default: "..default.."]")

local default = math.floor(FTC.Defaults.FrameDamageColor[1]*255)..","..math.floor(FTC.Defaults.FrameDamageColor[2]*255)..","..math.floor(FTC.Defaults.FrameDamageColor[3]*255)
--ZO_CreateStringId("FTC_Menu_FDamageC",      "Damage Role Color")
--ZO_CreateStringId("FTC_Menu_FDamageCDesc",  "Set the color displayed for DPS in FTC group and raid frames. [Default: "..default.."]")

local default = ( FTC.Defaults.EnableRaidFrames ) and "Ein" or "Aus"
--ZO_CreateStringId("FTC_Menu_FRaid",         "Enable Raid Frames")
--ZO_CreateStringId("FTC_Menu_FRaidDesc",     "Use custom unit frames for groups of size 4 or more? [Default: "..default.."]")

--ZO_CreateStringId("FTC_Menu_FRWidth",       "Raid Frames Width")
--ZO_CreateStringId("FTC_Menu_FRWidthDesc",   "Set the width of FTC raid frames. [Default: "..FTC.Defaults.RaidWidth.."]")

--ZO_CreateStringId("FTC_Menu_FRHeight",      "Raid Frames Height")
--ZO_CreateStringId("FTC_Menu_FRHeightDesc",  "Set the height of FTC raid frames. [Default: "..FTC.Defaults.RaidHeight.."]")

--ZO_CreateStringId("FTC_Menu_FRFontS",       "Raid Frame Font Size")
--ZO_CreateStringId("FTC_Menu_FRFontSDesc",   "Change the scale of the fonts used in FTC raid frames. [Default: "..FTC.Defaults.RaidFontSize.."]")

ZO_CreateStringId("FTC_Menu_FReset",        "Zurücksetzen")
ZO_CreateStringId("FTC_Menu_FResetDesc",    "Setzt die FTC Anzeigeelemente zurück auf die Standardwertet.")
 
--[[----------------------------------------------------------
    BUFF TRACKING
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Menu_BHeader",       "Buff-Anzeige Einstellungen")

ZO_CreateStringId("FTC_BuffFormat0",        "Deaktiviert")
ZO_CreateStringId("FTC_BuffFormat1",        "Horizontale Ausrichtung")
ZO_CreateStringId("FTC_BuffFormat2",        "Vertikale Ausrichtung")
ZO_CreateStringId("FTC_BuffFormat3",        "Absteigende Liste")
ZO_CreateStringId("FTC_BuffFormat4",        "Aufsteigende Liste")
 
ZO_CreateStringId("FTC_Menu_BPBFormat",     "Spieler Buff Format")
ZO_CreateStringId("FTC_Menu_BPBFormatDesc", "Wähle das gewünschte Format für Spieler Buffs. [Standard: "..FTC.Menu:GetBuffFormat(FTC.Defaults.PlayerBuffFormat).."]")
 
ZO_CreateStringId("FTC_Menu_BPDFormat",     "Spieler Debuff Format")
ZO_CreateStringId("FTC_Menu_BPDFormatDesc", "Wähle das gewünschte Format für Spieler Debuffs. [Standard: "..FTC.Menu:GetBuffFormat(FTC.Defaults.PlayerDebuffFormat).."]")
 
ZO_CreateStringId("FTC_Menu_BLBFormat",     "Lang anhaltende Buffs Format")
ZO_CreateStringId("FTC_Menu_BLBFormatDesc", "Wähle das gewünschte Format für lang anhaltende Buffs. [Standard: "..FTC.Menu:GetBuffFormat(FTC.Defaults.LongBuffFormat).."]")
 
ZO_CreateStringId("FTC_Menu_BTBFormat",     "Ziel Buff Format")
ZO_CreateStringId("FTC_Menu_BTBFormatDesc", "Wähle das Format der Ziel Buffs. [Standard: "..FTC.Menu:GetBuffFormat(FTC.Defaults.TargetBuffFormat).."]")
 
ZO_CreateStringId("FTC_Menu_BTDFormat",     "Ziel Debuff Format")
ZO_CreateStringId("FTC_Menu_BTDFormatDesc", "Wähle das Format der Ziel debuffs. [Standard: "..FTC.Menu:GetBuffFormat(FTC.Defaults.TargetDebuffFormat).."]")
 
ZO_CreateStringId("FTC_Menu_BFont1",        "Primäre Schriftart")
ZO_CreateStringId("FTC_Menu_BFont1Desc",    "Ändert die primäre Schriftart der FTC Buff Komponente. [Standard: "..FTC.UI:TranslateFont(FTC.Defaults.BuffsFont1).."]")
 
ZO_CreateStringId("FTC_Menu_BFont2",        "Sekundäre Schriftart")
ZO_CreateStringId("FTC_Menu_BFont2Desc",    "Ändert die sekundäre Schriftart der FTC Buff Komponente. [Standard: "..FTC.UI:TranslateFont(FTC.Defaults.BuffsFont2).."]")
 
ZO_CreateStringId("FTC_Menu_BFontS",        "Schriftgröße")
ZO_CreateStringId("FTC_Menu_BFontSDesc",    "Ändert die Schriftgröße der FTC Buff Komponente. [Standard: "..FTC.Defaults.BuffsFontSize.."]")
 
ZO_CreateStringId("FTC_Menu_BReset",        "Zurücksetzen")
ZO_CreateStringId("FTC_Menu_BResetDesc",    "Setzt die FTC Buff Einstellungen zurück auf die Standardwertet.")

-- Menu Display Words
--ZO_CreateStringId("FTC_PlayerBuff",         "Player Buff")
--ZO_CreateStringId("FTC_PlayerDebuff",       "Player Debuff")
 
--[[----------------------------------------------------------
    COMBAT LOG
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Menu_LHeader",       "Kampflog Einstellungen")

local default = FTC.Defaults.AlternateChat and "Ein" or "Aus"
--ZO_CreateStringId("FTC_Menu_LAltChat",    "Alternate With Chat")
ZO_CreateStringId("FTC_Menu_LAltChatDesc",  "Kampflog nur anzeigen wenn der Chat minimiert ist? [Standard: "..default.."]")
 
ZO_CreateStringId("FTC_Menu_LFont",         "Schriftart")
ZO_CreateStringId("FTC_Menu_LFontDesc",     "Ändert die Schriftart des FTC Kampflogs. [Standard: "..FTC.UI:TranslateFont(FTC.Defaults.LogFont).."]")
 
ZO_CreateStringId("FTC_Menu_LFontS",        "Schriftgröße")
ZO_CreateStringId("FTC_Menu_LFontSDesc",    "Ändert die Schriftgröße des FTC Kampflogs. [Standard: "..FTC.Defaults.LogFontSize.."]")
 
ZO_CreateStringId("FTC_Menu_LReset",        "Zurücksetzen")
ZO_CreateStringId("FTC_Menu_LResetDesc",    "Setzt die FTC Kampflog Einstellungen zurück auf die Standardwertet.")

--[[----------------------------------------------------------
    SCROLLING COMBAT TEXT
  ]]----------------------------------------------------------
ZO_CreateStringId("FTC_Menu_SHeader",       "(SCT) Kampflauftext Einstellungen")

local default = FTC.Defaults.SCTIcons and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_SIcons",        "Anzeige der Symbole")
ZO_CreateStringId("FTC_Menu_SIconsDesc",    "Zeigt die Symbole der Fähigkeiten neben den Schadenswerten an. [Standart: "..default.."]")

local default = FTC.Defaults.SCTNames and "Ein" or "Aus"
ZO_CreateStringId("FTC_Menu_SNames",        "Anzeige der Fähigkeitsnamen")
ZO_CreateStringId("FTC_Menu_SNamesDesc",    "Zeigt die Namen der Fähigkeiten neben den Schadenswerten an. [Standart: "..default.."]")

--local default = FTC.Defaults.SCTRound and "Enabled" or "Disabled"
--ZO_CreateStringId("FTC_Menu_SRound",        "Shorten Numbers")
--ZO_CreateStringId("FTC_Menu_SRoundDesc",    "Round damage numbers to the nearest hundred; for example 9,543 becomes 9.5k. [Default: "..default.."]")

ZO_CreateStringId("FTC_Menu_SSpeed",        "Geschwindigkeit des Lauftextes")
ZO_CreateStringId("FTC_Menu_SSpeedDesc",    "Ändert die Geschwindigkeit des Kampflauftextes, je höher der Wert, umso schneller die Animation. [Standart: "..FTC.Defaults.SCTSpeed.."]")

ZO_CreateStringId("FTC_Menu_SArc",          "Intensität des Bogens")
ZO_CreateStringId("FTC_Menu_SArcDesc",      "Ändert die Krümmung der Animation im Kampflauftext, höhere Werte generieren eine größere Biegung. [Standart: "..FTC.Defaults.SCTArc.."]")

ZO_CreateStringId("FTC_Menu_SFont1",        "Primäre Schriftart")
ZO_CreateStringId("FTC_Menu_SFont1Desc",    "Ändert die primäre Schriftart der Schadenswerte im Kampflauftext. [Standart: "..FTC.UI:TranslateFont(FTC.Defaults.SCTFont1).."]")

ZO_CreateStringId("FTC_Menu_SFont2",        "Sekundäre Schriftart")
ZO_CreateStringId("FTC_Menu_SFont2Desc",    "Ändert die sekundäre Schriftart der Fähigkeitsnamen im Kampflauftext. [Standart: "..FTC.UI:TranslateFont(FTC.Defaults.SCTFont2).."]")

ZO_CreateStringId("FTC_Menu_SFontS",        "Schriftgröße")
ZO_CreateStringId("FTC_Menu_SFontSDesc",    "Ändert die Schriftgröße im FTC Kampflauftext. [Standart: "..FTC.Defaults.SCTFontSize.."]")

ZO_CreateStringId("FTC_Menu_SIconS",        "Symbolgröße")
ZO_CreateStringId("FTC_Menu_SIconSDesc",    "Ändert die Symbolgröße im FTC Kampflauftext. [Standart: "..FTC.Defaults.SCTIconSize.."]")

ZO_CreateStringId("FTC_Menu_SCTReset",      "SCT zurücksetzen")
ZO_CreateStringId("FTC_Menu_SCTResetDesc",  "Setzt die Einstellungen des FTC Kampflauftextes zu den Standartwerten zurück.")

-- Menu Display Words
-- ZO_CreateStringId("FTC_FakeDamage",         "Fake Damage")
-- ZO_CreateStringId("FTC_FakeHeal",           "Fake Heal")

--[[----------------------------------------------------------
    SCT ALERTS
  ]]----------------------------------------------------------
--ZO_CreateStringId("FTC_LowHealth",          "Low Health")
--ZO_CreateStringId("FTC_LowMagicka",         "Low Magicka")
--ZO_CreateStringId("FTC_LowStamina",         "Low Stamina")
--ZO_CreateStringId("FTC_Experience",         "Experience")
--ZO_CreateStringId("FTC_AlliancePoints",     "Alliance Points")
--ZO_CreateStringId("FTC_Stunned",            "Stunned")
--ZO_CreateStringId("FTC_Disoriented",        "Disoriented")
--ZO_CreateStringId("FTC_Offbalance",         "Off Balance")
--ZO_CreateStringId("FTC_Staggered",          "Staggered")
--ZO_CreateStringId("FTC_Interrupted",        "Interrupted")
--ZO_CreateStringId("FTC_Feared",             "Feared")
--ZO_CreateStringId("FTC_Silenced",           "Silenced")
--ZO_CreateStringId("FTC_Potion",             "Potion Available")
--ZO_CreateStringId("FTC_Ultimate",           "Ultimate Available")

--[[----------------------------------------------------------
    DAMAGE STATISTICS
  ]]----------------------------------------------------------
--ZO_CreateStringId("FTC_Menu_THeader",       "Configure Damage Statistics")

--ZO_CreateStringId("FTC_Menu_TTimeout",      "Timeout Threshold")
--ZO_CreateStringId("FTC_Menu_TTimeoutDesc",  "Set the number of seconds that must pass between damage events before a new encounter is recognized. [Default: "..FTC.Defaults.DamageTimeout.."]")

--local default = FTC.Defaults.StatTriggerHeals and "Enabled" or "Disabled"
--ZO_CreateStringId("FTC_Menu_TRHeal",        "Allow Healing Trigger")
--ZO_CreateStringId("FTC_Menu_TRHealDesc",    "Allow outgoing healing to trigger the start of a new encounter.")

--ZO_CreateStringId("FTC_Menu_TReset",        "Reset Stats")
--ZO_CreateStringId("FTC_Menu_TResetDesc",    "Reset original settings for FTC damage statistics component.")

-- Damage Report Words
--ZO_CreateStringId("FTC_DReport",            "FTC Damage Report")
--ZO_CreateStringId("FTC_HReport",            "FTC Healing Report")
--ZO_CreateStringId("FTC_NoDamage",           "No damage to report!")
--ZO_CreateStringId("FTC_NoHealing",          "No healing to report!")
--ZO_CreateStringId("FTC_AllTargets",         "All Targets")
--ZO_CreateStringId("FTC_Ability",            "Ability")
--ZO_CreateStringId("FTC_Crit",               "Crit")
--ZO_CreateStringId("FTC_Average",            "Avg")
--ZO_CreateStringId("FTC_Max",                "Max")
--ZO_CreateStringId("FTC_Damage",             "Damage")
--ZO_CreateStringId("FTC_Healing",            "Healing")
--ZO_CreateStringId("FTC_DPS",                "DPS")
--ZO_CreateStringId("FTC_HPS",                "HPS")
