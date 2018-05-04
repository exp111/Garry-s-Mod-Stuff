include("../../../convars.lua")

secondPanel = vgui.Create("DPanel", propertySheet)
secondPanel:SetDrawBackground(false)

local dLabel = vgui.Create("DLabel", secondPanel)
dLabel:SetPos(5, 25)
dLabel:SetText("DLabel")
dLabel:SetDark(true)
dLabel:SizeToContents()

local dComboBox = vgui.Create("DComboBox" , secondPanel)
dComboBox:SetPos(50, 25)
dComboBox:SetSize(100, 20)
if !testBoolVar:GetBool() then dComboBox:SetValue("Off")
else dComboBox:SetValue("On") end
dComboBox:AddChoice("Off")
dComboBox:AddChoice("On")
dComboBox.OnSelect = function(panel, index, value)
	if value == "Off" then testBoolVar:SetBool(false)
	elseif value == "On" then testBoolVar:SetBool(true) end
end

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_test_bool")
CheckBoxLabel:SetText("Test ConVar")
CheckBoxLabel:SetPos(5, 50)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_radar_enable")
CheckBoxLabel:SetText("Radar")
CheckBoxLabel:SetPos(5, 75)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_aim_enable")
CheckBoxLabel:SetText("Aimbot")
CheckBoxLabel:SetPos(5, 100)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local Binder = vgui.Create( "DBinder", secondPanel )
Binder:SetPos( 100, 95 )
Binder:SetSize( 100, 20 )
Binder:SetConVar("exp_aim_key")

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_aim_fovcircle")
CheckBoxLabel:SetText("Draw FOV")
CheckBoxLabel:SetPos(5, 125)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local dNumSlider = vgui.Create( "DNumberWang", secondPanel )
dNumSlider:SetPos( 100, 125 )
dNumSlider:SetConVar("exp_aim_fov")
dNumSlider:SetMin( 0 )
dNumSlider:SetMax( 180 )
dNumSlider:SetDecimals( 0 )