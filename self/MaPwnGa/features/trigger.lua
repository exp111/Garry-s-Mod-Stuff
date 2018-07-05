if !IsExternal then
    include("../convars.lua")
    include("../helpers/utils.lua")
end

function Triggerbot(cmd)
	if !triggerConVar:GetBool() then return end

    local activeWeapon = LocalPlayer():GetActiveWeapon()
    if !activeWeapon or !activeWeapon:IsValid() or activeWeapon:Clip1() <= 0 then return end

    if triggerOnKeyConVar:GetBool() and (!input.IsKeyDown(triggerKeyConVar:GetInt()) and !input.IsMouseDown(triggerKeyConVar:GetInt())) then return end

	local ent = LocalPlayer():GetEyeTrace().Entity
	if !ValidTarget(ent, false, 0) then return end
	
    ForceKey(cmd, IN_ATTACK)
end