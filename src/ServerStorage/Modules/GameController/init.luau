

local MAIN = script
local Errors = require(MAIN.Errors)

local GameController = {}
GameController.Running = false
GameController.Thread = nil
GameController.Worlds = {}

function GameController.Init()
    
end

function GameController.StartGame()
    if GameController.Running == true then return end

    GameController.Running = true
end


return GameController