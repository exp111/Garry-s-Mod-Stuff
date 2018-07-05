if !IsExternal then
    include("../convars.lua")
    include("../helpers/utils.lua")
    include("../helpers/math.lua")
end

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

local function DrawBones(target)
    local boneCount = target:GetBoneCount()
    if boneCount > -1 then
        for i = target:GetBoneCount() - 1, 0, -1 do
            if !target:BoneHasFlag(i, BONE_USED_BY_HITBOX) then continue end
            local bonePos = target:GetBonePosition(i);
            if bonePos == nil then continue end
            local cur = bonePos:ToScreen()
            local childs = target:GetChildBones(i)
            for l, w in pairs(childs) do
                local childPos = target:GetBonePosition(w)
                /*This is a real shitty fix cuz we don't know if there is a child bone that is at v:GetPos() but fuck it*/
                if childPos == nil or childPos == target:GetPos() then continue end
                local curChild = childPos:ToScreen()
                surface.SetDrawColor(255, 0, 255)
                surface.DrawLine(cur.x, cur.y, curChild.x, curChild.y)
            end
        end
    end
end

local function GetRect(target)
    --I stole this from shitcheat too
    local min, max = target:GetCollisionBounds()
    local pos = target:GetPos()
    local top, bottom = (pos + Vector(0, 0, max.z)):ToScreen(), (pos - Vector(0, 0, 8)):ToScreen()
    local height = bottom.y - top.y
	local width = height / 2.425
    return top, bottom, height, width
end

local function Draw2DBox(target, top, bottom, height, width)
	surface.SetDrawColor(Color(255, 0, 0))
	surface.DrawOutlinedRect(bottom.x - width / 2, top.y, width / 0.9, height)
	surface.SetDrawColor(Color(0, 0, 0))
	surface.DrawOutlinedRect(bottom.x - width / 2 + 1, top.y + 1, width / 0.9 - 2, height - 2)
	surface.DrawOutlinedRect(bottom.x - width / 2 - 1, top.y - 1, width / 0.9 + 2, height + 2)
end

local function DrawSnapline(target, bone)
    local ePos = GetBonePos(target, bone)
    if ePos == nil then return end
    ePosS = ePos:ToScreen()
    surface.SetDrawColor(Color(255, 0, 0))
    surface.DrawLine(ScrW() / 2, ScrH() / 2, ePosS.x, ePosS.y)
end

--Main ESP Function
function ESP()
    --ESP
    if ESPConVar:GetBool() then
        local entities = {}
        for k,v in pairs(ents.GetAll()) do
            if !ValidTarget(v, ESPVisibleOnlyConVar:GetBool(), ESPDistanceConVar:GetInt()) then 
                if ValidEntity(v, ESPVisibleOnlyConVar:GetBool(), ESPDistanceConVar:GetInt()) then --TODO: oh boi we (possibly) double check if target is visible
                    if ESPDroppedWeaponConVar:GetBool() then
                        if v:IsWeapon() and v:GetOwner() == NULL then
                            local name = v:GetPrintName()
                            if name then
                                local pos = v:GetPos():ToScreen()
                                draw.DrawText(language.GetPhrase(name), "DermaDefault", pos.x, pos.y, textcolor, TEXT_ALIGN_CENTER)
                            end
                        end
                    end
                end

                continue
            end

            local top, bottom, height, width = GetRect(v)
            --Name
            if ESPNameConVar:GetBool() then
                local name = GetName(v)
                local pos = (v:GetPos() + Vector(0, 0, 100)):ToScreen()
                draw.DrawText(name, "DermaDefault", pos.x, pos.y, textcolor, TEXT_ALIGN_CENTER)
            end

            --WEAPON
            if ESPWeaponConVar:GetBool() and v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() then
                local name = v:GetActiveWeapon():GetPrintName()
                if name then
                    local pos = (v:GetPos() + Vector(0, 0, 90)):ToScreen()
                    draw.DrawText(language.GetPhrase(name), "DermaDefault", pos.x, pos.y, textcolor, TEXT_ALIGN_CENTER)
                end
            end

            --BONE ESP
            if ESPBoneConVar:GetBool() then
                DrawBones(v)
            end

            --3D BOX
            if ESP3DBoxConVar:GetBool() then
                cam.Start3D()
                render.DrawWireframeBox( v:GetPos(), Angle( 0, v:EyeAngles().y, 0), v:OBBMins(), v:OBBMaxs(), Color(255, 0, 0) )
                cam.End3D()
            end

            --2D Box
            if ESP2DBoxConVar:GetBool() then
                Draw2DBox(v, top, bottom, height, width)
            end
			
            --HEALTH
            if ESPHealthConVar:GetBool() then
                local hOffset = width / 10 + width / 20
                local hPercentage = (v:Health() / v:GetMaxHealth())
                if (width > 10) then
                    surface.SetDrawColor(Color(0, 0, 0))  
                    surface.DrawOutlinedRect(bottom.x - width / 2 - hOffset - 1, top.y - 1, width / 10 + 3, height + 2)
                end
                surface.SetDrawColor(Color(0, 255, 0))
                surface.DrawRect(bottom.x - width / 2 - hOffset, (1 - hPercentage) * height + top.y, width / 10 + 1, height * hPercentage)
            end

            --GLOW
            if ESPGlowConVar:GetBool() then
                entities[#entities + 1] = v
            end

            --SNAPLINES
            if aimbotConVar:GetBool() and aimbotSnaplinesConVar:GetBool() then
                if CheckAimbotFOV(LocalPlayer(), v, aimbotFOVConVar:GetInt()) then
                    DrawSnapline(v, aimbotBoneConVar:GetString())
                end
            end
        end

        --GLOW (again)
        if ESPGlowConVar:GetBool() and #entities > 0 then
            halo.Add(entities, Color(255, 0, 0), 1, 1, 1, true, !ESPVisibleOnlyConVar:GetBool())
        end
    end
end