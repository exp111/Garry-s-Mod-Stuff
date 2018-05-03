include("convars.lua")
include("UI/main/main.lua")

hook.Add("Think", "Main", function()
    if LocalPlayer():KeyPressed(IN_SCORE) then
        mainPanel:ToggleVisible()
    end
end)