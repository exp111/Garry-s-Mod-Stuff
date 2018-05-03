--ConVars
            --CreateClientConVar(Name, string Default, shouldSave = true, UserData = false, helpText = "")
testBoolVar = CreateClientConVar("exp_test_bool", "0", false)
testIntVar = CreateClientConVar("exp_test_int", "1", false)

--Color ConVars
colorConVarPrefix = "exp_clr_"
--Color 1
menuBGColor1R = CreateClientConVar( colorConVarPrefix .. "menucolor1_r", 149, true, false )
menuBGColor1G = CreateClientConVar( colorConVarPrefix .. "menucolor1_g", 149, true, false )
menuBGColor1B = CreateClientConVar( colorConVarPrefix .. "menucolor1_b", 149, true, false )
menuBGColor1A = CreateClientConVar( colorConVarPrefix .. "menucolor1_a", 155, true, false )

--Color 2
menuFGColor2R = CreateClientConVar( colorConVarPrefix .. "menucolor2_r", 255, true, false )
menuFGColor2G = CreateClientConVar( colorConVarPrefix .. "menucolor2_g", 255, true, false )
menuFGColor2B = CreateClientConVar( colorConVarPrefix .. "menucolor2_b", 255, true, false )
menuFGColor2A = CreateClientConVar( colorConVarPrefix .. "menucolor2_a", 155, true, false )

menuBGColor = Color(color1R:GetInt(), color1G:GetInt(), color1B:GetInt(), color1A:GetInt())
menuFGColor = Color(color2R:GetInt(), color2G:GetInt(), color2B:GetInt(), color2A:GetInt())