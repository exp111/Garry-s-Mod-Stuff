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

            --BONE ESP
            local boneCount = v:GetBoneCount()
            if boneCount > -1 then
                for i = v:GetBoneCount() - 1, 0, -1 do
                    if !v:BoneHasFlag(i, BONE_USED_BY_HITBOX) then continue end
                    local bonePos = v:GetBonePosition(i);
                    if bonePos == nil then continue end
                    --if v:GetBoneParent(i) == -1 then continue end
                    local cur = bonePos:ToScreen()
                    local childs = v:GetChildBones(i)

                    for l, w in pairs(childs) do
                        local childPos = v:GetBonePosition(w)
                        /*This is a real shitty fix cuz we don't know if there is a child bone that is at v:GetPos() but fuck it*/
                        if childPos == nil or childPos == v:GetPos() then continue end
                        local curChild = childPos:ToScreen()
                        surface.SetDrawColor(255, 0, 255)
                        surface.DrawLine(cur.x, cur.y, curChild.x, curChild.y)
                    end
                end
            end
        end
    end
end