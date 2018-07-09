--Main Panels
menuPanel = vgui.Create("DFrame")
menuPanel:SetPos((ScrW()/2)-250, (ScrH()/2)-250)
menuPanel:SetSize(500, 500)
menuPanel:SetTitle("Main")
menuPanel:SetVisible(false)
menuPanel:SetDraggable(true)
menuPanel:ShowCloseButton(true)
menuPanel:SetDeleteOnClose(false)
menuPanel:MakePopup()
menuPanel.Paint = function(self, w, h) 
	draw.RoundedBox(4, 0, 0, w, h, menuBGColor)
end

local propertySheet = vgui.Create("DPropertySheet")
propertySheet:SetParent(menuPanel)
propertySheet:SetPos(5, 30)
propertySheet:SetSize(490, 460)
propertySheet:Dock(FILL)


--DPanels
--Are declared in their respective files

--Add Tabs to Sheet
propertySheet:AddSheet("First", firstPanel , nil, false, false, nil)
propertySheet:AddSheet("Second", secondPanel , nil, false, false, nil)
propertySheet:AddSheet("Weapons", weaponsPanel , nil, false, false, nil)
propertySheet:AddSheet("Log", logPanel , nil, false, false, nil)