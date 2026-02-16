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
    
    local self = {}

    self.StartPosition = startPosition.CFrame.Position
    self.GoalPosition = goalPos.CFrame.Position
    self.PlayerSpawnPosition = plrSpawnPos.CFrame.Position

    for _, zone in zones:GetChildren() do
        self[zone.Name] = ZoneController.AddZone(zone)
    end

    setmetatable(self, World)
    return self
end

return World