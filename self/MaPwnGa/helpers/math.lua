function GetAimbotFOV(ply, target)
    local playerAngles = ply:GetAngles()
    local targetAngles = (target:GetPos() - ply:GetPos()):Angle()
    local ady = math.abs(math.NormalizeAngle(playerAngles.y - targetAngles.y))
    local adx = math.abs(math.NormalizeAngle(playerAngles.x - targetAngles.x ))
    return math.max(ady, adx)
end

function CheckAimbotFOV(ply, target, fov)
    --Thanks shitcheat
    --Weird math is weird
    local max = GetAimbotFOV(ply, target)
    return !(max > fov)
end

function GetBonePos(target, boneString)
	if target:IsValid() and target:Health() > 0 then
        local bone = target:LookupBone(boneString)
		if bone then
			return target:GetBonePosition(bone)
		else --Bone not found? aim at center of the target then /shrug
			return target:GetPos() + target:OBBCenter()
		end
	end
end

function RotatePoint(pointToRotate, centerPoint, angle, isAngleInRadians)
	if !angleInRadians then
		angle = math.rad(angle)
    end
	local cosTheta = math.cos(angle)
	local sinTheta = math.sin(angle)
	local returnVec = Vector(
		cosTheta * (pointToRotate.x - centerPoint.x) - sinTheta * (pointToRotate.y - centerPoint.y),
		sinTheta * (pointToRotate.x - centerPoint.x) + cosTheta * (pointToRotate.y - centerPoint.y),
		0)
	returnVec = returnVec + centerPoint;
	return returnVec;
end