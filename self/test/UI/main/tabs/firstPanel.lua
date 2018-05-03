include("../../../convars.lua")

firstPanel = vgui.Create("DPanel", propertySheet)
firstPanel:SetDrawBackground(false)

local dLabel = vgui.Create("DLabel", firstPanel)
dLabel:SetPos(5, 25)
dLabel:SetText("DLabel")
dLabel:SetDark(true)
dLabel:SizeToContents()

local dComboBox = vgui.Create( "DComboBox" , firstPanel)
dComboBox:SetPos(50, 25)
dComboBox:SetSize(100, 20)
dComboBox:SetValue("DComboBox")
dComboBox:AddChoice("DComboBox")
dComboBox:AddChoice("2. Option")
dComboBox:AddChoice("3. Option")
dComboBox:AddChoice("4. Option")
dComboBox.OnSelect = function(panel, index, value)
	--Do Shit here like set convars
end

local slider = vgui.Create("Slider", firstPanel)
slider:SetPos(175, 20)
slider:SetWide(200)
slider:SetMin(0)
slider:SetMax(10)
slider:SetValue(testIntVar:GetInt())
slider:SetDecimals(1)
slider.OnValueChanged = function(panel, value)
	testIntVar:SetInt(value)
end

local CheckBoxLabel = vgui.Create("DCheckBoxLabel", firstPanel)
CheckBoxLabel:SetText("DCheckBoxLabel")
CheckBoxLabel:SetPos(5, 50)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

ChosenColor = nil

local ColorMixer = vgui.Create("DColorMixer", firstPanel)
ColorMixer:SetPos(5, 75)
ColorMixer:SetSize(200, 200)
ColorMixer:SetPalette(true)
ColorMixer:SetAlphaBar(true)
ColorMixer:SetWangs(true)
ColorMixer:SetColor(Color( 255, 255, 255 ))

local dComboBox = vgui.Create("DComboBox", firstPanel)
dComboBox:SetPos(210, 75)
dComboBox:SetSize(150, 40)
dComboBox:SetValue("Change Color of")
dComboBox:AddChoice("Menu Background Color")
dComboBox:AddChoice("Menu Foreground Color")
dComboBox.OnSelect = function(panel, index, value)
	if value == "Menu Background Color" then ColorMixer:SetColor(menuBGColor)
	elseif value == "Menu Foreground Color" then ColorMixer:SetColor(menuFGColor) end
end

function ColorRefresh(color, name)
	LocalPlayer():ConCommand(colorConVarPrefix..name.."r "..color.r.."; "..colorConVarPrefix..name.."g "..color.g.."; "..colorConVarPrefix..name.."b "..color.b.."; "..colorConVarPrefix..name.."a "..color.a)
end

local dButton = vgui.Create("DButton", firstPanel)
dButton:SetText("Set Color")
dButton:SetPos(210, 125)
dButton:SetSize(150, 40)
dButton.DoClick = function()
	ChosenColor = ColorMixer:GetColor()
	choice = dComboBox:GetSelected()
	if choice == "Menu Background Color" then menuBGColor=ChosenColor ColorRefresh(color1, "menucolor1")
	elseif choice == "Menu Foreground Color" then menuFGColor=ChosenColor ColorRefresh(color2, "menucolor2") end
end