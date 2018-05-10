include("../convars.lua")
include("../helpers/math.lua")
include("../helpers/utils.lua")

function Aimbot(cmd)
    if !aimbotConVar:GetBool() then return end

    if !input.IsKeyDown(aimbotKeyConVar:GetInt()) and !input.IsMouseDown(aimbotKeyConVar:GetInt()) then return end
    --Aimbot Stuff

    local bestTarget = nil
    for k, v in pairs(ents.GetAll()) do
        if !ValidTarget(v, true) then continue end

        if !CheckAimbotFOV(LocalPlayer(), v, aimbotFOVConVar:GetInt()) then continue end

        bestTarget = v
    end

    if bestTarget == nil then return end

    local targetHeadPos = GetBonePos(bestTarget, aimbotBoneConVar:GetString())
    if targetHeadPos == nil then return end
	cmd:SetViewAngles((targetHeadPos - LocalPlayer():GetShootPos()):Angle())
end