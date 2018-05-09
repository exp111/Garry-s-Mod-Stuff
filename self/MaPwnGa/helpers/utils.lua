function ValidTarget(target, visibleOnly)
    if !target:IsValid() then return false end
    if target == LocalPlayer() then return false end
    if target:IsPlayer() then
        if target:Team() == TEAM_SPECTATOR then return false end
        if !target:Alive() then return false end
    elseif !target:IsNPC() then return false end
    if visibleOnly and !LocalPlayer():IsLineOfSightClear(target) then return false end
    return true
end

function ForceKey(cmd, KeyCode)
    if !LocalPlayer():KeyDown(KeyCode) then --No need if already pressed
        cmd:SetButtons(cmd:GetButtons() + KeyCode)
    end
end