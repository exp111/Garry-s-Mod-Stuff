--require("bSendPacket")

--CONVARS
fakeAnglesConVar = CreateClientConVar("exp_test_fakeangles", "0", false)
fakeLagConVar = CreateClientConVar("exp_test_fakelag", "0", false)

--FAKEANGLES
local Switch = false
local FakeAngle = Angle()

local function FakeSideways(cmd)
    if !fakeAnglesConVar:GetBool() then return end

    FakeAngle = cmd:GetViewAngles()

    if Switch then
        bSendPacket = true
        cmd:SetViewAngles(Angle(-192, FakeAngle.y + 90, 0))
    else
        bSendPacket = false
        cmd:SetViewAngles(Angle(-192, FakeAngle.y - 90, 0))
    end

    Switch = !Switch
end

hook.Add("CreateMove", "FakeSideways", FakeSideways)

local q = 0

local function FakeLag(cmd)
    if !fakeLagConVar:GetBool() then bSendPacket = true return end
    
    q = q + 1

    if q >= 0 then
        if q < 15 then
            bSendPacket = false
        else
            bSendPacket = true
        end
    else
        bSendPacket = true
    end
        
    if q >= 15 then
        q = 0
    end
end

hook.Add("CreateMove", "FakeLag", FakeLag)