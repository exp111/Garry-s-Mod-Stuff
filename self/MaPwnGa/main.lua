include("convars.lua")
include("UI/main/main.lua")
include("UI/radar/main.lua")
include("helpers/math.lua")

hook.Add("Think", "Main", function()
    if LocalPlayer():KeyPressed(IN_SCORE) then
        menuPanel:ToggleVisible()
    end

    --Setting the radar visible breaks somehow the menu key check
    if radarConVar:GetBool() and !radarPanel:IsVisible() then
        radarPanel:SetVisible(true)
    elseif !radarConVar:GetBool() and radarPanel:IsVisible() then
        radarPanel:SetVisible(false)
    end
end)

hook.Add("Think", "Aimbot", function()
    if !aimbotConVar:GetBool() then return end

    if !input.IsKeyDown(aimbotKeyConVar:GetInt()) and !input.IsMouseDown(aimbotKeyConVar:GetInt()) then return end
    --Aimbot Stuff

    for k, v in pairs(ents.GetAll()) do
        if !v:IsValid() then continue end
        if v == LocalPlayer() then continue end
        if v:IsPlayer() then
            if v:Team() == TEAM_SPECTATOR then continue end
            if !v:Alive() then continue end
        elseif !v:IsNPC() then continue end
        if !LocalPlayer():IsLineOfSightClear(v) then continue end

        local bone = aimbotBoneConVar:GetString()
        if !GetAimbotFOV(LocalPlayer(), v, aimbotFOVConVar:GetInt(), bone) then continue end

        local targetheadpos = GetBonePos(v, bone)
		LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
    end
end)

hook.Add("HUDPaint", "Visuals", function()
    if aimbotConVar:GetBool() and aimbotFOVCircleConVar:GetBool() then
        local radius = math.tan(math.rad(aimbotFOVConVar:GetInt()) / 2) / math.tan(math.rad(LocalPlayer():GetFOV()) / 2) * ScrW();
        surface.DrawCircle(ScrW() / 2, ScrH() / 2, radius, drawFOVColor.r, drawFOVColor.g, drawFOVColor.b)
    end
end)