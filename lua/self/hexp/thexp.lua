include("tderma.lua")

--Hack Vars
local BHop = CreateClientConVar( "bhop_enabled", 0, false, false )
local TriggerBot = CreateClientConVar( "tbot_enabled", 0, false, false )
local Crosshair = CreateClientConVar( "cross_enabled", 0, false, false )
local NoRecoil = CreateClientConVar( "norecoil_enabled", 0, false, false )
--TTT Shit
local TraitorFinder = CreateClientConVar( "tfinder_enabled", 0, false, false )
local ModelSearcher = CreateClientConVar( "modelsearcher_enabled", 0, false, false )
--Wallhack
local PWallhack = CreateClientConVar( "wall_enabled", 0, false, false )
local NPCWallhack = CreateClientConVar( "npcwall_enabled", 0, false, false )
--Player Aimbots
local pfaimbot = CreateClientConVar( "pfaimbot_enabled", 0, false, false )
local paimbot = CreateClientConVar( "paimbot_enabled", 0, false, false )
local pragebot = CreateClientConVar( "pragebot_enabled", 0, false, false )
--NPC Aimbots
local nfaimbot = CreateClientConVar( "nfaimbot_enabled", 0, false, false )
local naimbot = CreateClientConVar( "naimbot_enabled", 0, false, false )
local nragebot = CreateClientConVar( "nragebot_enabled", 0, false, false )
--Aimhelper
local naimhelper = CreateClientConVar( "naimhelper_enabled", 0, false, false )
local paimhelper = CreateClientConVar( "paimhelper_enabled", 0, false, false )
--ESP Shit
local ESPName = CreateClientConVar( "espname_enabled", 0, false, false )
local ESPHealth = CreateClientConVar( "esphealth_enabled", 0, false, false )
local ESPDistance = CreateClientConVar( "espdistance_enabled", 0, false, false )
local ESPWeapon = CreateClientConVar( "espweapon_enabled", 0, false, false )
local ESP3DBox = CreateClientConVar( "esp3dbox_enabled", 0, false, false )
local ESP2DBox = CreateClientConVar( "esp2dbox_enabled", 0, false, false )
local ESPBone = CreateClientConVar( "espbone_enabled", 0, false, false )
--Glow
local NPCGlow = CreateClientConVar( "nglow_enabled", 0, false, false )
local PGlow = CreateClientConVar( "pglow_enabled", 0, false, false )
--Friends
local HideAimFriends = CreateClientConVar( "hideaimf_enabled", 0, false, false )
local HideWallFriends = CreateClientConVar( "hidewallf_enabled", 0, false, false )

GlowFriends = {}
lastOpened = 0


--HELPER?
function IsFriend(EntityName,Type)
	if HideAimFriends:GetBool() and Type=="Aim" or HideWallFriends:GetBool() and Type=="Wall" then
		if table.HasValue( friends, EntityName)==false then
			return false
		elseif table.HasValue( friends, EntityName)==false then
			return true
		end
	else 
		return false
	end
end

--HOOKS
hook.Add("Think", "PanelToggle", function()
	if input.IsKeyDown(KEY_INSERT) and !MainPanel:IsVisible() then
		MainPanel:ToggleVisible()
	elseif input.IsKeyDown(KEY_DELETE) and MainPanel:IsVisible() then
		MainPanel:ToggleVisible()
	end
end)

hook.Add( "Think", "Bhop", function()
	if BHop:GetBool() then	
		if not LocalPlayer():KeyDown(IN_ALT2) and Jumping then
			RunConsoleCommand("-jump")
			Jumping = false
		end

		if LocalPlayer():Alive() and LocalPlayer():KeyDown(IN_ALT2) then
			if !Jumping and LocalPlayer():IsOnGround() then
				RunConsoleCommand("+jump")
				Jumping = true
			else
				RunConsoleCommand("-jump")
				Jumping = false
			end
		end

	elseif Jumping then
		RunConsoleCommand("-jump")
		Jumping = false
	end
end)

