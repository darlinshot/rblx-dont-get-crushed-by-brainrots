local ServerStorage = game.ServerStorage

-- / MODULES
local MODULES = ServerStorage.Modules
local PlayersController = require(MODULES.PlayersController)
local GameController = require(MODULES.GameController)

-- / MAIN
PlayersController.Init()

GameController.Init()
GameController.StartGame()