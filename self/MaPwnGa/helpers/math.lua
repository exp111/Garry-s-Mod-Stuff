function CheckAimbotFOV(ply, target, fov, bone)
    --Thanks shitcheat
    --Weird math is weird
    local playerAngles = ply:GetAngles()
    local targetPos = target:GetBonePosition(target:LookupBone(bone))
    if targetPos == nil then targetPos = target:GetPos() + target:OBBCenter() end
    local targetAngles = (targetPos - ply:GetPos()):Angle()
    local ady = math.abs(math.NormalizeAngle(playerAngles.y - targetAngles.y))
    local adx = math.abs(math.NormalizeAngle(playerAngles.x - targetAngles.x ))
    return !(ady > fov or adx > fov)
end

function GetBonePos(target, boneString)
	if target:IsValid() and target:Health() > 0 then
        local bone = target:LookupBone(boneString)
		if  bone != nil then
			local bonePos=target:GetBonePosition(bone)
			return bonePos
		else --Bone not found? aim at center of the target then /shrug
			local bonePos = target:GetPos() + target:OBBCenter()
			return bonePos
		end
	end
end