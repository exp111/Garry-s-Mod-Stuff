include("tderma.lua")


--Hack Vars
local BHop = CreateClientConVar( "bhop_enabled", 0, false, false )
local TriggerBot = CreateClientConVar( "tbot_enabled", 0, false, false )
local Wallhack = CreateClientConVar( "wall_enabled", 0, false, false )
local NPCWallhack = CreateClientConVar( "npcwall_enabled", 0, false, false )
local pfaimbot = CreateClientConVar( "pfaimbot_enabled", 0, false, false )
local paimbot = CreateClientConVar( "paimbot_enabled", 0, false, false )
local pragebot = CreateClientConVar( "pragebot_enabled", 0, false, false )
local nfaimbot = CreateClientConVar( "nfaimbot_enabled", 0, false, false )
local naimbot = CreateClientConVar( "naimbot_enabled", 0, false, false )
local nragebot = CreateClientConVar( "nragebot_enabled", 0, false, false )
local Crosshair = CreateClientConVar( "cross_enabled", 0, false, false )

--ESP Vars
local ESPName = CreateClientConVar( "espname_enabled", 0, false, false )
local ESPHealth = CreateClientConVar( "esphealth_enabled", 0, false, false )
local ESPDistance = CreateClientConVar( "espdistance_enabled", 0, false, false )
local ESPWeapon = CreateClientConVar( "espweapon_enabled", 0, false, false )
local ESPBox = CreateClientConVar( "espbox_enabled", 0, false, false )
local ESPBone = CreateClientConVar( "espbone_enabled", 0, false, false )
local NPCChams = CreateClientConVar( "nchams_enabled", 0, false, false )
local PChams = CreateClientConVar( "pchams_enabled", 0, false, false )

Toggle=false

--HOOKS
hook.Add( "Think", "PanelToggle", function()
	if (LocalPlayer():KeyPressed(IN_SCORE)) then
			DermaPanel:ToggleVisible()
	end
end)

hook.Add( "Think", "Bhop", function()
	if BHop:GetInt()==1 then
		if (LocalPlayer():KeyPressed(IN_ALT2)) and (Toggle==false) then
			Toggle=true
		elseif (LocalPlayer():KeyPressed(IN_ALT2)) and (Toggle==true) then
			Toggle=false
			RunConsoleCommand( "-jump" )
		end
		
		if LocalPlayer():Alive()==true and Toggle==true and LocalPlayer():IsOnGround()==true then
			if !Jumping then
				RunConsoleCommand( "+jump" )
				Jumping=true
			else
				RunConsoleCommand( "-jump" )
				Jumping=false
			end
		end

	elseif (Jumping==true) or (Toggle==true) then
		RunConsoleCommand("-jump")
		Jumping=false
		Toggle=false
	end
end)

hook.Add( "Think", "Trigger", function()
		if TriggerBot:GetInt()==1 then
			if LocalPlayer():Alive()==true and (LocalPlayer():GetActiveWeapon()) and  LocalPlayer():GetActiveWeapon():Clip1()>0 then
				if LocalPlayer():GetEyeTrace().Entity:IsNPC()==true or (table.HasValue( friends, LocalPlayer():GetEyeTrace().Entity)==false) and LocalPlayer():GetEyeTrace().Entity:Nick()==nil then
					if !Shooting then
						RunConsoleCommand( "+attack" )
						Shooting=true
					else
						RunConsoleCommand( "-attack" )
						Shooting=false
					end
				elseif Shooting then
					RunConsoleCommand("-attack")
					Shooting=false	
				end	
			elseif Shooting then
				RunConsoleCommand("-attack")
				Shooting=false	
			end
		elseif Shooting then
			RunConsoleCommand("-attack")
			Shooting=false	
		end
end)



