local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules

local ZoneController = require(MODULES.ZoneController)

-- / MAIN
local World = {}

function World.New(worldModel: Folder)
    -- Positions
    local positions = worldModel:FindFirstChild("Positions")

    local startPosition = positions.StartPosition
    local goalPos = positions.GoalPosition 
    local plrSpawnPos = positions.PlayerSpawnPosition

    -- Zones
    local zones = worldModel:FindFirstChild("Zones")
    
    local finish = zones.Finish
    local upgrades = zones.Upgrades

    local self = {}

    self.StartPosition = startPosition.CFrame.Position
    self.GoalPosition = goalPos.CFrame.Position
    self.PlayerSpawnPosition = plrSpawnPos.CFrame.Position

    local finishZone = ZoneController.AddZone(finish)
    local upgradesZone = ZoneController.AddZone(upgrades)

    self.FinishZone = finishZone
    self.UpgradesZone = upgradesZone

    setmetatable(self, World)
    return self
end

return World