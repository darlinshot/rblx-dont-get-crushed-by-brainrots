local ServerStorage = game.ServerStorage

-- / MODULES
local MODULES = ServerStorage.Modules
local PlayerController = require(MODULES.PlayerController)
local GameController = require(MODULES.GameController)

-- / MAIN
PlayerController.Init()

GameController.Init()
GameController.StartGame()