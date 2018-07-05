local external = external

if external then
    IsExternal = true
end

local relativeDirectory = "self/externalTests/"
external(relativeDirectory .. "init.lua")
external(relativeDirectory .. "test/includeme.lua")