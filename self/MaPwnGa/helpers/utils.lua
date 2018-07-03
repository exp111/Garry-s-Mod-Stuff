function ValidTarget(target, visibleOnly, allowedDistance)
    if !target:IsValid() then return false end
    if target == LocalPlayer() then return false end
    if target:IsPlayer() then
        if target:Team() == TEAM_SPECTATOR then return false end
        if !target:Alive() then return false end
    elseif !target:IsNPC() then return false end
    if visibleOnly and !LocalPlayer():IsLineOfSightClear(target) then return false end
    if allowedDistance != 0 and (LocalPlayer():GetShootPos():Distance(target:GetPos()) > allowedDistance) then return false end
    return true
end

function ValidEntity(target, visibleOnly, allowedDistance)
    if !target:IsValid() then return false end
    if target == LocalPlayer() then return false end
    if visibleOnly and !LocalPlayer():IsLineOfSightClear(target) then return false end
    if allowedDistance != 0 and (LocalPlayer():GetShootPos():Distance(target:GetPos()) > allowedDistance) then return false end
    return true
end

function ForceKey(cmd, KeyCode)
    if !LocalPlayer():KeyDown(KeyCode) then --No need if already pressed
        cmd:SetButtons(cmd:GetButtons() + KeyCode)
    end
end

function IsTTT()
    return (GAMEMODE and GAMEMODE.Name and string.find(GAMEMODE.Name, "Terror") and true)
end

function Log(text)
    local toLog = os.date("[%H:%M:%S] Log: ", os.time()).. text
    print(toLog)
    chat.AddText(toLog)
end

function IsEnemy(entity)
    return entity:Team() != LocalPlayer():Team() or (IsTTT() and entity.role and LocalPlayer().role and entity.role != LocalPlayer().role)
end