include("convars.lua")

include("UI/main/main.lua")
include("UI/radar/main.lua")
include("UI/spectator/main.lua")

include("features/esp.lua")
include("features/aimbot.lua")
include("features/trigger.lua")
include("features/misc.lua")
include("features/chams.lua")
include("features/hvh.lua")

local function CheckPanel(bool, panel)
    local panelVisible = panel:IsVisible()
    if bool and !panelVisible then
        panel:SetVisible(true)
    elseif !bool and panelVisible then
        panel:SetVisible(false)
    end
end

hook.Add("Think", "Main", function()
    if LocalPlayer():KeyPressed(IN_SCORE) then
        menuPanel:ToggleVisible()
    end

    --Setting the radar and other windows visible
    CheckPanel(radarConVar:GetBool(), radarPanel)
    CheckPanel(spectatorConVar:GetBool(), spectatorPanel)
end)

hook.Add("CreateMove", "HookCreateMove", function(cmd)
    --If CUserCmd is faulty/not valid no need to do the other shit
    if !cmd or cmd:CommandNumber() == 0 then return end

    if LocalPlayer() and LocalPlayer():Alive() then
        AntiAim(cmd)

        Aimbot(cmd)
        Triggerbot(cmd)
        NoRecoil()
        AutoPistol(cmd)
    end

    CheckForTraitors()
end)

hook.Add("HUDPaint", "Visuals", function()
    ESP()
    MiscVisuals()
end)

hook.Add("RenderScreenspaceEffects", "Chams", function()
    Chams()
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

gameevent.Listen("player_hurt")
hook.Add("player_hurt", "PlayerHurt", function(data)
    local ply = Player(data.userid)
    if !ply then
        return 
    end
    local attacker = Player(data.attacker)
    if !attacker or data.attacker == 0 then
        Log(ply:Name() .. " (".. data.userid ..") was hurt and has " .. data.health .. " Health left!")
    else
	    Log(ply:Name() .. " (".. data.userid ..") was hurt by " .. attacker:Name() .. " (".. data.attacker ..") and has " .. data.health .. " Health left!")
    end
end)

hook.Add("OnEntityCreated", "TTTCorpseDetector", function(entity)
    TTTCorpseDetector(entity)
end)

hook.Add("TTTPrepareRound", "TTTPrepareRound", function()
    ResetTTTTables()
end)

hook.Add("TTTBeginRound", "TTTBeginRound", function()
    ResetTTTTables()
end)