function BHop(cmd)
    if cmd:KeyDown(IN_JUMP) then
        if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
            cmd:RemoveKey(IN_JUMP)
        end
    end
end

function AutoStrafe(cmd)
    if LocalPlayer():IsOnGround() then return end

    if (cmd:GetMouseX() < 0) then
        cmd:SetSideMove(-450)
    elseif (cmd:GetMouseX() > 0) then
        cmd:SetSideMove(450)
    end
end
