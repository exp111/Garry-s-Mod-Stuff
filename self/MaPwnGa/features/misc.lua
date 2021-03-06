traitors = {}
function CheckForTraitors()
    if !TTTCheckerConVar:GetBool() then return end
    local _R = debug.getregistry()
    
    if(IsTTT()) then
        for k, v in ipairs(player.GetAll()) do
            if(v != LocalPlayer() and v:IsValid() and !table.HasValue(traitors, v) and v:Alive() and v:Team() != TEAM_SPECTATOR and !v:IsDetective()) then
                for l, w in pairs(_R.Player.GetWeapons(v)) do
                    if(IsValid(w)) then
                        if(w.CanBuy and table.HasValue(w.CanBuy, ROLE_TRAITOR)) then
                            Log(v:Nick().." has got Weapon " .. language.GetPhrase(w:GetPrintName()) .. " and is probably a traitor!", icons.gunIcon)
                            traitors[#traitors + 1] = v
                        end
                    end
                end
            end
        end
    end
end

corpses = {}
function TTTCheckerVisuals()
    if !LocalPlayer() or !IsTTT() then return end

    if TTTCheckerConVar:GetBool() then
        local ent = LocalPlayer():GetEyeTrace().Entity
        if ent and ent:IsValid() then
            local pos = ent:GetPos()

            if table.HasValue(traitors, ent) then
                draw.SimpleTextOutlined( "[TRAITOR]", "DermaDefault", pos.x, pos.y + 10, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
            end
        end
    end

    if TTTCorpseDetectorConVar:GetBool() then
        for k,v in pairs(corpses) do
            if !v or !v:IsValid() then 
                table.remove(corpses, k)
                continue
            end
            local pos = v:GetPos():ToScreen()
            local ply = v:GetDTEntity(0)
            local name = "Unknown Corpse"
            if ply then
                name = "Corpse of: ".. ply:Nick()
            end
            local clr = Color(255, 255, 255)
            local found = v:GetDTBool(0)
            if found then
                if ply.role == 0 then --inno
                    clr = Color(0, 255, 0)
                elseif ply.role == 1 then --traitor
                    clr = Color(255, 0, 0)
                else --prolly detective or some other unknown role
                    clr = Color(0, 0, 255)
                end
            end

            draw.DrawText(name, "DermaDefault", pos.x, pos.y, clr)
        end
    end
end

function TTTCorpseDetector(entity)
    if !TTTCorpseDetectorConVar:GetBool() then return end

    if !entity or !entity:GetClass() then
        return
    end

    if entity:GetClass() == "prop_ragdoll" then
        local ply = entity:GetDTEntity(0)
        if ply then
            Log("The corpse of " .. ply:Nick() .. " was spawned!", icons.magnifierIcon)
        else
           Log("A unknown corpse was spawned!", icons.magnifierIcon)
        end
        corpses[#corpses + 1] = entity
    end
end

function ResetTTTTables()
    Log("Emptied TTT Arrays", icons.appIcon)
    table.Empty(traitors)
    table.Empty(corpses)
end

--THIRDPERSON
function ThirdPerson(ply, pos, angles, fov)
    if !ThirdPersonConVar:GetBool() then return({angles = angles, origin = pos, fov = fov}) end
    local view = {}

    view.origin = pos - (angles:Forward() * 100)
	view.angles = angles
	view.fov = fov
	view.drawviewer = true

	return view
end

--FREECAM
freeCamPos = {}
function FreeCam(pos, angle)
    if !freeCamConVar:GetBool() then freeCamPos = pos return pos end

    local freeCamSpeed = freeCamSpeedConVar:GetInt() * ( FrameTime() / 2 ) * 100
    local ang = angle:Forward():Angle()
    
    if !freeCamPos or type(freeCamPos) != "Vector" then freeCamPos = pos end --type check cuz after reload var gets set to {} and then isn't nil or smth

    local ply = LocalPlayer()
    local add = Vector(0,0,0)

    if ply:KeyDown(IN_FORWARD) then add = add + ang:Forward() end
	if ply:KeyDown(IN_BACK) then add = add - ang:Forward() end
	if ply:KeyDown(IN_MOVERIGHT) then add = add + ang:Right() end
	if ply:KeyDown(IN_MOVELEFT) then add = add - ang:Right() end
    if ply:KeyDown(IN_JUMP) then add = add + ang:Up() end
    if ply:KeyDown(IN_DUCK) then add = add - ang:Up() end

    add = add * freeCamSpeed
    if input.IsButtonDown(KEY_LSHIFT) then add = add * 2 end

    freeCamPos = freeCamPos + add

    return freeCamPos
end

function FreeCamCreateMove(cmd)
    if !freeCamConVar:GetBool() then return end

    cmd:SetForwardMove(0)
	cmd:SetUpMove(0)
	cmd:SetSideMove(0)
end

--VISUALS
local perfectCounter = {}
local perfectStep = math.pi * 0.005

function MiscVisuals()
    local mid = { x = ScrW() / 2, y = ScrH() / 2}
    if watermarkConVar:GetBool() then
        DrawTextShadow("Hey Exp ;)", "DermaDefault", 5, 5, RainbowColor())
    end

    --FOV Circle
    if aimbotConVar:GetBool() and aimbotFOVCircleConVar:GetBool() then
        DrawFOVCircle(mid.x, mid.y)
    end
    
    --CROSSHAIR
    if crosshairConVar:GetBool() then
        local posX = mid.x
        local posY = mid.y

        if LocalPlayer():Alive() and LocalPlayer():GetActiveWeapon() then
            local punchAngle = LocalPlayer():GetViewPunchAngles()
	        local dx = posX / LocalPlayer():GetFOV()
	        local dy = posY / LocalPlayer():GetFOV()

	        posX = posX - ( dx * punchAngle.yaw)
	        posY = posY + ( dy * punchAngle.pitch)
        end

        DrawCrosshair(posX, posY)
    end
    
    --TTTChecker
    TTTCheckerVisuals()

    --PERFECT HEAD ADJUSTMENT --TODO: move pha into own function pls
    if PerfectHeadAdjustmentConVar:GetBool() then
        if !changed then
            changed = true
        end
        for k,v in pairs(ents.GetAll()) do
            if !ValidTarget(v, false, 0) then continue end

            local bone = v:LookupBone("ValveBiped.Bip01_Head1")
            if !bone or bone <= 0 then continue end

            if !perfectCounter[k] or perfectCounter[k] > (math.pi * 2.0) then perfectCounter[k] = 0 end
            perfectCounter[k] = perfectCounter[k] + perfectStep

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

--NORECOIL
function NoRecoil()
    if !norecoilConVar:GetBool() then return end

    local activeWeapon = LocalPlayer():GetActiveWeapon()
    if !activeWeapon or !activeWeapon.Primary then return end

    activeWeapon.Primary.Recoil = 0
end

--AUTOPISTOL
local shootNext = false
function AutoPistol(cmd)
    if !autoPistolConVar:GetBool() then return end

    local weapon = LocalPlayer():GetActiveWeapon()
    if weapon and ((weapon.Primary and type(weapon.Primary.Automatic) == "boolean" and not weapon.Primary.Automatic) or (weapon.Automatic and type(weapon.Automatic) == "boolean" and not weapon.Automatic)) then
        if cmd:KeyDown(IN_ATTACK) then
            if shootNext then
                shootNext = false
            else
                cmd:SetButtons(cmd:GetButtons() - IN_ATTACK)
                shootNext = true
            end
        end
    end
end

--BHOP
function BHop(cmd)
    if !bhopConVar:GetBool() then return end

    if cmd:KeyDown(IN_JUMP) then
        if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
            cmd:RemoveKey(IN_JUMP)
        end
    end
end

function AutoStrafe(cmd)
    if autoStrafeConVar:GetBool() or LocalPlayer():IsOnGround() then return end

    if (cmd:GetMouseX() < 0) then
        cmd:SetSideMove(-450)
    elseif (cmd:GetMouseX() > 0) then
        cmd:SetSideMove(450)
    end
end

--FULLBRIGHT
local LightingModeChanged = false
function FullbrightPreRender()
    if !fullbrightConVar:GetBool() then return end
    
    render.SetLightingMode(1)
	LightingModeChanged = true
end

function FullbrightDisable()
    if LightingModeChanged then
		render.SetLightingMode(0)
		LightingModeChanged = false
	end
end

--SPONGEMOCK
function isUpper(char)
    local ascii = string.byte(char)
    return ascii >= 65 and ascii <= 90
end

function isLower(char)
    local ascii = string.byte(char)
    return ascii >= 97 and ascii <= 122
end

function isAlpha(char)
    return isUpper(char) or isLower(char)
end

function changeCase(char)
	if isUpper(char) then
		return string.lower(char)
	else
		return string.upper(char)
    end
end

function decideCase(char, prev, prev2)
	local charIsUpper = isUpper(char)
    local isValid1 = prev and isAlpha(prev)
	local isValid2 = prev2 and isAlpha(prev2)
	local odds = math.random(1, 100)
	--First char -> 50%
	if !isValid1 and !isValid2 then
		if odds > 50 then
			return changeCase(char)
        end
    --prev char has other case -> 15% chance to change case
	elseif isValid1 and isUpper(prev) != charIsUpper then
		if odds > 85 then
			return changeCase(char)
        end
	-- Else, there is a 85% chance to swap if prev2 does not match case
	elseif isValid2 and isUpper(prev2) != charIsUpper then
		if odds < 85 then
			return changeCase(char)
		else
			return char
		end
	-- Prev2 *also* matches case, so there is a 98% chance to swap
	elseif odds < 98 then
		return changeCase(char)
    end
	return char
end

function SpongeMockify(text)
    local buffer = text
    local prevLetter = nil
    local prev2Letter = nil
	for i = 1, #text do
		local char = string.GetChar(buffer, i)
		if !char then
			continue
		elseif !isAlpha(char) then
			continue
        end

		if char == '"' or char == '\\' or char == '' then
			char = '.'
		else
			char = decideCase(char, prevLetter, prev2Letter)
		end

		prev2Letter = prevLetter
		prevLetter = char
        buffer = string.SetChar(buffer, i, char)
    end
    return buffer
end