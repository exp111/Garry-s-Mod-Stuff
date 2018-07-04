--ConVars
            --CreateClientConVar(Name, string Default, shouldSave = true, UserData = false, helpText = "")
shouldSave = false
testBoolVar = CreateClientConVar("exp_test_bool", "0", false)
testIntVar = CreateClientConVar("exp_test_int", "1", false)

radarConVar = CreateClientConVar("exp_radar_enable", "0", shouldSave)
radarScaleConVar = CreateClientConVar("exp_radar_scale", "1", shouldSave)

spectatorConVar = CreateClientConVar("exp_spectator_enable", "0", shouldSave)

antiAimConVar = CreateClientConVar("exp_hvh_aa", "0", shouldSave)
antiAimTypeConVar = CreateClientConVar("exp_hvh_aaType", "1", shouldSave)

chamsConVar = CreateClientConVar("exp_chams_enable", "0", shouldSave)
chamsFlatConVar = CreateClientConVar("exp_chams_flat", "0", shouldSave)
chamsIgnoreZConVar = CreateClientConVar("exp_chams_ignorez", "0", shouldSave)
chamsDrawWeaponConVar = CreateClientConVar("exp_chams_weapon", "0", shouldSave)

aimbotConVar = CreateClientConVar("exp_aim_enable", "0", shouldSave)
aimbotBoneConVar = CreateClientConVar("exp_aim_bone", "ValveBiped.Bip01_Head1", shouldSave)
aimbotKeyConVar = CreateClientConVar("exp_aim_key", "111", shouldSave)
aimbotFOVCircleConVar = CreateClientConVar("exp_aim_fovcircle", "0", shouldSave)
aimbotFOVConVar = CreateClientConVar("exp_aim_fov", "10", shouldSave)
aimbotSnaplinesConVar = CreateClientConVar("exp_aim_snaplines", "0", shouldSave)
aimbotSmoothConVar = CreateClientConVar("exp_aim_smooth", "0", shouldSave)
aimbotSaltConVar = CreateClientConVar("exp_aim_salt", "0", shouldSave)

triggerConVar = CreateClientConVar("exp_trigger_enable", "0", shouldSave)
triggerOnKeyConVar = CreateClientConVar("exp_trigger_onkey", "1", shouldSave)
triggerKeyConVar = CreateClientConVar("exp_trigger_key", "109", shouldSave)

ESPConVar = CreateClientConVar("exp_esp_enable", "0", shouldSave)
ESPVisibleOnlyConVar = CreateClientConVar("exp_esp_visibleonly", "0", shouldSave)
ESPNameConVar = CreateClientConVar("exp_esp_name", "0", shouldSave)
ESPBoneConVar = CreateClientConVar("exp_esp_bone", "0", shouldSave)
ESP3DBoxConVar = CreateClientConVar("exp_esp_3dbox", "0", shouldSave)
ESP2DBoxConVar = CreateClientConVar("exp_esp_2dbox", "0", shouldSave)
ESPHealthConVar = CreateClientConVar("exp_esp_health", "0", shouldSave)
ESPGlowConVar = CreateClientConVar("exp_esp_glow", "0", shouldSave)
ESPWeaponConVar = CreateClientConVar("exp_esp_weapon", "0", shouldSave)
ESPDroppedWeaponConVar = CreateClientConVar("exp_esp_droppedweapon", "0", shouldSave)
ESPDistanceConVar = CreateClientConVar("exp_esp_distance", "500", shouldSave)

PerfectHeadAdjustmentConVar = CreateClientConVar("exp_misc_pha_enable", "0", shouldSave)
PerfectHeadAdjustmentPositionConVar = CreateClientConVar("exp_misc_pha_position", "0", shouldSave)
PerfectHeadAdjustmentScaleConVar = CreateClientConVar("exp_misc_pha_scale", "0", shouldSave)

TTTCheckerConVar = CreateClientConVar("exp_misc_tttcheck", "0", shouldSave)
TTTCorpseDetectorConVar = CreateClientConVar("exp_misc_tttcorpsedetector", "0", shouldSave)
ThirdPersonConVar = CreateClientConVar("exp_misc_thirdperson", "0", shouldSave)
crosshairConVar = CreateClientConVar("exp_misc_crosshair", "0", shouldSave)
norecoilConVar = CreateClientConVar("exp_misc_norecoil", "0", shouldSave)
spongeMockConVar = CreateClientConVar("exp_misc_spongemock", "0", shouldSave)
autoPistolConVar = CreateClientConVar("exp_misc_autopistol", "0", shouldSave)

--Color ConVars
local function createColorConVar(name, r, g, b, a)
    CreateClientConVar( colorConVarPrefix .. name .."_r", r, true, shouldSave )
    CreateClientConVar( colorConVarPrefix .. name .."_g", g, true, shouldSave )
    CreateClientConVar( colorConVarPrefix .. name .."_b", b, true, shouldSave )
    CreateClientConVar( colorConVarPrefix .. name .."_a", a, true, shouldSave )
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