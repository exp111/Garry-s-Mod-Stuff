include("../convars.lua")

traitors = {}
function CheckForTraitors()
    if !TTTCheckerConVar:GetBool() then return end
    local _R = debug.getregistry()
    
    if(_G.KARMA) then
        for k, v in ipairs(player.GetAll()) do
            if(v != LocalPlayer() and v:IsValid() and !table.HasValue(traitors, v) and v:Alive() and v:Team() != TEAM_SPECTATOR) then
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

function TTTCheckerVisuals()
    if !TTTCheckerConVar:GetBool() then return end

    if !_G.KARMA then return end

    if !LocalPlayer() or !LocalPlayer():Alive() then return end

    local ent = LocalPlayer():GetEyeTrace().Entity

    local pos = ent:GetPos()

    if table.HasValue(traitors, ent) then
        draw.SimpleTextOutlined( "[TRAITOR]", "DermaDefault", pos.x, pos.y + 10, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
    end
end

hook.Add("TTTPrepareRound", "TTTPrepareRound", function()
    table.Empty(traitors)
end)

hook.Add("TTTBeginRound", "TTTBeginRound", function()
    table.Empty(traitors)
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