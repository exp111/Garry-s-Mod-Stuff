include("../../convars.lua")
include("../../helpers/math.lua")

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
	for k,v in pairs(ents.GetAll()) do
		/*if !ValidEntity(v, false) then
			continue
		end*/
		if !ValidTarget(v, ESPVisibleOnlyConVar:GetBool()) then
			continue 
		end
		local clr = Color(0, 0, 255, 255)
		if v:Team() != LocalPlayer():Team() then
			clr = Color(255, 0, 0, 255)
		end
		local relPos = v:GetPos() - pos
		local angle = -(vAngles.y - 90)
		--relPos = RotatePoint(relPos, Vector(w/2, h/2, 0), angle, false)
		print("Angle: " .. angle .. ";X: ".. relPos.x ..";Y: ".. relPos.y.."\n")
		--OOB
		/*if (math.abs(relPos.x) > w || math.abs(relPos.x) > h || math.abs(relPos.y) > w || math.abs(relPos.y) > h) then
			continue
		end*/
		--DRAW THIS SHIT
		draw.RoundedBox(0, relPos.x - radar.radius, relPos.y - radar.radius, radar.diameter, radar.diameter, clr)
	end
end
--DPanels
--Are declared in their respective files

--Add Tabs to Sheet