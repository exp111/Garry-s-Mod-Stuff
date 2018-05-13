include("../convars.lua")
include("../helpers/math.lua")
include("../helpers/utils.lua")

local function Salt(smooth)
    local sine = math.sin(os.time());
	local salt = sine * aimbotSaltConVar:GetFloat();
	local oval = smooth + salt;
	return smooth * oval;
end

local function Smooth(cmd, angle)
    local viewAngles = cmd:GetViewAngles()

	local delta = angle - viewAngles
    delta:Normalize()

	local smooth = math.pow(aimbotSmoothConVar:GetFloat(), 0.4) // Makes more slider space for actual useful values
	smooth = math.min(0.99, smooth)

    if aimbotSaltConVar:GetFloat() > 0 then
        smooth = Salt(smooth)
    end

	local toChange = delta - (delta * smooth)

	return viewAngles + toChange
end

function Aimbot(cmd)
    if !aimbotConVar:GetBool() then return end

    if !input.IsKeyDown(aimbotKeyConVar:GetInt()) and !input.IsMouseDown(aimbotKeyConVar:GetInt()) then return end
    --Aimbot Stuff

    local bestTarget = nil
    local bestFOV = aimbotFOVConVar:GetInt()
    for k, v in pairs(ents.GetAll()) do
        if !ValidTarget(v, true) then continue end

        local fov = GetAimbotFOV(LocalPlayer(), v)
        if fov > bestFOV then continue end

        bestFOV = fov
        bestTarget = v
    end

    if !bestTarget then return end

    local targetHeadPos = GetBonePos(bestTarget, aimbotBoneConVar:GetString())
    if !targetHeadPos then return end
    local angle = (targetHeadPos - LocalPlayer():GetShootPos()):Angle()

    if aimbotSmoothConVar:GetFloat() > 0 then
        angle = Smooth(cmd, angle)
    end

	cmd:SetViewAngles(angle)
end