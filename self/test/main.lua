include("convars.lua")
include("UI/main.lua")

hook.Add("Think", "Main", function()
    if LocalPlayer():KeyPressed(IN_SCORE) then
        mainPanel:ToggleVisible()
    end
end)