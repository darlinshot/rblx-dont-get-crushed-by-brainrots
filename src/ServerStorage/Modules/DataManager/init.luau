local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local ProfileStore = require(MODULES.ProfileStore)

local MAIN = script
local Config = require(MAIN.Config)

-- / MODULE
local DataManager = {}
DataManager.PlayerData = {}
DataManager.DataProfiles = {}

function DataManager.AddPlayer()

end

return DataManager