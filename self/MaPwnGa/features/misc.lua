include("../convars.lua")

function CheckForTraitors()
    local _R = debug.getregistry()
    
    if(_G.KARMA) then
        for k, v in ipairs(player.GetAll()) do
            if(v:IsValid() and v:Alive() and v:Team() != TEAM_SPECTATOR) then
                for l, w in pairs(_R.Player.GetWeapons(v)) do
                    if(IsValid(w)) then
                        if(w.CanBuy and table.HasValue(w.CanBuy, ROLE_TRAITOR)) then
                            chat.AddText(v:Nick().." has got Weapon " .. language.GetPhrase(w:GetPrintName()) .. " and is probably a traitor!")
                        end
                    end
                end
            end
        end
     end
end