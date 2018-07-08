function DrawTextShadow(text, font, x, y, clr, align)
    draw.DrawText(text, font, x + 1, y + 1, Color(0,0,0))
    draw.DrawText(text, font, x, y, clr)
end

function Draw2DBox(target, top, bottom, height, width)
	surface.SetDrawColor(Color(255, 0, 0))
	surface.DrawOutlinedRect(bottom.x - width / 2, top.y, width / 0.9, height)
	surface.SetDrawColor(Color(0, 0, 0))
	surface.DrawOutlinedRect(bottom.x - width / 2 + 1, top.y + 1, width / 0.9 - 2, height - 2)
	surface.DrawOutlinedRect(bottom.x - width / 2 - 1, top.y - 1, width / 0.9 + 2, height + 2)
end

function DrawSnapline(target, bone)
    local ePos = GetBonePos(target, bone)
    if !ePos then return end
    
    ePosS = ePos:ToScreen()
    surface.SetDrawColor(Color(255, 0, 0))
    surface.DrawLine(ScrW() / 2, ScrH() / 2, ePosS.x, ePosS.y)
end

function DrawFOVCircle(x, y)
    local radius = math.tan(math.rad(aimbotFOVConVar:GetInt()) / 2) / math.tan(math.rad(LocalPlayer():GetFOV()) / 2) * ScrW()
    surface.DrawCircle(x, y, radius, FOVCircleColor)
end

function DrawCrosshair(x, y)
	surface.SetDrawColor(Color(0, 0, 0, 170))
	-- outline horizontal
	surface.DrawRect(x - 4, y - 1, 9, 3)
	-- outline vertical
	surface.DrawRect(x - 1, y - 4, 3, 9)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	-- line horizontal
	surface.DrawLine(x - 3, y, x + 4, y)
	-- line vertical
	surface.DrawLine(x - 0, y + 3, x - 0, y - 4)
end