local ReplicatedStorage = game.ReplicatedStorage
local ServerStorage = game.ServerStorage

-- / ASSETS
local ASSETS = ServerStorage.Assets
local CRUSHER_MODELS = ASSETS.MODELS.CRUSHERS:GetChildren()

-- / MODULES
local MODULES = ReplicatedStorage.Modules

local CrusherManager = require(MODULES.CrusherManager)
local Worlds = require(MODULES.Worlds)

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
    Worlds.Init()

    GameController.StartGame()
end

function GameController.StartGame()
    if GameController.Running == true then return end

    GameController.Running = true

    GameController.Thread = task.spawn(function()
        while GameController.Running == true do
            local active_worlds = Worlds.GetActiveWorlds()
            if not active_worlds or #active_worlds < 1 then warn(Errors.NO_ACTIVE_WORLDS) return end
            
            for _, world in active_worlds do
                -- TODO: SORT AND GACHA BASED ON RARITY

                local model = Random:NextInteger(1, #CRUSHER_MODELS)

                local goalPos = world.GoalPosition.Position
                local startPos = world.StartPosition.Position

                CrusherManager.NewCrusher(model, startPos, goalPos)
            end

            CrusherManager.UpdateAll()

            task.wait(Config.SpawnIntervals)
        end
    end)
end


return GameController