-- / SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES
local SHARED_MODULES = ReplicatedStorage:WaitForChild("SharedModules")
local REController = require(SHARED_MODULES.REController)
local UIController = require(SHARED_MODULES.UIController)

REController.LoadAll()
UIController.Init()