--WALLHACKS
hook.Add( "HUDPaint", "Wallhack", function()
	if Wallhack:GetInt()==1 then
		for k,v in pairs(player.GetAll()) do
			if v!=LocalPlayer()  and (table.HasValue( friends, v)==false) then
				Name=v:Name()
				Health=v:Health().."%"
				distance=math.floor(LocalPlayer():GetPos():Distance(v:GetPos()))
				if v:GetActiveWeapon()!=NULL then
					weapon=v:GetActiveWeapon():GetClass()
				end
				vector=v:OBBMaxs()
				if ESPName:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+12.5))):ToScreen()
					draw.DrawText(Name,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end

				if ESPHealth:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+10))):ToScreen()
					draw.DrawText("HP: "..Health,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end

				if ESPDistance:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+7.5))):ToScreen()
					draw.DrawText(distance,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end
				if ESPWeapon:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+5))):ToScreen()
					draw.DrawText("Weapon: "..weapon,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end

				--DRAW BOX
				if ESPBox:GetInt()==1 then
					--OBEN
					--VOL-HOL
					pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOR-HOR
					pos1=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOL-VOR
					pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOL-HOR
					pos1=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)

					--UNTEN
					--VUL-HUL
					pos1=(v:GetPos()+Vector(10,10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VUR-HUR
					pos1=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VUL-VUR
					pos1=(v:GetPos()+Vector(10,10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HUL-HUR
					pos1=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)

					--VERBINDUNG OBEN-UNTEN
					--VOL-VUL
					pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(10,10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOR-VUR
					pos1=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOL-HUL
					pos1=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOR-HUR
					pos1=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
				end

					--DRAW BONE
				if ESPBone:GetInt()==1 and v:LookupBone("ValveBiped.Bip01_Head1")!=nil then
					for i=1,19 do
						bones = {}
						bones[1] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Head1")):ToScreen()
						bones[2] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Neck1")):ToScreen()
						bones[3] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine4")):ToScreen()
						bones[4] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine2")):ToScreen()
						bones[5] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine1")):ToScreen()
						bones[6] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine")):ToScreen()
						bones[7] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_UpperArm")):ToScreen()
						bones[8] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Forearm")):ToScreen()
						bones[9] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Hand")):ToScreen()
						bones[10] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_UpperArm")):ToScreen()
						bones[11] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Forearm")):ToScreen()
						bones[12] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Hand")):ToScreen()
						bones[13] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Thigh")):ToScreen()
						bones[14] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Calf")):ToScreen()
						bones[15] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Foot")):ToScreen()
						bones[16] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Toe0")):ToScreen()
						bones[17] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Thigh")):ToScreen()
						bones[18] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Calf")):ToScreen()
						bones[19] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Foot")):ToScreen()
						bones[20] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Toe0")):ToScreen()
						surface.SetDrawColor(bonecolor)
						function connect(bone1,bone2)
						surface.DrawLine(bone1.x,bone1.y,bone2.x,bone2.y)
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
end)



hook.Add( "HUDPaint", "NPCWallhack", function()
	if NPCWallhack:GetInt()==1 then
		for k,v in pairs(ents.GetAll()) do
			if v:IsNPC() and v:IsValid() then
				Name=v:GetClass()
				Health=v:Health().."%"
				distance=math.floor(LocalPlayer():GetPos():Distance(v:GetPos()))
				if v:GetActiveWeapon()!=NULL then
					weapon=v:GetActiveWeapon():GetClass()
				end
				vector=v:OBBMaxs()
				--DRAW NAME+HEALTH+DISTANCE
				if ESPName:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+12.5))):ToScreen()
					draw.DrawText(Name,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end
				if ESPHealth:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+10))):ToScreen()
					draw.DrawText("HP: "..Health,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end
				if ESPDistance:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+7.5))):ToScreen()
					draw.DrawText(distance,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end
				if ESPWeapon:GetInt()==1 then
					pos=(v:GetPos()+Vector(0,0,(vector.z+5))):ToScreen()
					draw.DrawText("Weapon: "..weapon,Default,pos.x,pos.y,textcolor,TEXT_ALIGN_CENTER)
				end
				
				--DRAW BOX
				if ESPBox:GetInt()==1 then
					--OBEN
					--VOL-HOL
					pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOR-HOR
					pos1=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOL-VOR
					pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOL-HOR
					pos1=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)

					--UNTEN
					--VUL-HUL
					pos1=(v:GetPos()+Vector(10,10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VUR-HUR
					pos1=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VUL-VUR
					pos1=(v:GetPos()+Vector(10,10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HUL-HUR
					pos1=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)

					--VERBINDUNG OBEN-UNTEN
					--VOL-VUL
					pos1=(v:GetPos()+Vector(10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(10,10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--VOR-VUR
					pos1=(v:GetPos()+Vector(-10,10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOL-HUL
					pos1=(v:GetPos()+Vector(10,-10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
					--HOR-HUR
					pos1=(v:GetPos()+Vector(-10,-10,vector.z)):ToScreen()
					pos2=(v:GetPos()+Vector(-10,-10,0)):ToScreen()
					surface.SetDrawColor(boxcolor)
					surface.DrawLine(pos1.x,pos1.y,pos2.x,pos2.y)
				end

				--DRAW BONE
				if ESPBone:GetInt()==1 and v:LookupBone("ValveBiped.Bip01_Head1")!=nil then
					for i=1,19 do
						bones = {}
						bones[1] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Head1")):ToScreen()
						bones[2] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Neck1")):ToScreen()
						bones[3] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine4")):ToScreen()
						bones[4] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine2")):ToScreen()
						bones[5] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine1")):ToScreen()
						bones[6] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Spine")):ToScreen()
						bones[7] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_UpperArm")):ToScreen()
						bones[8] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Forearm")):ToScreen()
						bones[9] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Hand")):ToScreen()
						bones[10] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_UpperArm")):ToScreen()
						bones[11] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Forearm")):ToScreen()
						bones[12] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Hand")):ToScreen()
						bones[13] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Thigh")):ToScreen()
						bones[14] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Calf")):ToScreen()
						bones[15] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Foot")):ToScreen()
						bones[16] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_R_Toe0")):ToScreen()
						bones[17] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Thigh")):ToScreen()
						bones[18] =  v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Calf")):ToScreen()
						bones[19] =   v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Foot")):ToScreen()
						bones[20] = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_L_Toe0")):ToScreen()
						surface.SetDrawColor(bonecolor)
						function connect(bone1,bone2)
						surface.DrawLine(bone1.x,bone1.y,bone2.x,bone2.y)
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
end)



--PLAYER AIMBOTS
hook.Add("Think","PlayerFriendlyAimbot",function() 
	if pfaimbot:GetInt()==1 then
		if LocalPlayer():GetEyeTrace().Entity:IsPlayer()==true then 
			local targethead = LocalPlayer():GetEyeTrace().Entity:LookupBone("ValveBiped.Bip01_Head1")
			local targetheadpos = LocalPlayer():GetEyeTrace().Entity:GetBonePosition(targethead) 
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)

hook.Add("Think","PlayerAimbot",function()
	if paimbot:GetInt()==1 then 
		if (LocalPlayer():KeyDown(IN_ALT1)) then
			for k,v in pairs(player.GetAll()) do
				if v:Alive()==true and v:Name()!=LocalPlayer():Name() and v:GetPos():ToScreen().visible==true then
					local targethead = v:LookupBone("ValveBiped.Bip01_Head1")
					local targetheadpos = v:GetBonePosition(targethead) 
					LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
				end
			end
		end
	end
end)

hook.Add("Think","PlayerRagebot",function()
	if pragebot:GetInt()==1 then 
		local smallestd=math.huge
		local smallestdname
		for k,v in pairs(player.GetAll()) do
			if v:IsPlayer()==true and v:LookupBone("ValveBiped.Bip01_Head1")!=nil and v!=LocalPlayer() then
				if LocalPlayer():GetPos():Distance(v:GetPos())<smallestd then
					smallestd=LocalPlayer():GetPos():Distance(v:GetPos())
					smallestdname=v
				end
			end
		end
		if smallestdname!=nil then
			local targethead = smallestdname:LookupBone("ValveBiped.Bip01_Head1")
			local targetheadpos = smallestdname:GetBonePosition(targethead) 
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)


--NPC AIMBOTS
hook.Add("Think","NPCFriendlyAimbot",function()
	if nfaimbot:GetInt()==1 then 
		if LocalPlayer():GetEyeTrace().Entity:IsNPC()==true and LocalPlayer():GetEyeTrace().Entity:LookupBone("ValveBiped.Bip01_Head1")!=nil then 
			local targethead = LocalPlayer():GetEyeTrace().Entity:LookupBone("ValveBiped.Bip01_Head1")
			local targetheadpos = LocalPlayer():GetEyeTrace().Entity:GetBonePosition(targethead) 
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
		end
	end
end)

hook.Add("Think","NPCAimbot",function()
	if naimbot:GetInt()==1 then 
		if (LocalPlayer():KeyDown(IN_ALT1)) then
			for k,v in pairs(ents.GetAll()) do
				if v:IsNPC()==true and v:LookupBone("ValveBiped.Bip01_Head1")!=nil and v:Health()>0 and v:GetPos():ToScreen().visible==true then
				print(v:GetPos():ToScreen().visible) 
					local targethead = v:LookupBone("ValveBiped.Bip01_Head1")
					local targetheadpos = v:GetBonePosition(targethead) 
					LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
				end
			end
		end
	end
end)

hook.Add("Think","NPCRagebot",function()
	if nragebot:GetInt()==1 then 
		local smallestd=math.huge
		local smallestdname
		for k,v in pairs(ents.GetAll()) do
			if v:IsNPC()==true and v:LookupBone("ValveBiped.Bip01_Head1")!=nil then
				if LocalPlayer():GetPos():Distance(v:GetPos())<smallestd then
					smallestd=LocalPlayer():GetPos():Distance(v:GetPos())
					smallestdname=v
				end
			end
		end
		if smallestdname!=nil then
			local targethead = smallestdname:LookupBone("ValveBiped.Bip01_Head1")
			local targetheadpos = smallestdname:GetBonePosition(targethead) 
			LocalPlayer():SetEyeAngles((targetheadpos - LocalPlayer():GetShootPos()):Angle())
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

--Chams
hook.Add( "PreDrawHalos", "AddHalos", function()
	if NPCWallhack:GetInt()==1 or Wallhack:GetInt()==1 then
		entities= {}
		i=1
		if NPCChams:GetInt()==1 then
			for k,v in pairs(ents.GetAll()) do
				if v:IsNPC() and v:IsValid() then
					entities[i]=v
					i=i+1
				end
			end	
		elseif PChams:GetInt()==1 then
			for k,v in pairs(player.GetAll()) do
				if v:IsValid() then
					entities[i]=v
					i=i+1
				end
			end	
		end
		halo.Add( entities, chamcolor, 0, 0, 1,true,true )
	end
end)