--ConVars
            --CreateClientConVar(Name, string Default, shouldSave = true, UserData = false, helpText = "")
testBoolVar = CreateClientConVar("exp_test_bool", "0", false)
testIntVar = CreateClientConVar("exp_test_int", "1", false)
radarConVar = CreateClientConVar("exp_radar_enable", "0", false)

aimbotConVar = CreateClientConVar("exp_aim_enable", "0", false)
aimbotBoneConVar = CreateClientConVar("exp_aim_bone", "ValveBiped.Bip01_Head1", false)
aimbotKeyConVar = CreateClientConVar("exp_aim_key", "111", false)
aimbotFOVCircleConVar = CreateClientConVar("exp_aim_fovcircle", "0", false)
aimbotFOVConVar = CreateClientConVar("exp_aim_fov", "30", false)

triggerConVar = CreateClientConVar("exp_trigger_enable", "0", false)

ESPConVar = CreateClientConVar("exp_esp_enable", "0", false)

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