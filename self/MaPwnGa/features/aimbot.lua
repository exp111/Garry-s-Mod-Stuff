include("../convars.lua")
include("../helpers/math.lua")

function Aimbot(cmd)
    if !aimbotConVar:GetBool() then return end

    if !input.IsKeyDown(aimbotKeyConVar:GetInt()) and !input.IsMouseDown(aimbotKeyConVar:GetInt()) then return end
    --Aimbot Stuff

    local bestTarget = nil
    local bone = aimbotBoneConVar:GetString()
    for k, v in pairs(ents.GetAll()) do
        if !v:IsValid() then continue end
        if v == LocalPlayer() then continue end
        if v:IsPlayer() then
            if v:Team() == TEAM_SPECTATOR then continue end
            if !v:Alive() then continue end
        elseif !v:IsNPC() then continue end
        if !LocalPlayer():IsLineOfSightClear(v) then continue end

        if !CheckAimbotFOV(LocalPlayer(), v, aimbotFOVConVar:GetInt(), bone) then continue end

        bestTarget = v
    end

    if bestTarget == nil then return end

    local targetheadpos = GetBonePos(bestTarget, bone)
	cmd:SetViewAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
end