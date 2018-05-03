--ConVars
            --CreateClientConVar(Name, string Default, shouldSave = true, UserData = false, helpText = "")
testBoolVar = CreateClientConVar("exp_test_bool", "0", false)
testIntVar = CreateClientConVar("exp_test_int", "1", false)

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
menuBGColor = createColorConVar("menucolor1", 149, 149, 149, 155)
menuBGColorIndex = 1
--Menu Foreground Color
menuFGColor = createColorConVar("menucolor2", 255, 255, 255, 155)
menuFGColorIndex = 2