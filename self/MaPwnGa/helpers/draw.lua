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