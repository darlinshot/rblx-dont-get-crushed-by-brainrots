-- / SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES
local SHARED_MODULES = ReplicatedStorage:WaitForChild("SharedModules")
local REController = require(SHARED_MODULES.REController)

REController.LoadAll()