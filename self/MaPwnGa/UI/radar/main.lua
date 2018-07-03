include("../../convars.lua")
include("../../helpers/math.lua")
include("../../helpers/utils.lua")

--Radar Panel
local radar = {}
radar.diameter = 5
radar.radius = 2.5

radarPanel = vgui.Create("DFrame", nil, "Radar")
radarPanel:SetPos(5, 5)
radarPanel:SetSize(250, 250)
radarPanel:SetTitle("Radar")
radarPanel:SetVisible(false)
radarPanel:SetDraggable(true)
radarPanel:ShowCloseButton(false)
radarPanel:SetDeleteOnClose(false)
radarPanel:MoveToFront()
radarPanel.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, menuBGColor)
end
radarPanel.Think = function(self)
	self:MoveToFront()
end

local propertySheet = vgui.Create("DPropertySheet")
propertySheet:SetParent(radarPanel)
propertySheet:SetPos(5, 25)
propertySheet:SetSize(240, 220)
propertySheet.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, menuFGColor)
	--Horizontal/Vertical Lines
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawLine(0, h/2, w, h/2)
	surface.DrawLine(w/2, 0, w/2, h)

	--draw.RoundedBox(180, w/2 - radar.radius, h/2 - radar.radius, radar.diameter, radar.diameter, Color(255, 0, 0, 255))
	local pos = LocalPlayer():GetPos()
	local vAngles = LocalPlayer():EyeAngles()
	local radarCenter = Vector(w/2, h/2, 0)
	for k,v in pairs(player.GetAll()) do
		/*if !ValidEntity(v, false, 0) then
			continue
		end*/
		if !ValidTarget(v, ESPVisibleOnlyConVar:GetBool(), ESPDistanceConVar:GetInt()) then
			continue 
		end
		local clr = Color(0, 0, 255, 255)
		if IsEnemy(v) then
			clr = Color(255, 0, 0, 255)
		end
		local pPos = v:GetPos()
		local relPos = Vector(pPos.x - pos.x, pos.y - pPos.y, 0) * radarScaleConVar:GetFloat()
		local angle = vAngles.y - 90
		relPos = RotatePoint(relPos, Vector(0, 0, 0), angle, false) + radarCenter
		--Clamp Entities to the border if they are higher
		relPos.x = math.Clamp(relPos.x, 0, w)
		relPos.y = math.Clamp(relPos.y, 0, h)

		--DRAW THIS SHIT
		draw.RoundedBox(0, relPos.x - radar.radius, relPos.y - radar.radius, radar.diameter, radar.diameter, clr)
		draw.SimpleText(v:Name(), "DermaDefault", relPos.x, relPos.y + radar.diameter, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
	end
end