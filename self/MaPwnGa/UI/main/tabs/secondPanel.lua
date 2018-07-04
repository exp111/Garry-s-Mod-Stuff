include("../../../convars.lua")
include("../../../features/misc.lua")

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
CheckBoxLabel:SetConVar("exp_hvh_aa")
CheckBoxLabel:SetText("Anti Aim")
CheckBoxLabel:SetPos(290, 30)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local dComboBox = vgui.Create("DComboBox" , secondPanel)
dComboBox:SetPos(360, 25)
dComboBox:SetSize(100, 20)
dComboBox:SetSortItems(false)
dComboBox:AddChoice("EyeAngles")
dComboBox:AddChoice("Sideways")
dComboBox:AddChoice("Jitter")
dComboBox:AddChoice("Static")
dComboBox:AddChoice("Forward")
dComboBox:AddChoice("Backwards")
dComboBox.OnSelect = function(panel, index, value)
	antiAimTypeConVar:SetInt(index)
end

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_radar_enable")
CheckBoxLabel:SetText("Radar")
CheckBoxLabel:SetPos(5, 75)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_spectator_enable")
CheckBoxLabel:SetText("Spectator")
CheckBoxLabel:SetPos(100, 75)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

--AIMBOT
local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_aim_enable")
CheckBoxLabel:SetText("Aimbot")
CheckBoxLabel:SetPos(5, 100)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local Binder = vgui.Create( "DBinder", secondPanel )
Binder:SetPos( 100, 95 )
Binder:SetSize( 100, 25 )
Binder:SetConVar("exp_aim_key")

local slider = vgui.Create("Slider", secondPanel)
slider:SetPos(210, 95)
slider:SetWide(150)
slider:SetMin(0)
slider:SetMax(1)
slider:SetValue(aimbotSmoothConVar:GetFloat())
slider:SetConVar("exp_aim_smooth")
slider:SetDecimals(2)

local slider = vgui.Create("Slider", secondPanel)
slider:SetPos(360, 95)
slider:SetWide(150)
slider:SetMin(0)
slider:SetMax(1)
slider:SetValue(aimbotSaltConVar:GetFloat())
slider:SetConVar("exp_aim_salt")
slider:SetDecimals(2)

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_aim_fovcircle")
CheckBoxLabel:SetText("Draw FOV")
CheckBoxLabel:SetPos(5, 125)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local dNumberWang = vgui.Create( "DNumberWang", secondPanel )
dNumberWang:SetPos( 100, 125 )
dNumberWang:SetValue(aimbotFOVConVar:GetInt())
dNumberWang:SetConVar("exp_aim_fov")
dNumberWang:SetMin( 0 )
dNumberWang:SetMax( 180 )
dNumberWang:SetDecimals( 0 )

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_aim_snaplines")
CheckBoxLabel:SetText("Draw Snaplines")
CheckBoxLabel:SetPos(200, 125)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

--TRIGGERBOT
local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_trigger_enable")
CheckBoxLabel:SetText("Triggerbot")
CheckBoxLabel:SetPos(5, 150)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_trigger_onkey")
CheckBoxLabel:SetText("On Key")
CheckBoxLabel:SetPos(100, 150)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local Binder = vgui.Create( "DBinder", secondPanel )
Binder:SetPos( 195, 145 )
Binder:SetSize( 100, 25 )
Binder:SetConVar("exp_trigger_key")

--ESP
local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_enable")
CheckBoxLabel:SetText("ESP")
CheckBoxLabel:SetPos(5, 175)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_visibleonly")
CheckBoxLabel:SetText("Visible only")
CheckBoxLabel:SetPos(25, 200)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_glow")
CheckBoxLabel:SetText("Glow")
CheckBoxLabel:SetPos(150, 200)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_droppedweapon")
CheckBoxLabel:SetText("Dropped Weapons")
CheckBoxLabel:SetPos(250, 200)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local slider = vgui.Create("Slider", secondPanel)
slider:SetPos(250, 215)
slider:SetWide(150)
slider:SetMin(0)
slider:SetMax(2000)
slider:SetValue(ESPDistanceConVar:GetInt())
slider:SetConVar("exp_esp_distance")
slider:SetDecimals(0)

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_name")
CheckBoxLabel:SetText("Name")
CheckBoxLabel:SetPos(25, 225)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_health")
CheckBoxLabel:SetText("Health")
CheckBoxLabel:SetPos(150, 225)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_bone")
CheckBoxLabel:SetText("Bone")
CheckBoxLabel:SetPos(25, 250)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_weapon")
CheckBoxLabel:SetText("Weapon")
CheckBoxLabel:SetPos(150, 250)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_3dbox")
CheckBoxLabel:SetText("3D Box")
CheckBoxLabel:SetPos(25, 275)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_esp_2dbox")
CheckBoxLabel:SetText("2D Box")
CheckBoxLabel:SetPos(150, 275)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

--MISC
local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_pha_enable")
CheckBoxLabel:SetText("PerfectHeadAdjustment")
CheckBoxLabel:SetPos(5, 300)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_pha_position")
CheckBoxLabel:SetText("Affects Position")
CheckBoxLabel:SetPos(25, 325)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_pha_scale")
CheckBoxLabel:SetText("Affects Scale")
CheckBoxLabel:SetPos(25, 350)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_tttcheck")
CheckBoxLabel:SetText("TTT Checker")
CheckBoxLabel:SetPos(5, 375)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_tttcorpsedetector")
CheckBoxLabel:SetText("TTT Corpses")
CheckBoxLabel:SetPos(100, 375)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_thirdperson")
CheckBoxLabel:SetText("Thirdperson")
CheckBoxLabel:SetPos(195, 375)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_crosshair")
CheckBoxLabel:SetText("Crosshair")
CheckBoxLabel:SetPos(290, 375)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_norecoil")
CheckBoxLabel:SetText("No Recoil")
CheckBoxLabel:SetPos(385, 375)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_spongemock")
CheckBoxLabel:SetText("Sponge Mockify")
CheckBoxLabel:SetPos(5, 400)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()

local CheckBoxLabel = vgui.Create( "DCheckBoxLabel", secondPanel)
CheckBoxLabel:SetConVar("exp_misc_autopistol")
CheckBoxLabel:SetText("Auto Pistol")
CheckBoxLabel:SetPos(100, 400)
CheckBoxLabel:SetDark(true)
CheckBoxLabel:SizeToContents()