logPanel = vgui.Create("DPanel", propertySheet)
logPanel:SetDrawBackground(false)

local w, h = 465, 420
local column1w, column2w = 60, 40
logListView = vgui.Create("DListView", logPanel)
logListView:SetPos(5, 5)
logListView:SetSize(w, h)
logListView:SetMultiSelect(false)
local column = logListView:AddColumn("Time")
column:SetFixedWidth(column1w)
local column = logListView:AddColumn("Type")
column:SetFixedWidth(column2w)
local column = logListView:AddColumn("Details")
column:SetFixedWidth(w - column1w - column2w)