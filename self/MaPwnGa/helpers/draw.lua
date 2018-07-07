function DrawTextShadow(text, font, x, y, clr, align)
    draw.DrawText(text, font, x + 1, y + 1, Color(0,0,0))
    draw.DrawText(text, font, x, y, clr)
end