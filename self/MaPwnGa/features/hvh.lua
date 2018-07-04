include("../convars.lua")
include("../helpers/math.lua")

local function FixMovement(cmd, oldAngles, needsMod)
	local move = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), 0);
	local speed = math.sqrt(move.x * move.x + move.y * move.y);
	local ang = move:Angle();
	local yaw = math.rad(cmd:GetViewAngles().y - oldAngles.y + ang.y)
    local mod = (needsMod and -1) or 1

	cmd:SetForwardMove((math.cos(yaw) * speed) * mod)
	cmd:SetSideMove(math.sin(yaw) * speed);
end

local function FakeView(cmd)
	if !fakeView then fakeView = cmd:GetViewAngles() end

	fakeView = fakeView + Angle(cmd:GetMouseY() * 0.023, cmd:GetMouseX() * -0.023, 0)
	fakeView:Normalize()
	fakeView.x = math.Clamp(fakeView.x, -89, 89)
	if cmd:CommandNumber() == 0 then
		cmd:SetViewAngles(fakeView)
		return
	end
end

function AntiAim(cmd)
    FakeView(cmd)

    if !antiAimConVar:GetBool() then return end

    if ((cmd:CommandNumber() == 0 and !ThirdPersonConVar:GetBool()) or cmd:KeyDown(IN_USE) or cmd:KeyDown(IN_ATTACK)) then return end

    --BACKUP SHIT
    local oldAngles = cmd:GetViewAngles()
    local oldForward = cmd:GetForwardMove()
    local oldSide = cmd:GetSideMove()

    local angle = oldAngles
    --DO AA
    local aaType = antiAimTypeConVar:GetInt()
    if aaType == 1 then //EyeAngles
		angle.y = fakeView.y;
	elseif aaType == 2 then //Sideways
		angle.y = fakeView.y - 90;
    elseif aaType == 3 then //Jitter
        angle.y = fakeView.y + math.random(-90, 90)
    elseif aaType == 4 then //Static
        angle.y = 0
    elseif aaType == 5 then //Forward
		angle.y = fakeView.y;
	elseif aaType == 6 then //Backwards
		angle.y = fakeView.y - 180;
    end

    --SET THE SHIT
    cmd:SetViewAngles(Angle(angle.x, math.NormalizeAngle(angle.y), 0))
    --Movement Fix cuz we don't wanna be one of the drunks
    //CorrectMovement(cmd, oldAngles, oldForward, oldSide)
    local x = angle.x
    FixMovement(cmd, angle, x > 89 or x < -89)
end