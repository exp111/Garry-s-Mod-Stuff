include("convars.lua")

include("UI/main/main.lua")
include("UI/radar/main.lua")

include("features/visuals.lua")
include("features/aimbot.lua")
include("features/trigger.lua")
include("features/misc.lua")

hook.Add("Think", "Main", function()
    if LocalPlayer():KeyPressed(IN_SCORE) then
        menuPanel:ToggleVisible()
    end

    --Setting the radar visible breaks somehow the menu key check
    if radarConVar:GetBool() and !radarPanel:IsVisible() then
        radarPanel:SetVisible(true)
    elseif !radarConVar:GetBool() and radarPanel:IsVisible() then
        radarPanel:SetVisible(false)
    end
end)

hook.Add("CreateMove", "HookCreateMove", function(cmd)
    --If CUserCmd is faulty/not valid no need to do the other shit
    if cmd == nil or cmd:CommandNumber() == 0 then return end

    Aimbot(cmd)
    Triggerbot(cmd)
    CheckForTraitors()
end)

hook.Add("HUDPaint", "Visuals", function()
    Visuals()
    TTTCheckerVisuals()
end)