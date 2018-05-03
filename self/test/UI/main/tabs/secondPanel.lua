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