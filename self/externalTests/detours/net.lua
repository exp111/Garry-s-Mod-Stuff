netlog = netlog || {};
netlog.receivers = netlog.receivers || {};
netlog.originals = netlog.originals || {};
netlog.curmsg = "";
netlog.types = {
	["Angle"] = true,
	["Bit"] = true,
	["Bool"] = true,
	["Color"] = true,
	["Data"] = true,
	["Double"] = true,
	["Entity"] = true,
	["Float"] = true,
	["Int"] = true,
	["Normal"] = true,
	["String"] = true,
	["Table"] = true,
	["Type"] = true,
	["UInt"] = true,
	["Vector"] = true,
};

function netlog.log(msg)
	MsgN("netLog: " .. msg)
end

function netlog.detour(name, func, newfunc)
	netlog.log("Detoured net Function: " .. name);
	
	local ofunc = func;
	netlog.originals[name] = netlog.originals[name] || ofunc;
	return newfunc;
end

function netlog.setcurnet(netname)
	if (!netname || !isstring(netname)) then
		return;
	end

	if (netlog.curmsg && netlog.curmsg != "") then
		netlog.log("---End net Message: " .. netlog.curmsg .. "---");
	end

	netlog.log("---Begin net Message: " .. netname .. "---");
	netlog.curmsg = netname;
	netlog.originals["net.Start"](netname);
end

function netlog.endcurnet()
	netlog.log("---End net Message: " .. netlog.curmsg .. "---");
	netlog.curmsg = "";
	netlog.originals["net.SendToServer"]();
end

function netlog.think()
	local same = true;

	for name, func in next, net.Receivers do
		if (!netlog.receivers[name]) then
			same = false;
			netlog.receivers[name] = func;
		end
	end

	if (!same) then
		for name, func in next, net.Receivers do
			netlog.log("Detouring net Receiver Function for " .. name);

			net.Receivers[name] = function(len)
				if (netlog.curmsg && netlog.curmsg != "") then
					netlog.log("---End net Message: " .. netlog.curmsg .. "---");
				end

				netlog.log("---Begin net Message: " .. name .. "---");
				netlog.curmsg = name;
				netlog.receivers[name](len);
			end
		end
	end
end

net.Start = netlog.detour("net.Start", net.Start, netlog.setcurnet);
net.SendToServer = netlog.detour("net.SendToServer", net.SendToServer, netlog.endcurnet);
netlog.log("added think hook");
hook.Add("Think", "netlog.think", netlog.think);

for name, valid in next, netlog.types do
	if (!valid) then
		continue;
	end

	if (net["Read" .. name]) then
		netlog.log("Detouring net.Read Function: " .. string.lower(name));
		netlog.originals["net.Read" .. name] = netlog.originals["net.Read" .. name] || net["Read" .. name];
		local ofunc = netlog.originals["net.Read" .. name];

		net["Read" .. name] = function(read)
			local ret = ofunc(read);
			netlog.log("Read: " .. string.lower(name) .. ": " .. tostring(ret));
			return ret;
		end
	end

	if (net["Write" .. name]) then
		netlog.log("Detouring net.Write Function " .. string.lower(name));
		netlog.originals["net.Write" .. name] = netlog.originals["net.Write" .. name] || net["Write" .. name];
		local ofunc = netlog.originals["net.Write" .. name];

		net["Write" .. name] = function(write, ...)
			netlog.log("Wrote: " .. string.lower(name) .. ": " .. tostring(write));
			ofunc(write, ...);
		end
	end
end