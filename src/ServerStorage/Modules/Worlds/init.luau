-- / WORKSPACE
local GAME_SYSTEM = workspace.GameSystem
local WORLDS = GAME_SYSTEM.Worlds

-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)

-- / MAIN
local Worlds = {}
Worlds.WorldNames = {}
Worlds.ActiveWorlds = {}
Worlds.InactiveWorlds = {}

function Worlds.Init()
    for _, worldModel in WORLDS do
        local worldName = worldModel.Name
        if Worlds.InactiveWorlds[worldName] or Worlds.ActiveWorlds[worldName] then
            warn(string.format(Errors.WORLD_EXISTS, worldName))
            return
        end

        local goalPos = worldModel.GoalPosition
        local startPos = worldModel.StartPosition
        local plrSpawnPos = worldModel.PlayerSpawnPosition

        Worlds.InactiveWorlds[worldName] = {
            ActivePlayers = 0,

            GoalPosition = goalPos,
            StartPos = startPos,
            PlayerSpawnPosition = plrSpawnPos
        }
        table.insert(Worlds.WorldNames, worldName)
    end
end

function Worlds.SetWorldActive(worldName: string)
    if Worlds.ActiveWorlds[worldName] then
        warn(string.format(Errors.WORLD_ALREADY_ACTIVE, worldName))
    end

    local world = Worlds.InactiveWorlds[worldName]
    if not world then
        warn(string.format(Errors.WORLD_NOT_EXISTS, worldName))
        return
    end
    Worlds.InactiveWorlds[worldName] = nil
    Worlds.ActiveWorlds[worldName] = world
end

function Worlds.SetWorldInactive(worldName: string)
    if Worlds.InactiveWorlds[worldName] then
        warn(string.format(Errors.WORLD_ALREADY_INACTIVE, worldName))
    end

    local world = Worlds.ActiveWorlds[worldName]
    if not world then
        warn(string.format(Errors.WORLDS_NOT_EXISTS, worldName))
        return
    end
    Worlds.ActiveWorlds[worldName] = nil
    Worlds.InactiveWorlds[worldName] = world
end

function Worlds.GetActiveWorlds()
    return Worlds.ActiveWorlds
end

function Worlds.GetInactiveWorlds()
    return Worlds.InactiveWorlds
end

return Worlds