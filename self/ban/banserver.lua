util.AddNetworkString("kick")
util.AddNetworkString("ban")

AddCSLuaFile("banclient.lua")

net.Receive("kick", function( len, pl )
	if pl:IsAdmin()==true then
		ent=net.ReadEntity()
		reason=net.ReadString()
		for k,v in pairs(player.GetAll()) do
			if v==ent then
				v:Kick(reason)
			end
		end
	else
		pl:PrintMessage(HUD_PRINTTALK, "You do not have the permission to use this command.")
	end
end )

net.Receive("ban", function( len, pl )
	if pl:IsAdmin()==true then
		ent=net.ReadEntity()
		duration=net.ReadString()
		if duration==nil then
			duration=1
		end
		for k,v in pairs(player.GetAll()) do
			if v==ent then
				v:Ban(duration,true)
			end
		end
	else
		pl:PrintMessage(HUD_PRINTTALK, "You do not have the permission to use this command.")
	end
end )