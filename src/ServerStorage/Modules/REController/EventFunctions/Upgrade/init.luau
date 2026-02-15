local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local ProgressControllers = require(MODULES.ProgressControllers)

-- / MAIN
return function(plr, packet)
	ProgressControllers.UpgradePlayer(plr, packet.Upgrade)
end
