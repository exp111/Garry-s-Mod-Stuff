include("../convars.lua")
include("../helpers/utils.lua")

function Triggerbot(cmd)
	if !triggerConVar:GetBool() then return end

	if !LocalPlayer():Alive() then return end
    if !LocalPlayer():GetActiveWeapon() or LocalPlayer():GetActiveWeapon():Clip1() <= 0 then return end

	local ent = LocalPlayer():GetEyeTrace().Entity
	if !ValidTarget(ent, false) then return end
	
     if !LocalPlayer():KeyDown(IN_ATTACK) then --No need if already pressed
        cmd:SetButtons(cmd:GetButtons() + IN_ATTACK)
    end
end