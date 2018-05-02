--MENU

--Hack Vars
local BHop = CreateClientConVar( "bhop_enabled", 0, false, false )
local TriggerBot = CreateClientConVar( "tbot_enabled", 0, false, false )
local Crosshair = CreateClientConVar( "cross_enabled", 0, false, false )
local NoRecoil = CreateClientConVar( "norecoil_enabled", 0, false, false )
--TTT Shit
local TraitorFinder = CreateClientConVar( "tfinder_enabled", 0, false, false )
local ModelSearcher = CreateClientConVar( "modelsearcher_enabled", 0, false, false )
--Wallhack
local PWallhack = CreateClientConVar( "wall_enabled", 0, false, false )
local NPCWallhack = CreateClientConVar( "npcwall_enabled", 0, false, false )
--Player Aimbots
local pfaimbot = CreateClientConVar( "pfaimbot_enabled", 0, false, false )
local paimbot = CreateClientConVar( "paimbot_enabled", 0, false, false )
local pragebot = CreateClientConVar( "pragebot_enabled", 0, false, false )
--NPC Aimbots
local nfaimbot = CreateClientConVar( "nfaimbot_enabled", 0, false, false )
local naimbot = CreateClientConVar( "naimbot_enabled", 0, false, false )
local nragebot = CreateClientConVar( "nragebot_enabled", 0, false, false )
--Aimhelper
local naimhelper = CreateClientConVar( "naimhelper_enabled", 0, false, false )
local paimhelper = CreateClientConVar( "paimhelper_enabled", 0, false, false )
--ESP Shit
local ESPName = CreateClientConVar( "espname_enabled", 0, false, false )
local ESPHealth = CreateClientConVar( "esphealth_enabled", 0, false, false )
local ESPDistance = CreateClientConVar( "espdistance_enabled", 0, false, false )
local ESPWeapon = CreateClientConVar( "espweapon_enabled", 0, false, false )
local ESP3DBox = CreateClientConVar( "esp3dbox_enabled", 0, false, false )
local ESP2DBox = CreateClientConVar( "esp2dbox_enabled", 0, false, false )
local ESPBone = CreateClientConVar( "espbone_enabled", 0, false, false )
--Charms
local NPCGlow = CreateClientConVar( "nglow_enabled", 0, false, false )
local PGlow = CreateClientConVar( "pglow_enabled", 0, false, false )
--Friends
local HideAimFriends = CreateClientConVar( "hideaimf_enabled", 0, false, false )
local HideWallFriends = CreateClientConVar( "hidewallf_enabled", 0, false, false )

--Color ConVars
--Text
local textcr = CreateClientConVar( "textcolorr", 0, true, false )
local textcg = CreateClientConVar( "textcolorg", 255, true, false )
local textcb = CreateClientConVar( "textcolorb", 0, true, false )
local textca = CreateClientConVar( "textcolora", 255, true, false )
--Box
local boxcr = CreateClientConVar( "boxcolorr", 0, true, false )
local boxcg = CreateClientConVar( "boxcolorg", 255, true, false )
local boxcb = CreateClientConVar( "boxcolorb", 0, true, false )
local boxca = CreateClientConVar( "boxcolora", 255, true, false )
--Bone
local bonecr = CreateClientConVar( "bonecolorr", 255, true, false )
local bonecg = CreateClientConVar( "bonecolorg", 0, true, false )
local bonecb = CreateClientConVar( "bonecolorb", 255, true, false )
local boneca = CreateClientConVar( "bonecolora", 255, true, false )
--Cross
local crosscr = CreateClientConVar( "crosscolorr", 0, true, false )
local crosscg = CreateClientConVar( "crosscolorg", 255, true, false )
local crosscb = CreateClientConVar( "crosscolorb", 0, true, false )
local crossca = CreateClientConVar( "crosscolora", 255, true, false )
--Glow
local glowcr = CreateClientConVar( "glowcolorr", 255, true, false )
local glowcg = CreateClientConVar( "glowcolorg", 0, true, false )
local glowcb = CreateClientConVar( "glowcolorb", 0, true, false )
local glowca = CreateClientConVar( "glowcolora", 255, true, false )
--Glow (visible)
local glow2cr = CreateClientConVar( "glow2colorr", 255, true, false )
local glow2cg = CreateClientConVar( "glow2colorg", 165, true, false )
local glow2cb = CreateClientConVar( "glow2colorb", 0, true, false )
local glow2ca = CreateClientConVar( "glow2colora", 255, true, false )
--Friends
local friendcr = CreateClientConVar( "friendcolorr", 0, true, false )
local friendcg = CreateClientConVar( "friendcolorg", 255, true, false )
local friendcb = CreateClientConVar( "friendcolorb", 0, true, false )
local friendca = CreateClientConVar( "friendcolora", 255, true, false )
--ModelSearcher
local modelcr = CreateClientConVar( "modelcolorr", 255, true, false )
local modelcg = CreateClientConVar( "modelcolorg", 0, true, false )
local modelcb = CreateClientConVar( "modelcolorb", 0, true, false )
local modelca = CreateClientConVar( "modelcolora", 255, true, false )

