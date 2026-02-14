local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES
local SHARED_MODULES = ReplicatedStorage.SharedModules
local UIController = require(SHARED_MODULES.UIController)

local MAIN = script
local Config = require(MAIN.Config)

-- / MAIN
return function (packet)
    UIController.Render(Config.UI_NAME, packet)
end