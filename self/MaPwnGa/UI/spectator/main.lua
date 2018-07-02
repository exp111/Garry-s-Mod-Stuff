include("../../convars.lua")

local panelW = 250
spectatorPanel = vgui.Create("DFrame", nil, "SpectatorList")
spectatorPanel:SetPos(ScrW() - panelW - 5, 5)
spectatorPanel:SetSize(panelW, 300)
spectatorPanel:SetTitle("Spectators")
spectatorPanel:SetVisible(false)
spectatorPanel:SetDraggable(true)
spectatorPanel:ShowCloseButton(false)
spectatorPanel:SetDeleteOnClose(false)
spectatorPanel:MoveToFront()
spectatorPanel.Paint = function(self, w, h) 
	draw.RoundedBox(0, 0, 0, w, h, menuBGColor)
end
spectatorPanel.Think = function(self)
	self:MoveToFront()
end

local spectatorListView = vgui.Create( "DListView" , spectatorPanel)
spectatorListView:SetPos(5, 25)
spectatorListView:SetSize(panelW - 10, 270)
spectatorListView:SetMultiSelect(false)
spectatorListView:AddColumn("Spectator")
spectatorListView:AddColumn("Mode")
spectatorListView.Think = function(self, w, h)
    local ply = LocalPlayer()
    spectatorListView:Clear()
    for k,v in pairs(player.GetAll()) do
        if !v or !v:IsValid() then continue end
        local target = v:GetObserverTarget()
        if !target then continue end
        if target == ply then
            spectatorListView:AddLine(v:Name(), tostring(v:GetObserverMode()))
        end
    end
end