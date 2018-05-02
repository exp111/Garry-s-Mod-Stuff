--ConVars
            --CreateClientConVar(Name, string Default, shouldSave = true, UserData = false, helpText = "")
testBoolVar = CreateClientConVar("exp_test_bool", "0", false)
testIntVar = CreateClientConVar("exp_test_int", "1", false)

--Color ConVars
colorConVarPrefix = "exp_clr_"
--Color 1
color1R = CreateClientConVar( "exp_clr_color1_r", 0, true, false )
color1G = CreateClientConVar( "exp_clr_color1_g", 255, true, false )
color1B = CreateClientConVar( "exp_clr_color1_b", 0, true, false )
color1A = CreateClientConVar( "exp_clr_color1_a", 255, true, false )

--Color 2
color2R = CreateClientConVar( "exp_clr_color2_r", 255, true, false )
color2G = CreateClientConVar( "exp_clr_color2_g", 0, true, false )
color2B = CreateClientConVar( "exp_clr_color2_b", 255, true, false )
color2A = CreateClientConVar( "exp_clr_color2_a", 255, true, false )

panelColor=Color(255,255,255,155)
color1=Color(color1R:GetInt(), color1G:GetInt(), color1B:GetInt(), color1A:GetInt())
color2=Color(color2R:GetInt(), color2G:GetInt(), color2B:GetInt(), color2A:GetInt())