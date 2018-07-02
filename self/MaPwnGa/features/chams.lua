include("../convars.lua")

local playerChams = CreateMaterial("Cham_Texture","VertexLitGeneric",{ ["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$translucent"] = 1, ["$alpha"] = 1, ["$nocull"] = 1, ["$ignorez"] = 0 } )
local playerChamsIgnoreZ = CreateMaterial("Cham_Texture","VertexLitGeneric",{ ["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$translucent"] = 1, ["$alpha"] = 1, ["$nocull"] = 1, ["$ignorez"] = 1 } )

local mod = 1/255

function Chams()
    if !LocalPlayer() or !chamsConVar:GetBool() then return end

    local chamsMat = playerChams
    if chamsIgnoreZConVar:GetBool() then //TODO: doesn't work cuz it needs sv_pure or smth
        chamsMat = playerChamsIgnoreZ
    end

    for k,v in pairs(player.GetAll()) do
        if !ValidTarget(v, false) then continue end
        
        local clr = Color(41, 128, 185)
        if IsEnemy(v) then
            clr = Color(243, 156, 18) //orange
        end
        cam.Start3D(EyePos(),EyeAngles())
            render.SuppressEngineLighting( chamsFlatConVar:GetBool() )
            render.SetColorModulation((clr.r * mod), (clr.g * mod), (clr.b * mod))
            render.MaterialOverride(chamsMat)
            v:DrawModel()

            if chamsDrawWeaponConVar:GetBool() then
                local weapon = v:GetActiveWeapon()
                if weapon then
                    weapon:DrawModel()
                end
            end
        cam.End3D()
    end
end