local playerChams = CreateMaterial("Cham_Texture","VertexLitGeneric",{ ["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$translucent"] = 1, ["$alpha"] = 1, ["$nocull"] = 1, ["$ignorez"] = 0 } )
local mod = 1/255

hook.Add("RenderScreenspaceEffects", "chams", function()
    local localPlayer = LocalPlayer()
    if !localPlayer then return end

    if !input.IsKeyDown(KEY_E) then return end

    local trace = localPlayer:GetEyeTrace()

    if !trace.Hit then return end

    local ent = trace.Entity

    PrintTable(trace)

    if !ent then return end

    local color = Color(243, 156, 18) --orange

    cam.Start3D(EyePos(),EyeAngles())
        render.SuppressEngineLighting( true )
        render.SetColorModulation((color.r * mod), (color.g * mod), (color.b * mod))
        render.MaterialOverride(playerChams)
        
        local mins, maxs = ent:GetHitBoxBounds(trace.HitBox, 0)
        if !mins or !maxs then return end

        local matrix = ent:GetBoneMatrix(trace.HitBoxBone)
        render.DrawBox(ent:GetBonePosition(trace.HitBoxBone), matrix:GetAngles(), mins, maxs, color, false)
        --ent:DrawModel()
    cam.End3D()
end)