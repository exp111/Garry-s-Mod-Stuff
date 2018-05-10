function CheckAimbotFOV(ply, target, fov)
    --Thanks shitcheat
    --Weird math is weird
    local playerAngles = ply:GetAngles()
    local targetAngles = (target:GetPos() - ply:GetPos()):Angle()
    local ady = math.abs(math.NormalizeAngle(playerAngles.y - targetAngles.y))
    local adx = math.abs(math.NormalizeAngle(playerAngles.x - targetAngles.x ))
    return !(ady > fov or adx > fov)
end

function GetBonePos(target, boneString)
	if target:IsValid() and target:Health() > 0 then
        local bone = target:LookupBone(boneString)
		if  bone != nil then
			return target:GetBonePosition(bone)
		else --Bone not found? aim at center of the target then /shrug
			return target:GetPos() + target:OBBCenter()
		end
	end
end