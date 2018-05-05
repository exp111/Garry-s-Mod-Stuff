include("../convars.lua")

function Triggerbot()
    if Shooting then
		RunConsoleCommand("-attack")
		Shooting=false	
	end

	if triggerConVar:GetBool() then
		if LocalPlayer():Alive() and LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():Clip1() > 0 then
			local ent = LocalPlayer():GetEyeTrace().Entity
			if ent:IsValid() and (ent:IsNPC() or ent:Team() != TEAM_SPECTATOR and ent:Alive()) then
				if not Shooting then
					RunConsoleCommand( "+attack" )
					Shooting = true
				end
			end
		end
	end
end