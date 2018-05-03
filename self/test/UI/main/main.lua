include("../../convars.lua")
include("tabs/firstPanel.lua")
include("tabs/secondPanel.lua")

--Main Panels
mainPanel = vgui.Create("DFrame")
mainPanel:SetPos((ScrW()/2)-250, (ScrH()/2)-250)
mainPanel:SetSize(500, 500)
mainPanel:SetTitle("Main")
mainPanel:SetVisible(false)
mainPanel:SetDraggable(true)
mainPanel:ShowCloseButton(true)
mainPanel:SetDeleteOnClose(false)
mainPanel:MakePopup()
mainPanel.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, panelColor)
end

local propertySheet = vgui.Create("DPropertySheet")
propertySheet:SetParent(mainPanel)
propertySheet:SetPos(5, 30)
propertySheet:SetSize(490, 460)
propertySheet.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, panelColor) 
end

--DPanels
--Are declared in their respective files

--Add Tabs to Sheet
propertySheet:AddSheet("First", firstPanel , nil, false, false, nil)
propertySheet:AddSheet("Second", secondPanel , nil, false, false, nil)