logPanel = vgui.Create("DPanel", propertySheet)
logPanel:SetDrawBackground(false)

Events = {}

local w, h = 465, 420
local column1w, column2w = 60, 16
logListView = vgui.Create("DListView", logPanel)
logListView:SetPos(5, 5)
logListView:SetSize(w, h)
logListView:SetMultiSelect(false)
local column = logListView:AddColumn("Time")
column:SetFixedWidth(column1w)
local column = logListView:AddColumn("")
column:SetFixedWidth(column2w)
local column = logListView:AddColumn("Details")
column:SetFixedWidth(w - column1w - column2w)

function logListView:DoDoubleClick(lineID, line)
    print(line:GetColumnText(1) .. " Log: " .. line:GetColumnText(3))
end

function BuildLogListView()
    for i=#logListView:GetLines(),#Events-1 do
        local event = Events[i+1]

        local icon = ""
        if event.icon then
            icon = vgui.Create("DImage")
            icon:SetMaterial(event.icon)
            icon:SetKeepAspect(true)
            icon:SizeToContents()
        end

        logListView:AddLine(event.time or "", icon, event.details or "")
    end

    logListView:PerformLayout()
    logListView.VBar:SetScroll(logListView.VBar.CanvasSize)
end