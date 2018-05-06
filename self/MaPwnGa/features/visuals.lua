include("../convars.lua")
include("../helpers/utils.lua")

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

local perfectCounter = {}
local perfectStep = math.pi * 0.005;
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
            if !ValidTarget(v, ESPVisibleOnlyConVar:GetBool()) then continue end

            --Name
            if ESPNameConVar:GetBool() then
                local name = GetName(v)
                local pos = (v:GetPos() + Vector(0, 0, 80)):ToScreen()
                draw.DrawText(name, "DermaDefault", pos.x, pos.y, textcolor, TEXT_ALIGN_CENTER)
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
        end
    end

    if PerfectHeadAdjustmentConVar:GetBool() then
        if !changed then
            changed = true
        end
        for k,v in pairs(ents.GetAll()) do
            if !ValidTarget(v, false) then continue end

            local bone = v:LookupBone("ValveBiped.Bip01_Head1")
            if bone <= 0 then continue end

            if perfectCounter[k] == nil or perfectCounter[k] > (math.pi * 2.0) then perfectCounter[k] = 0 end
            perfectCounter[k] = perfectCounter[k] + perfectStep;

            if PerfectHeadAdjustmentPositionConVar:GetBool() then
                v:ManipulateBonePosition(bone, Vector(20 * math.sin(perfectCounter[k]),10, 20 * math.cos(perfectCounter[k])))
            else
                --Reset then
                if v:GetManipulateBonePosition(bone) != Vector(0, 0, 0) then
                    v:ManipulateBonePosition(bone, Vector(0, 0, 0))
                end
            end
            if PerfectHeadAdjustmentScaleConVar:GetBool() then
                local cur = 5 * math.abs(math.sin(perfectCounter[k]))
                v:ManipulateBoneScale(bone, Vector(cur, cur, cur))
            else
                --Reset then
                if v:GetManipulateBoneScale(bone) != Vector(1, 1, 1) then
                    v:ManipulateBoneScale(bone, Vector(1, 1, 1))
                end
            end
        end
    else
        if changed then
            for k,v in pairs(ents.GetAll()) do  
                if v:HasBoneManipulations() then
                    local bone = v:LookupBone("ValveBiped.Bip01_Head1")
                    v:ManipulateBonePosition(bone, Vector(0,0,0))
                    v:ManipulateBoneScale(bone, Vector(1, 1, 1))
                end
            end
        end
    end
end