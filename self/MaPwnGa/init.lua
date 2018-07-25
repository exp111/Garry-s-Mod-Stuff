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

concommand.Add("exp_test_randomstring", function()
    print(GetRandomString())
end)

local function CheckPanel(bool, panel)
    local panelVisible = panel:IsVisible()
    if bool and !panelVisible then
        panel:SetVisible(true)
    elseif !bool and panelVisible then
        panel:SetVisible(false)
    end
end

--THINK HOOK
hook.Add("Think", GetRandomString(), function()
    if input.IsButtonDown(KEY_INSERT) and !menuPanel:IsVisible() then
        menuPanel:SetVisible(true)
    end

    --Setting the radar and other windows visible
    CheckPanel(radarConVar:GetBool(), radarPanel)
    CheckPanel(spectatorConVar:GetBool(), spectatorPanel)
end)

--CREATE MOVE HOOK
hook.Add("CreateMove", GetRandomString(), function(cmd)
    --If CUserCmd is faulty/not valid no need to do the other shit
    if !cmd or cmd:CommandNumber() == 0 then return end

    if LocalPlayer() and LocalPlayer():Alive() then
        FreeCamCreateMove(cmd)
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

--HUDPAINT HOOK | VISUALS
hook.Add("HUDPaint", GetRandomString(), function()
    ESP()
    MiscVisuals()
end)

--PREDRAWVIEWMODEL | NOHANDS
hook.Add("PreDrawViewModel", GetRandomString(), function(viewmodel, ply, weapon)
    NoHands(weapon)
end)

--PREDRAWPLAYERHANDS | HANDS CHAMS
hook.Add("PreDrawPlayerHands", GetRandomString(), function()
    HandsChams()
end)

--RENDERSCREENSPACEEFFECTS | CHAMS
hook.Add("RenderScreenspaceEffects", GetRandomString(), function()
    Chams()
end)

--CALCVIEW | FAKEVIEW, -CAM & THIRDPERSON
hook.Add("CalcView", GetRandomString(), function(ply, pos, angles, fov)
    local angle = angles
    local f = (!fovConVar:GetBool() and fov) or fovConVar:GetInt() --fovConVar == 0 -> use normal
    if fakeView and antiAimConVar:GetBool() then angle = fakeView end
    pos = FreeCam(pos, angle)
	return ThirdPerson(ply, pos, angle, f) --TODO: maybe return changed values here and then return the whole thing?
end)

--ONPLAYERCHAT | SPONGEMOCK
hook.Add("OnPlayerChat", GetRandomString(), function( ply, strText, bTeam, bDead )
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

--FULLBRIGHT HOOKS
hook.Add("PreRender", GetRandomString(), FullbrightPreRender)

hook.Add("PostRender", GetRandomString(), FullbrightDisable)
hook.Add("PreDrawHUD", GetRandomString(), FullbrightDisable)

--EVENTS
gameevent.Listen("player_hurt")
hook.Add("player_hurt", GetRandomString(), function(data)
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
hook.Add("entity_killed", GetRandomString(), function(data)
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
hook.Add("server_cvar", GetRandomString(), function(data)
    local name = data.cvarname
    local value = data.cvarvalue
    Log("The ConVar " .. name .. " was changed to " .. value ..".", icons.shieldIcon)
end)

gameevent.Listen("player_connect")
hook.Add("player_connect", GetRandomString(), function(data)
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
hook.Add("player_disconnect", GetRandomString(), function(data)
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

--ONENTITYCREATED | TTT CORPSE DETECTOR
hook.Add("OnEntityCreated", GetRandomString(), function(entity)
    TTTCorpseDetector(entity)
end)

--TTTPREPAREROUND & TTTBEGINROUND
hook.Add("TTTPrepareRound", GetRandomString(), function()
    ResetTTTTables()
end)

hook.Add("TTTBeginRound", GetRandomString(), function()
    ResetTTTTables()
end)