include("convars.lua")

include("UI/main/main.lua")
include("UI/radar/main.lua")

include("features/esp.lua")
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
    if !cmd or cmd:CommandNumber() == 0 then return end

    if LocalPlayer() and LocalPlayer():Alive() then
        Aimbot(cmd)
        Triggerbot(cmd)
        NoRecoil()
    end

    CheckForTraitors()
end)

hook.Add("HUDPaint", "Visuals", function()
    ESP()
    MiscVisuals()
end)

hook.Add("CalcView", "ThirdPerson", function(ply, pos, angles, fov)
	return ThirdPerson(ply, pos, angles, fov)
end)

hook.Add("OnPlayerChat", "OnChat", function( ply, strText, bTeam, bDead )
	if (ply == LocalPlayer()) then 
        if string.StartWith(string.lower(strText), "/spongemock") then
            local text = SpongeMockify(string.sub(strText, 13))
            if text then
                print("say " .. text)
                RunConsoleCommand("say", text)
            end
            return true
        end
    end

    if spongeMockConVar:GetBool() then
	    local text = SpongeMockify(strText)
        if text then
            print("say " .. text)
            RunConsoleCommand("say", text)
        end
        return false
    end

end)