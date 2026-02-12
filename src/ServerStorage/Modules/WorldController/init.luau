-- / WORKSPACE
local GAME_SYSTEM = workspace.GameSystem
local WORLDS = GAME_SYSTEM.Worlds

-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)
local World = require(MAIN.World)

-- / MAIN
local WorldController = {}
WorldController.WorldNames = {}
WorldController.ActiveWorlds = {}
WorldController.InactiveWorlds = {}

function WorldController.Init()
    for _, worldModel in WORLDS:GetChildren() do
        local worldName = worldModel.Name

        local world = WorldController
        
        world = World.New(worldModel)
        if not world then
            warn(string.format(Errors.WORLD_CREATION_FAILED, worldName))
            return
        end

        -- TODO: Delete this part and actually create World Active logic
        -- Player leave and join
        -- Player teleport
        WorldController.InactiveWorlds[worldName] = world
        WorldController.SetWorldActive(worldName)
    end
end

function WorldController.SetWorldActive(worldName: string)
    if WorldController.ActiveWorlds[worldName] then
        warn(string.format(Errors.WORLD_ALREADY_ACTIVE, worldName))
    end

    local world = WorldController.InactiveWorlds[worldName]
    if not world then
        warn(string.format(Errors.WORLD_NOT_EXISTS, worldName))
        return
    end
    WorldController.InactiveWorlds[worldName] = nil
    WorldController.ActiveWorlds[worldName] = world
end

function WorldController.SetWorldInactive(worldName: string)
    if WorldController.InactiveWorlds[worldName] then
        warn(string.format(Errors.WORLD_ALREADY_INACTIVE, worldName))
    end

    local world = WorldController.ActiveWorlds[worldName]
    if not world then
        warn(string.format(Errors.WORLDS_NOT_EXISTS, worldName))
        return
    end
    WorldController.ActiveWorlds[worldName] = nil
    WorldController.InactiveWorlds[worldName] = world
end

function WorldController.GetActiveWorlds()
    return WorldController.ActiveWorlds
end

function WorldController.GetInactiveWorlds()
    return WorldController.InactiveWorlds
end

return WorldController