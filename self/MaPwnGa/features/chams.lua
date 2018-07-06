if !IsExternal then
    include("../convars.lua")
end

local playerChams = CreateMaterial("Cham_Texture","VertexLitGeneric",{ ["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$translucent"] = 1, ["$alpha"] = 1, ["$nocull"] = 1, ["$ignorez"] = 0 } )

local mod = 1/255

function Chams()
    if !chamsConVar:GetBool() or !LocalPlayer() then return end

    for k,v in pairs(player.GetAll()) do
        if !ValidTarget(v, false, 0) then continue end
        
        local clr = Color(41, 128, 185)
        if IsEnemy(v) then
            clr = Color(243, 156, 18) --orange
        end
        cam.Start3D(EyePos(),EyeAngles())
        cam.IgnoreZ(chamsIgnoreZConVar:GetBool())
            render.SuppressEngineLighting( chamsFlatConVar:GetBool() )
            render.SetColorModulation((clr.r * mod), (clr.g * mod), (clr.b * mod))
            render.MaterialOverride(playerChams)
            
            v:DrawModel()

            if chamsDrawWeaponConVar:GetBool() then
                local weapon = v:GetActiveWeapon()
                if weapon then
                    weapon:DrawModel()
                end
            end
        cam.IgnoreZ(false)
        cam.End3D()
    end
end