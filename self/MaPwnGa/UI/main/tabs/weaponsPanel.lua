--include("../../../convars.lua")
weaponsPanel = vgui.Create("DPanel", propertySheet)
weaponsPanel:SetDrawBackground(false)

local dLabel = vgui.Create("DLabel", weaponsPanel)
dLabel:SetPos(215, 10)
dLabel:SetText("Weapons")
dLabel:SetDark(true)
dLabel:SizeToContents()

local PlayerWeaponsView = vgui.Create( "DListView" , weaponsPanel)
PlayerWeaponsView:SetPos(5, 30)
PlayerWeaponsView:SetSize(220, 350)
PlayerWeaponsView:SetMultiSelect(false)
PlayerWeaponsView:AddColumn("Players")

local WeaponWeaponPanel = vgui.Create( "DListView" , weaponsPanel)
WeaponWeaponPanel:SetPos(250, 30)
WeaponWeaponPanel:SetSize(220, 350)
WeaponWeaponPanel:SetMultiSelect(false)
WeaponWeaponPanel:AddColumn("Weapons")

local function Refresh()
    PlayerWeaponsView:Clear()
    WeaponWeaponPanel:Clear()

    for k,v in pairs(player.GetAll()) do
    	PlayerWeaponsView:AddLine(v) 
	end
end

local dButton = vgui.Create("DButton", weaponsPanel)
dButton:SetText("Refresh")
dButton:SetPos(165, 390)
dButton:SetSize(150, 40)
dButton.DoClick = function() Refresh() end

function PlayerWeaponsView:DoDoubleClick( lineID, line )
	Refresh()
	local ply = line:GetValue(1)
	if ply then
		for x, y in pairs(ply:GetWeapons()) do
			WeaponWeaponPanel:AddLine(y)
		end
	end
end

Refresh()