hook.Add( "Think", "Trigger", function()
		if Shooting then
			RunConsoleCommand("-attack")
			Shooting=false	
		end

		if TriggerBot:GetBool() then
			if LocalPlayer():Alive()==true and (LocalPlayer():GetActiveWeapon()) and  LocalPlayer():GetActiveWeapon():Clip1() > 0 then
				local ent = LocalPlayer():GetEyeTrace().Entity
				if ent:IsNPC() or IsFriend(ent,"Aim")==false and ent:IsValid() and ent:Team() != TEAM_SPECTATOR and ent.Alive() then
					if not Shooting then
						RunConsoleCommand( "+attack" )
						Shooting=true
					end
				end
			end
		end
end)

hook.Add("Think", "NoRecoil", function()
	if NoRecoil:GetBool() then
		if LocalPlayer() and LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon().Primary then
			LocalPlayer():GetActiveWeapon().Primary.Recoil = 0
		end
	end
end)


--WALLHACKS
function GetName(target)
	if PWallhack:GetInt()==1 and target:IsPlayer() then
		local name=target:Name()
		return name
	elseif NPCWallhack:GetInt()==1 and target:IsNPC() then
		local name=target:GetClass()
		return name
	elseif ModelSearcher:GetInt()==1 then
		local name=target:GetModel()
		return name
	end
end

