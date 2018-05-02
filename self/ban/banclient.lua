local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 50,50 )
DermaPanel:SetSize( 550, 700 )
DermaPanel:SetTitle( "Admin Panel" )
DermaPanel:SetVisible( false )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( false )

local DermaListView = vgui.Create("DListView")
DermaListView:SetParent(DermaPanel)
DermaListView:SetPos(25, 50)
DermaListView:SetSize(500, 550)
DermaListView:SetMultiSelect(false)
DermaListView:AddColumn("Nr")
DermaListView:AddColumn("Player Names")
DermaListView:AddColumn("Entity")
DermaListView:AddColumn("SteamID64")
 
for k,v in pairs(player.GetAll()) do
    DermaListView:AddLine(k,v:Nick(),v,v:SteamID64()) 
end


--Popup after trying to kick somebody
local KickPopup = vgui.Create( "DFrame" )
KickPopup:SetPos( (ScrW()/2)-300,(ScrH()/2)-25 )
KickPopup:SetSize( 590, 50 )
KickPopup:SetTitle( "Reason to kick the Player?" )
KickPopup:ShowCloseButton( false )
KickPopup:SetVisible( false )
KickPopup:MakePopup()
KickPopup:MoveToFront()
 
local KickText = vgui.Create( "DTextEntry", KickPopup )
KickText:SetPos( 10,25 )
KickText:SetTall( 20 )
KickText:SetWide( 450 )
KickText:SetEnterAllowed( true )
KickText.OnEnter = function()
	net.Start("kick")
	net.WriteEntity( ent )
	net.WriteString(KickText:GetValue())
	net.SendToServer()
    KickPopup:SetVisible( false )
end

local DermaButton = vgui.Create( "DButton", KickPopup )
DermaButton:SetText( "Cancel" )
DermaButton:SetPos( 470, 25 )
DermaButton:SetSize( 100, 20 )
DermaButton.DoClick = function ()
    KickPopup:SetVisible( false )
end

--Popup after trying to ban somebody
local BanPopup = vgui.Create( "DFrame" )
BanPopup:SetPos( (ScrW()/2)-300,(ScrH()/2)-25 )
BanPopup:SetSize( 390, 50 )
BanPopup:SetTitle( "Enter the ban duration (0=permanent)" )
BanPopup:ShowCloseButton( false )
BanPopup:SetVisible( false )
BanPopup:MakePopup()
BanPopup:MoveToFront()
 
local BanText = vgui.Create( "DTextEntry", BanPopup )
BanText:SetPos( 10,25 )
BanText:SetTall( 20 )
BanText:SetWide( 250 )
BanText:SetEnterAllowed( true )
BanText.OnEnter = function()
	input=tonumber(BanText:GetValue(),10)
	if input>-1 and input<math.huge then
		net.Start("ban")
		net.WriteEntity( ent )
		net.WriteString(BanText:GetValue())
		net.SendToServer()
    	KickPopup:SetVisible( false )
	else
		LocalPlayer():ChatPrint("You need to insert a number!")
	end
end

local DermaButton = vgui.Create( "DButton", BanPopup )
DermaButton:SetText( "Cancel" )
DermaButton:SetPos( 270, 25 )
DermaButton:SetSize( 100, 20 )
DermaButton.DoClick = function ()
    BanPopup:SetVisible( false )
end

--Buttons on Main Frame
local DermaButton = vgui.Create( "DButton", DermaPanel )
DermaButton:SetText( "Kick" )
DermaButton:SetPos( 25, 625 )
DermaButton:SetSize( 100, 25 )
DermaButton.DoClick = function ()
	if (DermaListView:GetSelected()[1]==nil) then
    	LocalPlayer():ChatPrint("You need to select a Player!")
	else
		ent=DermaListView:GetSelected()[1]:GetValue(3)
    	KickPopup:SetVisible( true )
	end
end

local DermaButton = vgui.Create( "DButton", DermaPanel )
DermaButton:SetText( "Ban" )
DermaButton:SetPos( 158.333, 625 )
DermaButton:SetSize( 100, 25 )
DermaButton.DoClick = function ()
	if (DermaListView:GetSelected()[1]==nil) then
    	LocalPlayer():ChatPrint("You need to select a Player!")
	else
		ent=DermaListView:GetSelected()[1]:GetValue(3)
    	BanPopup:SetVisible( true )
	end
end

local DermaButton = vgui.Create( "DButton", DermaPanel )
DermaButton:SetText( "Refresh" )
DermaButton:SetPos( 291.666, 625 )
DermaButton:SetSize( 100, 25 )
DermaButton.DoClick = function ()
	DermaListView:Clear()
	for k,v in pairs(player.GetAll()) do
    	DermaListView:AddLine(k,v:Nick(),v,v:SteamID64()) 
	end
end

local DermaButton = vgui.Create( "DButton", DermaPanel )
DermaButton:SetText( "Close" )
DermaButton:SetPos( 425, 625 )
DermaButton:SetSize( 100, 25 )
DermaButton.DoClick = function ()
	DermaPanel:SetVisible(false)
end

concommand.Add("expgui",function() 
	DermaPanel:SetVisible( true ) 
	DermaPanel:MakePopup() 
	end)