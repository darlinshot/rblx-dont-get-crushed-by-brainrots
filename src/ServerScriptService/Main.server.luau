local ServerStorage = game.ServerStorage

-- / MODULES
local MODULES = ServerStorage.Modules
local UpgradesController = require(MODULES.UpgradesController)
local PlayerController = require(MODULES.PlayerController)
local GameController = require(MODULES.GameController)
local REController = require(MODULES.REController)

-- / MAIN
PlayerController.Init()
UpgradesController.Init()
REController.LoadAll()

GameController.Init()
GameController.StartGame()