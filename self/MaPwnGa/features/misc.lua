include("../convars.lua")

traitors = {}
function CheckForTraitors()
    if !TTTCheckerConVar:GetBool() then return end
    local _R = debug.getregistry()
    
    if(_G.KARMA) then
        for k, v in ipairs(player.GetAll()) do
            if(v != LocalPlayer() and v:IsValid() and !table.HasValue(traitors, v) and v:Alive() and v:Team() != TEAM_SPECTATOR and !v:IsDetective()) then
                for l, w in pairs(_R.Player.GetWeapons(v)) do
                    if(IsValid(w)) then
                        if(w.CanBuy and table.HasValue(w.CanBuy, ROLE_TRAITOR)) then
                            chat.AddText(v:Nick().." has got Weapon " .. language.GetPhrase(w:GetPrintName()) .. " and is probably a traitor!")
                            traitors[#traitors + 1] = v
                        end
                    end
                end
            end
        end
    end
end

local corpses = {}
local function TTTCheckerVisuals()
    if !_G.KARMA then return end

    if !LocalPlayer() then return end

    local ent = LocalPlayer():GetEyeTrace().Entity

    local pos = ent:GetPos()

    if table.HasValue(traitors, ent) then
        draw.SimpleTextOutlined( "[TRAITOR]", "DermaDefault", pos.x, pos.y + 10, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
    end

    if TTTCorpseDetectorConVar:GetBool() then
        for k,v in pairs(corpses) do
            if v == nil or !v:IsValid() then 
                table.remove(corpses, k)
                continue
            end
            local pos = v:GetPos():ToScreen()
            local ply = v:GetDTEntity(0)
            local name = "Unknown Corpse"
            if ply != nil then
                name = "Corpse of: ".. ply:Nick()
            end

            draw.DrawText(name, "DermaDefault", pos.x, pos.y)
        end
    end
end

hook.Add("OnEntityCreated", "TTTCorpseDetector", function(entity)
    if !TTTCorpseDetectorConVar:GetBool() then return end

    if entity:GetClass() == "prop_ragdoll" then
        local ply = entity:GetDTEntity(0)
        if ply != nil then
            chat.AddText("The corpse of " .. ply:Nick() .. " was spawned!")
        else
            chat.AddText("A unknown corpse was spawned!")
        end
        corpses[#corpses + 1] = entity
    end
end)

hook.Add("TTTPrepareRound", "TTTPrepareRound", function()
    table.Empty(traitors)
    table.Empty(corpses)
end)

hook.Add("TTTBeginRound", "TTTBeginRound", function()
    table.Empty(traitors)
    table.Empty(corpses)
end)

--THIRDPERSON
function ThirdPerson(ply, pos, angles, fov)
    if !ThirdPersonConVar:GetBool() then return end
    local view = {}

    view.origin = pos - (angles:Forward() * 100)
	view.angles = angles
	view.fov = fov
	view.drawviewer = true

	return view
end

local function DrawCrosshair(x, y)
	surface.SetDrawColor(Color(0, 0, 0, 170));
	// outline horizontal
	surface.DrawRect(x - 5, y - 1, 9, 3);
	// outline vertical
	surface.DrawRect(x - 2, y - 4, 3, 9);
	surface.SetDrawColor(Color(255, 255, 255, 255));
	// line horizontal
	surface.DrawLine(x - 4, y, x + 3, y);
	// line vertical
	surface.DrawLine(x - 1, y + 3, x - 1, y - 4);
end

local function DrawFOVCircle()
    local radius = math.tan(math.rad(aimbotFOVConVar:GetInt()) / 2) / math.tan(math.rad(LocalPlayer():GetFOV()) / 2) * ScrW();
    surface.DrawCircle(ScrW() / 2, ScrH() / 2, radius, FOVCircleColor)
end

local perfectCounter = {}
local perfectStep = math.pi * 0.005;

--VISUALS
function MiscVisuals()
    --FOV Circle
    if aimbotConVar:GetBool() and aimbotFOVCircleConVar:GetBool() then
        DrawFOVCircle()
    end
    
    --CROSSHAIR
    if crosshairConVar:GetBool() then
        local posX = ScrW() / 2
        local posY = ScrH() / 2

        if LocalPlayer():Alive() and LocalPlayer():GetActiveWeapon() != nil then
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

    --PERFECT HEAD ADJUSTMENT
    if PerfectHeadAdjustmentConVar:GetBool() then
        if !changed then
            changed = true
        end
        for k,v in pairs(ents.GetAll()) do
            if !ValidTarget(v, false) then continue end

            local bone = v:LookupBone("ValveBiped.Bip01_Head1")
            if bone == nil or bone <= 0 then continue end

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

--NORECOIL
function NoRecoil()
    if !norecoilConVar:GetBool() then return end

    local activeWeapon = LocalPlayer():GetActiveWeapon()
    if activeWeapon == nil or !activeWeapon.Primary then return end
    
    activeWeapon.Primary.Recoil = 0
end