--Colors
panelcolor=Color(255,255,255,155)
textcolor=Color(textcr:GetInt(),textcg:GetInt(),textcb:GetInt(),textca:GetInt())
boxcolor=Color(boxcr:GetInt(),boxcg:GetInt(),boxcb:GetInt(),boxca:GetInt())
bonecolor=Color(bonecr:GetInt(),bonecg:GetInt(),bonecb:GetInt(),boneca:GetInt())
crosscolor=Color(crosscr:GetInt(),crosscg:GetInt(),crosscb:GetInt(),crossca:GetInt())
glowcolor=Color(glowcr:GetInt(), glowcg:GetInt(), glowcb:GetInt(), glowca:GetInt())
glow2color=Color(glow2cr:GetInt(), glow2cg:GetInt(), glow2cb:GetInt(), glow2ca:GetInt())
friendcolor=Color(friendcr:GetInt(),friendcg:GetInt(),friendcb:GetInt(),friendca:GetInt())
modelcolor=Color(modelcr:GetInt(), modelcg:GetInt(), modelcb:GetInt(), modelca:GetInt())

--Other Vars
crosssize = 50
aimradius=50
friends={}
otherplayers = {}
othermodels = {}
availablemodels = {
		"models/weapons/w_c4_planted.mdl"
		}
selectedmodels = {}

bones = {
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_Neck1",
	"ValveBiped.Bip01_Spine4",
	"ValveBiped.Bip01_Spine2",
	"ValveBiped.Bip01_Spine1",
	"ValveBiped.Bip01_Spine",
	"ValveBiped.Bip01_R_UpperArm",
	"ValveBiped.Bip01_R_Forearm",
	"ValveBiped.Bip01_R_Hand",
	"ValveBiped.Bip01_L_UpperArm",
	"ValveBiped.Bip01_L_Forearm",
	"ValveBiped.Bip01_L_Hand",
	"ValveBiped.Bip01_R_Thigh",
	"ValveBiped.Bip01_R_Calf",
	"ValveBiped.Bip01_R_Foot",
	"ValveBiped.Bip01_R_Toe0",
	"ValveBiped.Bip01_L_Thigh",
	"ValveBiped.Bip01_L_Calf",
	"ValveBiped.Bip01_L_Foot",
	"ValveBiped.Bip01_L_Toe0"
}

selectedbone=bones[1]

