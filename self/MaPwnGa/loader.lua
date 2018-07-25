local relativeDirectory = "self/MaPwnGa/"
local external = external

if external then
    IsExternal = true
end

local function includeFile(filePath)
    if IsExternal then
        external(relativeDirectory .. filePath)
    else
        include(filePath)
    end
end

--HELPERS
includeFile("helpers/math.lua")
includeFile("helpers/utils.lua")
includeFile("helpers/draw.lua")

--MAIN or smth
includeFile("init.lua")
includeFile("convars.lua")

--FEATURES
includeFile("features/aimbot.lua")
includeFile("features/chams.lua")
includeFile("features/esp.lua")
includeFile("features/hvh.lua")
includeFile("features/misc.lua")
includeFile("features/trigger.lua")

--UI
includeFile("UI/main/tabs/firstPanel.lua")
includeFile("UI/main/tabs/secondPanel.lua")
includeFile("UI/main/tabs/weaponsPanel.lua")
includeFile("UI/main/tabs/logPanel.lua")
includeFile("UI/main/main.lua")

includeFile("UI/radar/main.lua")

includeFile("UI/spectator/main.lua")