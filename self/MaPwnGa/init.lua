if !IsExternal then
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
end

concommand.Add("exp_ttt_role", function(ply, cmd, args)
    if #args < 1 then print("Usage: exp_ttt_role <0|1|2> (Innocent | Traitor | Detective)") return end
    local arg = tonumber(args[1])
    if !arg then print("'" .. args[1] .. "' is not a number!") return end

    ply.role = arg
end)

concommand.Add("exp_ttt_credits", function(ply, cmd, args)
    if #args < 1 then print("Usage: exp_ttt_credits <number>") return end
    local arg = tonumber(args[1])
    if !arg then print("'" .. args[1] .. "' is not a number!") return end

    ply.equipment_credits = arg
end)

local function CheckPanel(bool, panel)
    local panelVisible = panel:IsVisible()
    if bool and !panelVisible then
        panel:SetVisible(true)
    elseif !bool and panelVisible then
        panel:SetVisible(false)
    end
end

hook.Add("Think", "Main", function()
    if input.IsButtonDown(KEY_INSERT) and !menuPanel:IsVisible() then
        menuPanel:SetVisible(true)
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

        BHop(cmd)
        AutoStrafe(cmd)
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
    local angle = angles
    local f = (!fovConVar:GetBool() and fov) or fovConVar:GetInt() --fovConVar == 0 -> use normal
    if fakeView and antiAimConVar:GetBool() then angle = fakeView end
	return ThirdPerson(ply, pos, angle, f)
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

hook.Add("PreRender", "Fullbright", FullbrightPreRender)

hook.Add("PostRender", "Fullbright", FullbrightDisable)
hook.Add("PreDrawHUD", "Fullbright", FullbrightDisable)

--EVENTS
gameevent.Listen("player_hurt")
hook.Add("player_hurt", "PlayerHurt", function(data)
    local ply = Player(data.userid)
    if !ply then
        return 
    end
    local attacker = Player(data.attacker)
    if !attacker or data.attacker == 0 then
        Log(ply:Name() .. " (".. data.userid ..") was hurt and has " .. data.health .. " Health left!", icons.unhappyIcon)
    else
	    Log(ply:Name() .. " (".. data.userid ..") was hurt by " .. attacker:Name() .. " (".. data.attacker ..") and has " .. data.health .. " Health left!", icons.unhappyIcon)
    end
end)

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "EntityKill", function(data)
    local killed = Entity(data.entindex_killed)
    if !killed then
        return 
    end
    local attacker = Entity(data.entindex_attacker)
    
    local killedName = ((killed:IsPlayer() and killed:Nick()) or killed:GetClass())
    local attackerName = ((attacker:IsPlayer() and attacker:Nick()) or attacker:GetClass())

    if !attacker or data.entindex_attacker == 0 then
        Log(killedName .. " (".. data.entindex_killed ..") was killed!", icons.skullIcon)
    else
	    Log(killedName .. " (".. data.entindex_killed ..") was killed by " .. attackerName .. " (".. data.entindex_attacker ..")!", icons.skullIcon)
    end
end)

gameevent.Listen("server_cvar")
hook.Add("server_cvar", "ServerCVar", function(data)
    local name = data.cvarname
    local value = data.cvarvalue
    Log("The ConVar " .. name .. " was changed to " .. value ..".", icons.shieldIcon)
end)

gameevent.Listen("player_connect")
hook.Add("player_connect", "playerConnect", function(data)
	local name = data.name
	local steamid = data.networkid
	local ip = data.address
	local id = data.userid
	local isBot = data.bot
	local index = data.index

    if isBot then
        Log(name .. " (Bot, Index: " .. index .. ", ID: ".. id .. ") has connected.", icons.connectIcon)
    else
        Log(name .. " (Index: " .. index .. ", ID: ".. id .. ", SteamID: " .. steamid .. ") has connected from " .. ip .. ".", icons.connectIcon)
    end
end)

gameevent.Listen( "player_disconnect" )
hook.Add("player_disconnect", "playerDisconnect", function(data)
	local name = data.name
	local steamid = data.networkid
	local id = data.userid
	local isBot = data.bot
	local reason = data.reason

    if isBot then
        Log(name .. " (Bot, ID: ".. id .. ") has disconnected. Reason: " .. reason .. ".", icons.disconnectIcon)
    else
        Log(name .. " (ID: ".. id .. ", SteamID: " .. steamid .. ") has disconnected. Reason: " .. reason .. ".", icons.disconnectIcon)
    end
end)
--END EVENTS

hook.Add("OnEntityCreated", "TTTCorpseDetector", function(entity)
    TTTCorpseDetector(entity)
end)

hook.Add("TTTPrepareRound", "TTTPrepareRound", function()
    ResetTTTTables()
end)

hook.Add("TTTBeginRound", "TTTBeginRound", function()
    ResetTTTTables()
end)