--Font
surface.CreateFont( "MyFont", {
	font = "Arial",
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )




--Main Panels
MainPanel = vgui.Create( "DFrame" )
MainPanel:SetPos( (ScrW()/2)-250, (ScrH()/2)-250 )
MainPanel:SetSize( 500, 500 )
MainPanel:SetTitle( "(H)Exp" )
MainPanel:SetVisible( false )
MainPanel:SetDraggable( true )
MainPanel:ShowCloseButton( false )
MainPanel:MakePopup()
MainPanel.Paint = function( self, w, h ) 
	draw.RoundedBox( 0, 0, 0, w, h, panelcolor ) 
end

local PropertySheet = vgui.Create( "DPropertySheet" )
PropertySheet:SetParent( MainPanel )
PropertySheet:SetPos( 5, 30 )
PropertySheet:SetSize( 490, 460 )
PropertySheet.Paint = function( self, w, h ) 
	draw.RoundedBox( 0, 0, 0, w, h, panelcolor ) 
end


--DPanels
local aimbotpanel = vgui.Create( "DPanel", PropertySheet )
aimbotpanel:SetDrawBackground(false)
local wallhackpanel = vgui.Create( "DPanel", PropertySheet )
wallhackpanel:SetDrawBackground(false)
local otherpanel = vgui.Create( "DPanel", PropertySheet )
otherpanel:SetDrawBackground(false)
local colorpanel = vgui.Create( "DPanel", PropertySheet )
colorpanel:SetDrawBackground(false)
local friendspanel = vgui.Create( "DPanel", PropertySheet )
friendspanel:SetDrawBackground(false)
local keyspanel = vgui.Create( "DPanel", PropertySheet )
keyspanel:SetDrawBackground(false)
local modelspanel = vgui.Create( "DPanel", PropertySheet )
modelspanel:SetDrawBackground(false)
local weaponpanel = vgui.Create( "DPanel", PropertySheet )
weaponpanel:SetDrawBackground(false)

--Checkboxes & Things

--AIMBOT
local DLabel = vgui.Create( "DLabel", aimbotpanel )
DLabel:SetPos( 5, 25 )
DLabel:SetText( "Enable Player Aimbot?" )
DLabel:SetFont( "MyFont" )
DLabel:SetDark(true)
DLabel:SizeToContents()

local paimbotBox = vgui.Create( "DComboBox" , aimbotpanel)
paimbotBox:SetPos( 175, 25 )
paimbotBox:SetSize( 100, 20 )
if pfaimbot:GetInt()==0 and paimbot:GetInt()==0 and pragebot:GetInt()==0 then paimbotBox:SetValue( "Off" )
elseif pfaimbot:GetInt()==1 then paimbotBox:SetValue( "Friendly" )
elseif paimbot:GetInt()==1 then paimbotBox:SetValue( "Normal" )
elseif pragebot:GetInt()==1 then paimbotBox:SetValue( "Rage" ) end
paimbotBox:AddChoice( "Off" )
paimbotBox:AddChoice( "Friendly" )
paimbotBox:AddChoice( "Normal" )
paimbotBox:AddChoice( "Rage" )
paimbotBox.OnSelect = function( panel, index, value )
	if value=="Off" then LocalPlayer():ConCommand("pfaimbot_enabled 0; paimbot_enabled 0; pragebot_enabled 0") end
	if value=="Friendly" then LocalPlayer():ConCommand("pfaimbot_enabled 1; paimbot_enabled 0; pragebot_enabled 0") end
	if value=="Normal" then LocalPlayer():ConCommand("pfaimbot_enabled 0; paimbot_enabled 1; pragebot_enabled 0") end
	if value=="Rage" then LocalPlayer():ConCommand("pfaimbot_enabled 0; paimbot_enabled 0; pragebot_enabled 1") end
end

local DLabel = vgui.Create( "DLabel", aimbotpanel )
DLabel:SetPos( 5, 55 )
DLabel:SetText( "Enable NPC Aimbot?" )
DLabel:SetFont( "MyFont" )
DLabel:SetDark(true)
DLabel:SizeToContents()

local naimbotBox = vgui.Create( "DComboBox" , aimbotpanel)
naimbotBox:SetPos( 175, 55 )
naimbotBox:SetSize( 100, 20 )
if nfaimbot:GetInt()==0 and naimbot:GetInt()==0 and nragebot:GetInt()==0 then naimbotBox:SetValue( "Off" )
elseif nfaimbot:GetInt()==1 then naimbotBox:SetValue( "Friendly" )
elseif naimbot:GetInt()==1 then naimbotBox:SetValue( "Normal" )
elseif nragebot:GetInt()==1 then naimbotBox:SetValue( "Rage" ) end
naimbotBox:AddChoice( "Off" )
naimbotBox:AddChoice( "Friendly" )
naimbotBox:AddChoice( "Normal" )
naimbotBox:AddChoice( "Rage" )
naimbotBox.OnSelect = function( panel, index, value )
	if value=="Off" then LocalPlayer():ConCommand("nfaimbot_enabled 0; naimbot_enabled 0; nragebot_enabled 0") end
	if value=="Friendly" then LocalPlayer():ConCommand("nfaimbot_enabled 1; naimbot_enabled 0; nragebot_enabled 0") end
	if value=="Normal" then LocalPlayer():ConCommand("nfaimbot_enabled 0; naimbot_enabled 1; nragebot_enabled 0") end
	if value=="Rage" then LocalPlayer():ConCommand("nfaimbot_enabled 0; naimbot_enabled 0; nragebot_enabled 1") end
end

local DLabel = vgui.Create( "DLabel", aimbotpanel )
DLabel:SetPos( 5, 85 )
DLabel:SetText( "Enable AimHelper?" )
DLabel:SetFont( "MyFont" )
DLabel:SetDark(true)
DLabel:SizeToContents()

local AimhelpBox = vgui.Create( "DComboBox" , aimbotpanel)
AimhelpBox:SetPos( 175, 85 )
AimhelpBox:SetSize( 100, 20 )
if naimhelper:GetInt()==0 and paimhelper:GetInt()==0 then AimhelpBox:SetValue( "Off" )
elseif naimhelper:GetInt()==1 and paimhelper:GetInt()==0 then AimhelpBox:SetValue( "NPC" )
elseif paimhelper:GetInt()==1 and naimhelper:GetInt()==0 then AimhelpBox:SetValue( "Player" )
elseif naimhelper:GetInt()==1 and paimhelper:GetInt()==1 then AimhelpBox:SetValue( "Both" ) end
AimhelpBox:AddChoice( "Off" )
AimhelpBox:AddChoice( "Player" )
AimhelpBox:AddChoice( "NPC" )
AimhelpBox:AddChoice( "Both" )
AimhelpBox.OnSelect = function( panel, index, value )
	if value=="Off" then LocalPlayer():ConCommand("naimhelper_enabled 0; paimhelper_enabled 0") end
	if value=="Player" then LocalPlayer():ConCommand("naimhelper_enabled 0; paimhelper_enabled 1") end
	if value=="NPC" then LocalPlayer():ConCommand("naimhelper_enabled 1; paimhelper_enabled 0") end
	if value=="Both" then LocalPlayer():ConCommand("naimhelper_enabled 1; paimhelper_enabled 1") end
end

local AimhelpSlider = vgui.Create( "Slider", aimbotpanel )
AimhelpSlider:SetPos( 280, 80 )
AimhelpSlider:SetWide( 200 )
AimhelpSlider:SetMin( 50 )
AimhelpSlider:SetMax( 100 )
AimhelpSlider:SetValue( aimradius )
AimhelpSlider:SetDecimals( 1 )
AimhelpSlider.OnValueChanged = function( panel, value )
	aimradius = value
end

local BoneAimBox = vgui.Create( "DComboBox" , aimbotpanel)
BoneAimBox:SetPos( 280, 25 )
BoneAimBox:SetSize( 100, 20 )
BoneAimBox:SetValue( "Head" )
BoneAimBox:AddChoice( "Head" )
BoneAimBox:AddChoice( "Body" )
BoneAimBox.OnSelect = function( panel, index, value )
	if value=="Head" then selectedbone=bones[1] end
	if value=="Body" then selectedbone=bones[5] end
end

--WALLHACK

local WallhackLabel = vgui.Create( "DLabel", wallhackpanel )
WallhackLabel:SetPos( 5, 25 )
WallhackLabel:SetText( "Enable Wallhack?" )
WallhackLabel:SetDark(true)
WallhackLabel:SizeToContents()

local WallhackBox = vgui.Create( "DComboBox" , wallhackpanel)
WallhackBox:SetPos( 200, 25 )
WallhackBox:SetSize( 100, 20 )
if NPCWallhack:GetInt()==0 and PWallhack:GetInt()==0 then WallhackBox:SetValue( "Off" )
elseif NPCWallhack:GetInt()==1 and PWallhack:GetInt()==0 then WallhackBox:SetValue( "NPC" )
elseif PWallhack:GetInt()==1 and NPCWallhack:GetInt()==0 then WallhackBox:SetValue( "Player" )
elseif NPCWallhack:GetInt()==1 and PWallhack:GetInt()==1 then WallhackBox:SetValue( "Both" ) end
WallhackBox:AddChoice( "Off" )
WallhackBox:AddChoice( "Player" )
WallhackBox:AddChoice( "NPC" )
WallhackBox:AddChoice( "Both" )
WallhackBox.OnSelect = function( panel, index, value )
	if value=="Off" then LocalPlayer():ConCommand("npcwall_enabled 0; wall_enabled 0") end
	if value=="Player" then LocalPlayer():ConCommand("npcwall_enabled 0; wall_enabled 1") end
	if value=="NPC" then LocalPlayer():ConCommand("npcwall_enabled 1; wall_enabled 0") end
	if value=="Both" then LocalPlayer():ConCommand("npcwall_enabled 1; wall_enabled 1") end
end

local espnamebox = vgui.Create( "DCheckBoxLabel", wallhackpanel ) --Wallhack
espnamebox:SetConVar( "espname_enabled" )
espnamebox:SetText( "Enable Name?" )
espnamebox:SetPos( 5, 50 )
espnamebox:SetDark(true)
espnamebox:SizeToContents()

local esphealthbox = vgui.Create( "DCheckBoxLabel", wallhackpanel ) --Wallhack
esphealthbox:SetConVar( "esphealth_enabled" )
esphealthbox:SetText( "Enable Health?" )
esphealthbox:SetPos( 5, 75 )
esphealthbox:SetDark(true)
esphealthbox:SizeToContents()

local espdistancebox = vgui.Create( "DCheckBoxLabel", wallhackpanel ) --Wallhack
espdistancebox:SetConVar( "espdistance_enabled" )
espdistancebox:SetText( "Enable Distance?" )
espdistancebox:SetPos( 5, 100 )
espdistancebox:SetDark(true)
espdistancebox:SizeToContents()

local espweaponbox = vgui.Create( "DCheckBoxLabel", wallhackpanel ) --Wallhack
espweaponbox:SetConVar( "espweapon_enabled" )
espweaponbox:SetText( "Enable Weapon?" )
espweaponbox:SetPos( 5, 125 )
espweaponbox:SetDark(true)
espweaponbox:SizeToContents()

local WBoxLabel = vgui.Create( "DLabel", wallhackpanel )
WBoxLabel:SetPos( 5, 150 )
WBoxLabel:SetText( "Enable Box?" )
WBoxLabel:SetDark(true)
WBoxLabel:SizeToContents()

local WBoxBox = vgui.Create( "DComboBox" , wallhackpanel)
WBoxBox:SetPos( 200, 150 )
WBoxBox:SetSize( 100, 20 )
if ESP2DBox:GetInt()==0 and ESP3DBox:GetInt()==0 then WBoxBox:SetValue( "Off" )
elseif ESP2DBox:GetInt()==1 and ESP3DBox:GetInt()==0 then WBoxBox:SetValue( "2D" )
elseif ESP3DBox:GetInt()==1 and ESP2DBox:GetInt()==0 then WBoxBox:SetValue( "3D" ) end
WBoxBox:AddChoice( "Off" )
WBoxBox:AddChoice( "2D" )
WBoxBox:AddChoice( "3D" )
WBoxBox.OnSelect = function( panel, index, value )
	if value=="Off" then LocalPlayer():ConCommand("esp3dbox_enabled 0; esp2dbox_enabled 0") end
	if value=="2D" then LocalPlayer():ConCommand("esp3dbox_enabled 0; esp2dbox_enabled 1") end
	if value=="3D" then LocalPlayer():ConCommand("esp3dbox_enabled 1; esp2dbox_enabled 0") end
end

local espbonebox = vgui.Create( "DCheckBoxLabel", wallhackpanel ) --Wallhack
espbonebox:SetConVar( "espbone_enabled" )
espbonebox:SetText( "Enable Bone?" )
espbonebox:SetPos( 5, 175)
espbonebox:SetDark(true)
espbonebox:SizeToContents()

local GlowLabel = vgui.Create( "DLabel", wallhackpanel )
GlowLabel:SetPos( 5, 200 )
GlowLabel:SetText( "Enable Glow?" )
GlowLabel:SetDark(true)
GlowLabel:SizeToContents()

local GlowBox = vgui.Create( "DComboBox" , wallhackpanel)
GlowBox:SetPos( 200, 200 )
GlowBox:SetSize( 100, 20 )
GlowBox:SetValue( "Off" )
if NPCGlow:GetInt()==0 and PGlow:GetInt()==0 then GlowBox:SetValue( "Off" )
elseif NPCGlow:GetInt()==1 and PGlow:GetInt()==0 then GlowBox:SetValue( "NPC" )
elseif PGlow:GetInt()==1 and NPCGlow:GetInt()==0 then GlowBox:SetValue( "Player" )
elseif NPCGlow:GetInt()==1 and PGlow:GetInt()==1 then GlowBox:SetValue( "Both" ) end
GlowBox:AddChoice( "Off" )
GlowBox:AddChoice( "Player" )
GlowBox:AddChoice( "NPC" )
GlowBox:AddChoice( "Both" )
GlowBox.OnSelect = function( panel, index, value )
	if value=="Off" then LocalPlayer():ConCommand("nglow_enabled 0; pglow_enabled 0") end
	if value=="Player" then LocalPlayer():ConCommand("nglow_enabled 0; pglow_enabled 1") end
	if value=="NPC" then LocalPlayer():ConCommand("nglow_enabled 1; pglow_enabled 0") end
	if value=="Both" then LocalPlayer():ConCommand("nglow_enabled 1; pglow_enabled 1") end
end


--Misc. (Other)

local bhopbox = vgui.Create( "DCheckBoxLabel" , otherpanel) --Other
bhopbox:SetConVar( "bhop_enabled" )
bhopbox:SetText( "Enable Bhop?" )
bhopbox:SetPos( 5, 25 )
bhopbox:SetDark(true)
bhopbox:SizeToContents()

local triggerbox = vgui.Create( "DCheckBoxLabel", otherpanel ) --Other
triggerbox:SetConVar( "tbot_enabled" )
triggerbox:SetText( "Enable Trigger?" )
triggerbox:SetPos( 5, 50 )
triggerbox:SetDark(true)
triggerbox:SizeToContents()

local ccrossbox = vgui.Create( "DCheckBoxLabel", otherpanel ) --other
ccrossbox:SetConVar( "cross_enabled" )
ccrossbox:SetText( "Enable Custom Crosshair?" )
ccrossbox:SetPos( 5, 75 )
ccrossbox:SetDark(true)
ccrossbox:SizeToContents()

local CrossSlider = vgui.Create( "Slider", otherpanel )
CrossSlider:SetPos( 5, 100 )
CrossSlider:SetWide( 200 )
CrossSlider:SetMin( 20 )
CrossSlider:SetMax( 120 )
CrossSlider:SetValue( 60 )
CrossSlider:SetDecimals( 3 )
CrossSlider.OnValueChanged = function( panel, value )
	crosssize = value
end

local tfinderbox = vgui.Create( "DCheckBoxLabel", otherpanel ) --other
tfinderbox:SetConVar( "tfinder_enabled" )
tfinderbox:SetText( "Enable Traitor Finder? (Only check once)" )
tfinderbox:SetPos( 5, 135 )
tfinderbox:SetDark(true)
tfinderbox:SizeToContents()

local norecoilbox = vgui.Create( "DCheckBoxLabel", otherpanel ) --Other
norecoilbox:SetConVar( "norecoil_enabled" )
norecoilbox:SetText( "Enable NoRecoil" )
norecoilbox:SetPos( 5, 160 )
norecoilbox:SetDark(true)
norecoilbox:SizeToContents()

--Color Things #justcolorthings
ChosenColor = nil

local ColorPicker = vgui.Create( "DColorMixer", colorpanel )
ColorPicker:SetSize( 200, 200 )
ColorPicker:SetPos( 50, 50 )
ColorPicker:SetPalette( true )
ColorPicker:SetAlphaBar( true )
ColorPicker:SetWangs( true )
ColorPicker:SetColor( Color( 255, 255, 255 ) )

local DComboBox = vgui.Create( "DComboBox" , colorpanel)
DComboBox:SetPos( 300, 200 )
DComboBox:SetSize( 100, 40 )
DComboBox:SetValue( "Change Color of" )
DComboBox:AddChoice( "ESPText" )
DComboBox:AddChoice( "ESPBox" )
DComboBox:AddChoice( "ESPBone" )
DComboBox:AddChoice( "Crosshair" )
DComboBox:AddChoice( "Glow" )
DComboBox:AddChoice( "Glow (Visible)" )
DComboBox:AddChoice( "Friends" )
DComboBox:AddChoice( "Models" )

function ColorRefresh(color,name)
	r=color.r
	g=color.g
	b=color.b
	a=color.a
	LocalPlayer():ConCommand(name.."r "..color.r.."; "..name.."g "..color.g.."; "..name.."b "..color.b.."; "..name.."a "..color.a)
end

local ConfirmColor = vgui.Create( "DButton", colorpanel )
ConfirmColor:SetText( "Set Color" )
ConfirmColor:SetSize( 100, 40 )
ConfirmColor:SetPos( 300, 50 )
ConfirmColor.DoClick = function()
	ChosenColor = ColorPicker:GetColor()
	choice = DComboBox:GetSelected()
	if choice=="ESPText" then textcolor=ChosenColor ColorRefresh(textcolor,"textcolor") end
	if choice=="ESPBox" then boxcolor=ChosenColor ColorRefresh(boxcolor,"boxcolor") end
	if choice=="ESPBone" then bonecolor=ChosenColor ColorRefresh(bonecolor,"bonecolor") end
	if choice=="Crosshair" then crosscolor=ChosenColor ColorRefresh(crosscolor,"crosscolor") end
	if choice=="Glow" then glowcolor=ChosenColor ColorRefresh(glowcolor,"glowcolor") end
	if choice=="Glow (Visible)" then glow2color=ChosenColor ColorRefresh(glow2color,"glow2color") end
	if choice=="Friends" then friendcolor=ChosenColor ColorRefresh(friendcolor,"friendcolor") end
	if choice=="Models" then modelcolor=ChosenColor ColorRefresh(modelcolor,"modelcolor") end
end

--weaponshit
local PlayerWeaponsView = vgui.Create( "DListView" ,  weaponpanel )
PlayerWeaponsView:SetPos(5, 30)
PlayerWeaponsView:SetSize(200, 310)
PlayerWeaponsView:SetMultiSelect(false)
PlayerWeaponsView:AddColumn("Players")

local WeaponWeaponPanel = vgui.Create( "DListView" ,  weaponpanel )
WeaponWeaponPanel:SetPos(255, 30)
WeaponWeaponPanel:SetSize(200, 310)
WeaponWeaponPanel:SetMultiSelect(false)
WeaponWeaponPanel:AddColumn("Weapons")

function PlayerWeaponsView:DoDoubleClick( lineID, line )
	Refresh()
	local ply = player.GetAll()[lineID]
	if (ply != null) then
		for x, y in pairs(ply:GetWeapons()) do
			WeaponWeaponPanel:AddLine(y)
		end
	end
end

--Friends
local FriendsView = vgui.Create( "DListView" ,  friendspanel )
FriendsView:SetPos(5, 30)
FriendsView:SetSize(200, 310)
FriendsView:SetMultiSelect(false)
FriendsView:AddColumn("Friends")

local PlayersView = vgui.Create( "DListView" ,  friendspanel )
PlayersView:SetPos(255, 30)
PlayersView:SetSize(200, 310)
PlayersView:SetMultiSelect(false)
PlayersView:AddColumn("Enemies")

 
function Refresh()
	PlayersView:Clear()
	FriendsView:Clear()
	PlayerWeaponsView:Clear()
	WeaponWeaponPanel:Clear()

	table.Empty(otherplayers)

	for k,v in pairs(player.GetAll()) do
		if v!=LocalPlayer() and (table.HasValue( friends, v)==false) then
    			PlayersView:AddLine(v:GetName())
    			local tablecount = #PlayersView:GetLines()
			otherplayers[tablecount]=v
		end
	end

	for k,v in pairs(player.GetAll()) do
		if v!=LocalPlayer() and (table.HasValue( friends, v)==true) then
    			FriendsView:AddLine(v) 
		end
	end

	for k,v in pairs(player.GetAll()) do
		if v!=LocalPlayer() then
    			PlayerWeaponsView:AddLine(v) 
		end
	end
end

Refresh()

function FriendsView:DoDoubleClick( lineID, line )
	local tablepos = table.KeyFromValue(friends,FriendsView:GetValue(lineID))
	table.remove(friends,tablepos)
	Refresh()
end

function PlayersView:DoDoubleClick( lineID, line )
	local tablepos = (table.Count( friends )+1)
	friends[tablepos] = otherplayers[lineID]
	Refresh()
end

local refreshbutton = vgui.Create("DButton", friendspanel)
	refreshbutton:SetText("Refresh")
	refreshbutton:SetPos(180,345)
	refreshbutton:SetSize(100,30)
	refreshbutton.DoClick = Refresh

local refresh2button = vgui.Create("DButton", weaponpanel)
	refresh2button:SetText("Refresh")
	refresh2button:SetPos(180,345)
	refresh2button:SetSize(100,30)
	refresh2button.DoClick = Refresh

local hideaimbox = vgui.Create( "DCheckBoxLabel", friendspanel ) --other
hideaimbox:SetConVar( "hideaimf_enabled" )
hideaimbox:SetText( "Don't aim at Friends?" )
hideaimbox:SetPos( 50, 345 )
hideaimbox:SetDark(true)
hideaimbox:SizeToContents()

local hidewallbox = vgui.Create( "DCheckBoxLabel", friendspanel ) --other
hidewallbox:SetConVar( "hidewallf_enabled" )
hidewallbox:SetText( "Hide Friends from Wallhack?" )
hidewallbox:SetPos( 290, 345 )
hidewallbox:SetDark(true)
hidewallbox:SizeToContents()


--Keys

local aimkeylabel = vgui.Create( "DLabel", keyspanel )
aimkeylabel:SetText( "Aimbot Key" )
aimkeylabel:SetPos( 5, 25 )
aimkeylabel:SetDark(true)
aimkeylabel:SizeToContents()

local aimentry = vgui.Create( "DTextEntry", keyspanel )
aimentry:SetPos( 5, 50 )
aimentry:SetSize( 295, 20 )
aimentry:SetText( "" )

local aimbinder = vgui.Create( "DBinder", keyspanel )
aimbinder:SetSize( 100, 20 )
aimbinder:SetPos( 200, 25 )
function aimbinder:SetSelectedNumber( num )
	local kname = input.GetKeyName( num )
	local k2name = input.LookupBinding("+alt1")
	aimentry:SetText( "unbind "..k2name.."; bind "..kname.." +alt1" )
end

local bhopkeylabel = vgui.Create( "DLabel", keyspanel )
bhopkeylabel:SetText( "BHop Key" )
bhopkeylabel:SetPos( 5, 75 )
bhopkeylabel:SetDark(true)
bhopkeylabel:SizeToContents()

local bhopentry = vgui.Create( "DTextEntry", keyspanel )
bhopentry:SetPos( 5, 100 )
bhopentry:SetSize( 295, 20 )
bhopentry:SetText( "" )

local bhopbinder = vgui.Create( "DBinder", keyspanel )
bhopbinder:SetSize( 100, 20 )
bhopbinder:SetPos( 200, 75 )
function bhopbinder:SetSelectedNumber( num )
	local kname = input.GetKeyName( num )
	local k2name = input.LookupBinding("+alt2")
	bhopentry:SetText( "unbind "..k2name.."; bind "..kname.." +alt2" )
end

--Model Searcher
local ModelSearchedView = vgui.Create( "DListView" ,  modelspanel )
ModelSearchedView:SetPos(5, 30)
ModelSearchedView:SetSize(200, 310)
ModelSearchedView:SetMultiSelect(false)
ModelSearchedView:AddColumn("Selected")


local Model2SearchView = vgui.Create( "DListView" ,  modelspanel )
Model2SearchView:SetPos(255, 30)
Model2SearchView:SetSize(200, 310)
Model2SearchView:SetMultiSelect(false)
Model2SearchView:AddColumn("Available")

function RefreshM()
	ModelSearchedView:Clear()
	Model2SearchView:Clear()

	table.Empty(otherplayers)

	for k,v in pairs(availablemodels) do
		if (table.HasValue( selectedmodels, v)==false) then
    			Model2SearchView:AddLine(v)
    			local tablecount = #Model2SearchView:GetLines()
			othermodels[tablecount]=v
		end
	end

	for k,v in pairs(availablemodels) do
		if (table.HasValue( selectedmodels, v)==true) then
    			ModelSearchedView:AddLine(v) 
		end
	end
end

RefreshM()

function ModelSearchedView:DoDoubleClick( lineID, line )
	local tablepos = table.KeyFromValue(selectedmodels,ModelSearchedView:GetValue(lineID))
	table.remove(selectedmodels,tablepos)
	RefreshM()
end

function Model2SearchView:DoDoubleClick( lineID, line )
	local tablepos = (table.Count( selectedmodels )+1)
	selectedmodels[tablepos] = othermodels[lineID]
	RefreshM()
end


local ModelSearcherBox = vgui.Create( "DCheckBoxLabel", modelspanel )
ModelSearcherBox:SetConVar( "modelsearcher_enabled" )
ModelSearcherBox:SetText( "Activate Model Searcher" )
ModelSearcherBox:SetPos( 180, 345 )
ModelSearcherBox:SetDark(true)
ModelSearcherBox:SizeToContents()

--Add Tabs to Sheet
PropertySheet:AddSheet( "Aimbot", aimbotpanel , nil, false, false, nil )
PropertySheet:AddSheet( "Wallhack", wallhackpanel , nil, false, false, nil )
PropertySheet:AddSheet( "Misc.", otherpanel , nil, false, false, nil )
PropertySheet:AddSheet( "Style", colorpanel , nil, false, false, nil )
PropertySheet:AddSheet( "Friends", friendspanel , nil, false, false, nil )
PropertySheet:AddSheet( "Keys", keyspanel , nil, false, false, nil )
PropertySheet:AddSheet( "Model Searcher", modelspanel , nil, false, false, nil )
PropertySheet:AddSheet( "Weapons", weaponpanel , nil, false, false, nil )

--CLOSE BUTTON
button = vgui.Create("DButton", MainPanel)
	button:SetText("Close")
	button:SetPos(15,440)
	button:SetSize(100,40)
	button.DoClick = function()
		MainPanel:SetVisible( false )
end