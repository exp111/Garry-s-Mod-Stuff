include("../../convars.lua")

--Radar Panel
radarPanel = vgui.Create("DFrame", nil, "Radar")
radarPanel:SetPos(5, 5)
radarPanel:SetSize(250, 250)
radarPanel:SetTitle("Radar")
radarPanel:SetVisible(false)
radarPanel:SetDraggable(true)
radarPanel:ShowCloseButton(false)
radarPanel:SetDeleteOnClose(false)
radarPanel:MakePopup()
radarPanel.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, menuBGColor)
end

local propertySheet = vgui.Create("DPropertySheet")
propertySheet:SetParent(radarPanel)
propertySheet:SetPos(5, 25)
propertySheet:SetSize(240, 220)
propertySheet.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, menuFGColor)
end

--DPanels
--Are declared in their respective files

--Add Tabs to Sheet