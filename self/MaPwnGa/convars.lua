--ConVars
            --CreateClientConVar(Name, string Default, shouldSave = true, UserData = false, helpText = "")
testBoolVar = CreateClientConVar("exp_test_bool", "0", false)
testIntVar = CreateClientConVar("exp_test_int", "1", false)
radarConVar = CreateClientConVar("exp_radar_enable", "0", false)

aimbotConVar = CreateClientConVar("exp_aim_enable", "0", false)
aimbotBoneConVar = CreateClientConVar("exp_aim_bone", "ValveBiped.Bip01_Head1", false)
aimbotKeyConVar = CreateClientConVar("exp_aim_key", "111", false)
aimbotFOVCircleConVar = CreateClientConVar("exp_aim_fovcircle", "0", false)
aimbotFOVConVar = CreateClientConVar("exp_aim_fov", "10", false)
aimbotSnaplinesConVar = CreateClientConVar("exp_aim_snaplines", "0", false)

triggerConVar = CreateClientConVar("exp_trigger_enable", "0", false)
triggerOnKeyConVar = CreateClientConVar("exp_trigger_onkey", "1", false)
triggerKeyConVar = CreateClientConVar("exp_trigger_key", "109", false)

ESPConVar = CreateClientConVar("exp_esp_enable", "0", false)
ESPVisibleOnlyConVar = CreateClientConVar("exp_esp_visibleonly", "0", false)
ESPNameConVar = CreateClientConVar("exp_esp_name", "0", false)
ESPBoneConVar = CreateClientConVar("exp_esp_bone", "0", false)
ESP3DBoxConVar = CreateClientConVar("exp_esp_3dbox", "0", false)
ESP2DBoxConVar = CreateClientConVar("exp_esp_2dbox", "0", false)
ESPHealthConVar = CreateClientConVar("exp_esp_health", "0", false)
ESPGlowConVar = CreateClientConVar("exp_esp_glow", "0", false)
ESPWeaponConVar = CreateClientConVar("exp_esp_weapon", "0", false)

PerfectHeadAdjustmentConVar = CreateClientConVar("exp_misc_pha_enable", "0", false)
PerfectHeadAdjustmentPositionConVar = CreateClientConVar("exp_misc_pha_position", "0", false)
PerfectHeadAdjustmentScaleConVar = CreateClientConVar("exp_misc_pha_scale", "0", false)

TTTCheckerConVar = CreateClientConVar("exp_misc_tttcheck", "0", false)
ThirdPersonConVar = CreateClientConVar("exp_misc_thirdperson", "0", false)
crosshairConVar = CreateClientConVar("exp_misc_crosshair", "0", false)

--Color ConVars
local function createColorConVar(name, r, g, b, a)
    CreateClientConVar( colorConVarPrefix .. name .."_r", r, true, false )
    CreateClientConVar( colorConVarPrefix .. name .."_g", g, true, false )
    CreateClientConVar( colorConVarPrefix .. name .."_b", b, true, false )
    CreateClientConVar( colorConVarPrefix .. name .."_a", a, true, false )
    return Color(r, g, b, a)
end

colorConVarPrefix = "exp_clr_"

--Menu Background Color
menuBGColor = createColorConVar("menuBG", 149, 149, 149, 155)
menuBGColorIndex = 1
--Menu Foreground Color
menuFGColor = createColorConVar("menuFG", 255, 255, 255, 155)
menuFGColorIndex = 2
--FOVCirlce Color
FOVCircleColor = createColorConVar("fovCircle", 0, 255, 0, 255)
FOVCircleColorIndex = 3