function Wallhack()
	if PWallhack:GetBool() or NPCWallhack:GetBool() then
		convar = true
		targets = {}
		if PWallhack:GetBool() then
			table.Add(targets, player.GetAll())
		end
		if NPCWallhack:GetBool() then
			table.Add(targets, ents.GetAll())
		end
	end

	if convar then
		for k,v in pairs(targets) do
			if v!=LocalPlayer() and v:IsPlayer() and v:GetPos():ToScreen().visible==true and v:Health()>0 or v:IsNPC() and v:IsValid() and v:GetPos():ToScreen().visible==true and v:Health()>0 then
			if IsFriend(v,"Wall")==false then
				local Name=GetName(v)
				local Health=v:Health().."%"
				local distance=math.floor(LocalPlayer():GetPos():Distance(v:GetPos()))
				if v:GetActiveWeapon()!=NULL then
					weapon=v:GetActiveWeapon():GetClass()
				end
				local vector=v:OBBMaxs()
				--DRAW NAME+HEALTH+DISTANCE
				if ESPName:GetInt()==1 then
					local pos=(v:GetPos()+Vector(0,0,(vector.z+12.5))):ToScreen()
					draw.DrawText(Name,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end

				if ESPHealth:GetInt()==1 and ESP2DBox:GetInt()==0 or ESPHealth:GetInt()==1 and ESP3DBox:GetInt()==0 then
					local pos=(v:GetPos()+Vector(0,0,(vector.z+5))):ToScreen()
					draw.DrawText("HP: "..Health,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end

				if ESPDistance:GetInt()==1 then
					local pos=(v:GetPos()+Vector(0,0,(vector.z+10))):ToScreen()
					draw.DrawText(distance,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end
				if ESPWeapon:GetInt()==1 then
					local pos=(v:GetPos()+Vector(0,0,(vector.z+7.5))):ToScreen()
					draw.DrawText("Weapon: "..weapon,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end

				--DRAW BOX
				if ESP3DBox:GetInt()==1 then
					surface.SetDrawColor(boxcolor)
					--OBEN
					--VOL-HOL
					local pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOR-HOR
					local pos1=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOL-VOR
					local pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOL-HOR
					local pos1=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)

					--UNTEN
					--VUL-HUL
					local pos1=(v:GetPos()+Vector(10,10,0)):ToScreen()
					local pos2=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VUR-HUR
					local pos1=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VUL-VUR
					local pos1=(v:GetPos()+Vector(10,10,0)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HUL-HUR
					local pos1=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)

					--VERBINDUNG OBEN-UNTEN
					--VOL-VUL
					local pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(10,10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOR-VUR
					local pos1=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOL-HUL
					local pos1=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOR-HUR
					local pos1=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					local pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
				end

				if ESP2DBox:GetInt()==1 then
					for k,v in pairs(ents.GetAll()) do
						if v:IsNPC() or v:IsPlayer() and v!=LocalPlayer() then
     							local pos1=v:LocalToWorld(v:OBBMaxs()):ToScreen()
      							local pos2=v:LocalToWorld(v:OBBMins()):ToScreen()
							surface.SetDrawColor(boxcolor)
							surface.DrawLine( pos1.x, pos1.y, pos1.x, pos2.y)
							surface.DrawLine( pos2.x, pos1.y, pos1.x, pos1.y)
							surface.DrawLine( pos2.x, pos1.y, pos2.x, pos2.y)
							surface.DrawLine( pos1.x, pos2.y, pos2.x, pos2.y)
							if ESPHealth:GetInt()==1 then
								surface.DrawRect(math.min(pos2.x,pos1.x),pos1.y,math.max((pos1.x-pos2.x),(pos2.x-pos1.x))*v:Health()/100,10)
							end
						end
					end
				end

					--DRAW BONE
				if ESPBone:GetBool() and v:LookupBone(selectedbone)!=nil then
					local function connect(bone1,bone2)
						surface.SetDrawColor(bonecolor)
						local pos1=v:GetBonePosition(v:LookupBone(bone1)):ToScreen()
						local pos2=v:GetBonePosition(v:LookupBone(bone2)):ToScreen()
						surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					end
						--KOPF+WSÄULE
						connect(bones[1],bones[2])
						connect(bones[2],bones[3])
						connect(bones[3],bones[4])
						connect(bones[4],bones[5])
						connect(bones[5],bones[6])
						--R ARM
						connect(bones[7],bones[3])
						connect(bones[8],bones[7])
						connect(bones[9],bones[8])
						--L ARM
						connect(bones[10],bones[3])
						connect(bones[11],bones[10])
						connect(bones[12],bones[11])
						--R BEINE
						connect(bones[13],bones[6])
						connect(bones[14],bones[13])
						connect(bones[15],bones[14])
						connect(bones[16],bones[15])
						--L BEINE
						connect(bones[17],bones[6])
						connect(bones[18],bones[17])
						connect(bones[19],bones[18])
						connect(bones[20],bones[19])
				end
			end
			end
		end
	end
end

hook.Add( "HUDPaint", "Wallhack", function() 
	if PWallhack:GetBool() or NPCWallhack:GetBool() then
		Wallhack()
	end
end)

--Glow
hook.Add( "PreDrawHalos", "AddHalos", function()
	if NPCWallhack:GetBool() or PWallhack:GetBool() then
		entities= {}
		visibleentities = {}
		local i=1
		local i2=1
		if NPCGlow:GetBool() then
			for k,v in pairs(ents.GetAll()) do
				if v:IsNPC() and v:IsValid() and v:IsLineOfSightClear(LocalPlayer())==false then
					entities[i]=v
					i=i+1
				elseif v:IsNPC() and v:IsValid() and v:IsLineOfSightClear(LocalPlayer())==true then
					visibleentities[i2]=v
					i2=i2+1
				end
			end
		end	
		if PGlow:GetBool() then
			for k,v in pairs(player.GetAll()) do
				if v:IsValid() and IsFriend(v,"Wall")==false and v:IsLineOfSightClear(LocalPlayer())==false then
					entities[i] = v
					i=i+1
				elseif v:IsValid() and IsFriend(v,"Wall")==false and v:IsLineOfSightClear(LocalPlayer())==true then
					visibleentities[i2] = v
					i2=i2+1
				end
			end	
			GlowFriends = friends
		end
		halo.Add(entities, glowcolor, 0, 0, 1, true, true)
		halo.Add(visibleentities, glow2color, 0, 0, 1, true, true)
		halo.Add(GlowFriends, friendcolor, 0, 0, 1, true, true)
	end
end)

--PLAYER AIMBOTS
function GetHeadPos(target)
	if (target:IsValid()) and target:Health()>0 then
		if target:LookupBone(selectedbone)!=nil then
			local headpos=target:GetBonePosition(target:LookupBone(selectedbone))
			return headpos
		else
			local x=target:GetPos().x+target:OBBCenter().x
			local y=target:GetPos().y+target:OBBCenter().y
			local z=target:GetPos().z+target:OBBCenter().z
			local headpos=Vector(x,y,z)
			return headpos
		end
	end
end

function GetNearest(targets)
	local entdistance
	local nearestEntity
	local smallestdistance = math.huge
	for k,v in pairs(targets) do
		if (v:IsNPC()) or (v:IsPlayer()) and v!=LocalPlayer() and IsFriend(v,"Aim")==false then
			entdistance=LocalPlayer():GetPos():Distance(v:GetPos())
			if  entdistance<smallestdistance then 
				smallestdistance = entdistance
				nearestEntity = v
			end
		end
	end
	if nearestEntity!=nil then 
		return nearestEntity
	end
end

function GetTargets(type)
	if type=="Aimhelper" then
		local targets = {}
		i=1
		if naimhelper:GetInt()==1 then
			for k,v in pairs(ents.GetAll()) do
				if v:IsNPC() and v:IsValid() then
						targets[i] = v
				end
			end
		end
		if paimhelper:GetInt()==1 then
			for k,v in pairs(player.GetAll()) do
				if v:IsPlayer() and v != LocalPlayer() and v:Team() != TEAM_SPECTATOR then
					if table.HasValue(targets,v)==false and IsFriend(v,"Aim")==false then
						targets[i] = v
					end
				end
			end
		end
		return targets
	elseif type=="Aimbot" then
		local targets = {}
		i=1
		if paimbot:GetInt()==1 then
			for k,v in pairs(player.GetAll()) do
				if v:IsPlayer() and v:Team() != TEAM_SPECTATOR then
					if table.HasValue(targets,v)==false and v != LocalPlayer() and IsFriend(v, "Aim")==false then
						targets[i] = v
					end
				end
			end
		end
		return targets
	end
end

hook.Add("Think","PlayerFriendlyAimbot",function() 
	if pfaimbot:GetInt()==1 then
		if LocalPlayer():GetEyeTrace().Entity:IsPlayer()==true and IsFriend(v,"Aim")==false then 
			local targetheadpos = GetHeadPos(LocalPlayer():GetEyeTrace().Entity) 
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)

hook.Add("Think","PlayerAimbot",function()
	if paimbot:GetInt()==1 then 
		if (LocalPlayer():KeyDown(IN_ALT1)) then
			for k,v in pairs(GetTargets("Aimbot")) do
				if v:Alive()==true and v:IsLineOfSightClear(LocalPlayer())==true then
					local targetheadpos = GetHeadPos(v)
					LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
				end
			end
		end
	end
end)

hook.Add("Think","PlayerRagebot",function()
	if pragebot:GetInt()==1 then 
		nearesttarget = GetNearest(player.GetAll())
		if nearesttarget!=nil then
			local targetheadpos = GetHeadPos(nearesttarget)
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)


--NPC AIMBOTS
hook.Add("Think","NPCFriendlyAimbot",function()
	if nfaimbot:GetInt()==1 then 
		if LocalPlayer():GetEyeTrace().Entity:IsNPC()==true and LocalPlayer():GetEyeTrace().Entity:LookupBone(selectedbone)!=nil then 
			local targetheadpos = GetHeadPos(LocalPlayer():GetEyeTrace().Entity)
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)

hook.Add("Think","NPCAimbot",function()
	if naimbot:GetInt()==1 then 
		if (LocalPlayer():KeyDown(IN_ALT1)) then
			for k,v in pairs(ents.GetAll()) do
				if v:IsNPC()==true and v:Health()>0 and v:IsLineOfSightClear(LocalPlayer())==true then
					local targetheadpos = GetHeadPos(v)
					LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
				end
			end
		end
	end
end)

hook.Add("Think","NPCRagebot",function()
	if nragebot:GetInt()==1 then 
		nearesttarget = GetNearest(ents.GetAll())
		if nearesttarget!=nil then
			local targetheadpos = GetHeadPos(nearesttarget)
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)

--Aimhelper
hook.Add("Think","AimHelper",function()
	if naimhelper:GetInt()==1 or paimhelper:GetInt()==1 then
		local targets = GetTargets("Aimhelper")
		if #targets>0 then
			for k,v in pairs(targets) do
				--Set Radius of the AimHelper
				local radius = aimradius*(math.pow(0.90,LocalPlayer():GetPos():Distance(v:GetPos())/100))
				minx=(ScrW()/2)-radius
				maxx=(ScrW()/2)+radius
				miny=(ScrH()/2)-radius
				maxy=(ScrH()/2)+radius
				local headpos = GetHeadPos(v)
				local screenpos = headpos:ToScreen()
				if (screenpos.visible==true) and screenpos.x>minx and screenpos.x<maxx and screenpos.y>miny and screenpos.y<maxy and v:IsLineOfSightClear(LocalPlayer())==true then
					LocalPlayer():SetEyeAngles((headpos - LocalPlayer():GetShootPos()):Angle())
				end
			end
		end
	end
end)


--Crosshair
hook.Add("HUDPaint","Crosshair",function()
	if Crosshair:GetInt()==1 then 
		surface.SetDrawColor(crosscolor)
		surface.DrawLine((ScrW()/2)-(crosssize/2),ScrH()/2,(ScrW()/2+(crosssize/2)),ScrH()/2)
		surface.DrawLine(ScrW()/2,(ScrH()/2)-(crosssize/2),ScrW()/2,(ScrH()/2)+(crosssize/2))	
	end
end)

--TTT Traitor Finder
hook.Add("Think","TraitorFinder",function()
	if TraitorFinder:GetBool() then
		/*for k,v in pairs(player.GetAll()) do
			for l,w in pairs(TWeapons) do
				if v:HasWeapon(w) then
					chat.AddText(v:Nick().." has got Weapon "..w.." and is probably a traitor!")
				end
			end
		end	*/
		local _R = debug.getregistry()

        if(_G.KARMA) then
                for k, v in ipairs(player.GetAll()) do
                        if(v:Alive()) then
                                for x, y in pairs(_R.Player.GetWeapons(v)) do
                                        if(IsValid(y)) then
                                                if(y.CanBuy and table.HasValue(y.CanBuy, ROLE_TRAITOR)) then
                                                        chat.AddText(v:Nick().." has got Weapon "..w.." and is probably a traitor!")
                                                end
                                        end
                                end
                        end
                end
        end
		--LocalPlayer():ConCommand("tfinder_enabled 0")
	end
end)

--Model Searcher
function SearchForModel(modelname)
	local targets = {}
	i=1
	for k,v in pairs(ents.GetAll()) do
		if v:GetModel()==modelname then
			targets[i]=v
			i=i+1
		end
	end
	if #targets>0 then
		return targets
	end
end


hook.Add("HUDPaint","ModelSearcher",function()
	if ModelSearcher:GetInt()==1 then
		mtargets = {}
		table.Empty(mtargets)
		if #selectedmodels>0 then
			for k,v in pairs(selectedmodels) do
				local mergetable = SearchForModel(v)
				table.Add(mtargets, mergetable)
			end
		end
		if mtargets!=nil then
			for k,v in pairs(mtargets) do
				local name=GetName(v)
				local distance=math.floor(LocalPlayer():GetPos():Distance(v:GetPos()))
				local vector = v:OBBMaxs()
				local pos=(v:GetPos()+Vector(0,0,(vector.z+10))):ToScreen()
				draw.DrawText(name,Default,pos.x,pos.y,modelcolor,TEXT_ALIGN_CENTER)
				local pos=(v:GetPos()+Vector(0,0,(vector.z+7.5))):ToScreen()
				draw.DrawText(distance,Default,pos.x,pos.y,modelcolor,TEXT_ALIGN_CENTER)
			end
		end
	end
end)
