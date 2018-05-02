--TODO: DRAW LINE, fix unlimited shooting

if SERVER then
 
	AddCSLuaFile ()
 
	SWEP.Weight = 5
 
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
 
elseif CLIENT then
 
	SWEP.PrintName = "Grappling Hook"
 
	SWEP.Slot = 1
	SWEP.SlotPos = 3
 
	SWEP.DrawAmmo = false
 
	SWEP.DrawCrosshair = true
 
end

SWEP.PrintName				= "Grappling Hook"
SWEP.Author					= "Exp"
SWEP.Purpose				= "Shoots Grappling Hooks, duh."
SWEP.Instructions 			= "Shoot to grapple."

SWEP.Category 				= "Exp's SWEPs"

SWEP.Spawnable				= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel				= Model( "models/weapons/v_Pistol.mdl" )
SWEP.WorldModel				= Model( "models/weapons/w_Pistol.mdl" )
SWEP.ViewModelFOV			= 54
SWEP.UseHands				= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "HelicopterGun"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AdminOnly				= false

local ShootSound = Sound( "Weapon_AR2.Single" )
local color=Color(0,255,0,255)

game.AddAmmoType( {
	name="ammo_grapple",
	dmgtype = DMG_GENERIC,
	tracer = TRACER_NONE,
	plydmg = 0,
	npcdmg = 0,
	force = 1000,
	minsplash = 0,
	maxsplash = 0
	})

function SWEP:Reload()
end
 
function SWEP:Think()
end

function SWEP:Initialize()
	self:SetHoldType( "smg" )

end

function SWEP:PrimaryAttack()
	LPlayer = self.Owner
	Grappling = true
	self:EmitSound(ShootSound)
	self.BaseClass.ShootEffects(self)
	self.Owner:SetAmmo(0,"ammo_grapple")
	self.Owner:GetActiveWeapon():SetClip1(0)

	endpos = self.Owner:GetEyeTrace().HitPos
	ownerview = self.Owner:GetAimVector()

	if endpos.z>self.Owner:EyePos().z+50 then
		self.Owner:SetPos(Vector(self.Owner:GetPos().x,self.Owner:GetPos().y,self.Owner:GetPos().z+50))
	end

end

function SWEP:SecondaryAttack()
Grappling=false

end

function SWEP:ShouldDropOnDie()

	return false

end

hook.Add("Think","Grapple",function()
	if (Grappling==true) then
		if (LPlayer:Alive()==true) then
			if LPlayer:EyePos():Distance(endpos)>100 then
				ownerview=Vector(endpos.x-LPlayer:EyePos().x,endpos.y-LPlayer:EyePos().y,endpos.z-LPlayer:EyePos().z)
				LPlayer:SetVelocity(ownerview:GetNormalized()*100)

				--DRAWLINE!
			else
				Grappling=false
				LPlayer:SetVelocity(-ownerview:GetNormalized()*10)
			end
		else
			Grappling=false
		end
	end
	if Grappling==false and LPlayer:Alive()==true and LPlayer:OnGround()==true then
		if LPlayer:GetActiveWeapon():GetPrimaryAmmoType()==22 and LPlayer:GetActiveWeapon():GetClass()=="weapon_grapple" and LPlayer:GetAmmoCount(22)==0 then
			LPlayer:GetActiveWeapon():SetClip1(1)
		end
	end
end)

