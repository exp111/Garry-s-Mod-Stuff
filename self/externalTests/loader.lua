local external = external
local relativeDirectory = "self/externalTests/"

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

includeFile("init.lua")
includeFile("test/includeme.lua")