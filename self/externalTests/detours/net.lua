local Detours = {}
--HELPER FUNCTION
function Detour(Old, New)
	Detours[New] = Old
	print("Detouring function " .. tostring(Old) .. ".")
	return New
end

--ACTUAL DETOURS
net.Start = Detour(net.Start, function(name)
    print("net.Start: " .. name)
	return Detours[net.Start](name)
end)

net.WriteInt = Detour(net.WriteInt, function(int, bits)
    print("net.WriteInt:" .. int .. "," .. bits)
    return Detours[net.WriteInt](int, bits)
end)

net.WriteString = Detour(net.WriteString, function(s)
    print("net.WriteString: " .. s)
    return Detours[net.WriteString](s)
end)

net.WriteTable = Detour(net.WriteTable, function(tab)
    print("net.WriteTable: ")
    PrintTable(tab)
    return Detours[net.WriteTable](tab)
end)

net.SendToServer = Detour(net.SendToServer, function()
	print("net.SendToServer")
    return Detours[net.SendToServer]()
end)

concommand.Add("exp_test_net", function()
    net.Start("debug1")
    net.WriteInt(1, 1)
    net.SendToServer()
end)

concommand.Add("exp_test_printdetours", function()
    PrintTable(Detours)
end)