local ServerStorage = game.ServerStorage

-- / ASSETS
local ASSETS = ServerStorage.Assets
local CRUSHER_MODELS = ASSETS.Models.Crushers:GetChildren()

-- / MODULES
local MODULES = ServerStorage.Modules

local CrusherManager = require(MODULES.CrusherManager)
local WorldController = require(MODULES.WorldController)

local MAIN = script
local Errors = require(MAIN.Errors)
local Config = require(MAIN.Config)

-- / Miscs
local Random = Random.new()

-- / MAIN
local GameController = {}
GameController.Running = false
GameController.Thread = nil

function GameController.Init()
    WorldController.Init()

    GameController.StartGame()
end

function GameController.StartGame()
    if GameController.Running == true then return end

    GameController.Running = true

    GameController.Thread = task.spawn(function()
        CrusherManager.Enable()

        while GameController.Running == true do
            local active_worlds = WorldController.GetActiveWorlds()
            if not active_worlds then warn(Errors.NO_ACTIVE_WORLDS) return end
            
            for _, world in active_worlds do
                -- TODO: SORT AND GACHA BASED ON RARITY

                local model = CRUSHER_MODELS[Random:NextInteger(1, #CRUSHER_MODELS)]

                local goalPos = world.GoalPosition
                local startPos = world.StartPosition

                CrusherManager.NewCrusher(model, startPos, goalPos)
            end

            task.wait(Random:NextInteger(Config.MIN_SPAWN_INTERVAL, Config.MAX_SPAWN_INTERVAL))
        end
    end)
end

function GameController.EndGame()
    GameController.Running = false
    CrusherManager.Disable()
end

return GameController