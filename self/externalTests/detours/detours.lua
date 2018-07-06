local G                         = {}
local Meta_CVAR                 = FindMetaTable("ConVar")
G.GetCVar                       = GetConVar
G.convar_Bool 			        = Meta_CVAR.GetBool

function Meta_CVAR.GetBool(cvar)
    if cvar:GetName() == "sv_cheats" then
        print("Detoured sv_cheats. Returning false.")
        return false
    end
	return G.convar_Bool(cvar)
end

concommand.Add("exp_testCvar", function()
    print(GetConVar("sv_cheats"):GetBool())
end)