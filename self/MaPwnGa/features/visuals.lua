include("../convars.lua")

--Helper Functions
local function GetName(target)
	if target:IsPlayer() then
		return target:Name()
	elseif target:IsNPC() then
		return target:GetClass()
	else
		return target:GetModel()
	end
end

--Main Visuals Function
function Visuals()
    --FOV Circle
    if aimbotConVar:GetBool() and aimbotFOVCircleConVar:GetBool() then
        local radius = math.tan(math.rad(aimbotFOVConVar:GetInt()) / 2) / math.tan(math.rad(LocalPlayer():GetFOV()) / 2) * ScrW();
        surface.DrawCircle(ScrW() / 2, ScrH() / 2, radius, FOVCircleColor.r, FOVCircleColor.g, FOVCircleColor.b)
    end

    --ESP
    if ESPConVar:GetBool() then
        for k,v in pairs(ents.GetAll()) do
            if !v:IsValid() then continue end
            if v == LocalPlayer() then continue end
            if v:IsPlayer() then
                if v:Team() == TEAM_SPECTATOR then continue end
                if !v:Alive() then continue end
            elseif !v:IsNPC() then continue end
            --if !LocalPlayer():IsLineOfSightClear(v) then continue end

            --Name
            local name = GetName(v)
            local pos = (v:GetPos() + Vector(0, 0, 80)):ToScreen()
			draw.DrawText(name, "DermaDefault", pos.x, pos.y, textcolor, TEXT_ALIGN_CENTER)
        end
    end
end