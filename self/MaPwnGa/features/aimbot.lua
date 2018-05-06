include("../convars.lua")
include("../helpers/math.lua")
include("../helpers/utils.lua")

function Aimbot(cmd)
    if !aimbotConVar:GetBool() then return end

    if !input.IsKeyDown(aimbotKeyConVar:GetInt()) and !input.IsMouseDown(aimbotKeyConVar:GetInt()) then return end
    --Aimbot Stuff

    local bestTarget = nil
    local bone = aimbotBoneConVar:GetString()
    for k, v in pairs(ents.GetAll()) do
        if !ValidTarget(v, true) then continue end

        if !CheckAimbotFOV(LocalPlayer(), v, aimbotFOVConVar:GetInt(), bone) then continue end

        bestTarget = v
    end

    if bestTarget == nil then return end

    local targetheadpos = GetBonePos(bestTarget, bone)
	cmd:SetViewAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
end