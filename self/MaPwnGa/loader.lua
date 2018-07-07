local external = external

if external then
    IsExternal = true
end

local relativeDirectory = "self/MaPwnGa/"

--MAIN or smth
external(relativeDirectory .. "init.lua")
external(relativeDirectory .. "convars.lua")

--FEATURES
external(relativeDirectory .. "features/aimbot.lua")
external(relativeDirectory .. "features/chams.lua")
external(relativeDirectory .. "features/esp.lua")
external(relativeDirectory .. "features/hvh.lua")
external(relativeDirectory .. "features/misc.lua")
external(relativeDirectory .. "features/trigger.lua")

--HELPERS
external(relativeDirectory .. "helpers/math.lua")
external(relativeDirectory .. "helpers/utils.lua")
external(relativeDirectory .. "helpers/draw.lua")

--UI
external(relativeDirectory .. "UI/main/tabs/firstPanel.lua")
external(relativeDirectory .. "UI/main/tabs/secondPanel.lua")
external(relativeDirectory .. "UI/main/tabs/weaponsPanel.lua")
external(relativeDirectory .. "UI/main/tabs/logPanel.lua")
external(relativeDirectory .. "UI/main/main.lua")

external(relativeDirectory .. "UI/radar/main.lua")

external(relativeDirectory .. "UI/spectator/main.lua")