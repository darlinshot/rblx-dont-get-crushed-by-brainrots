local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)

local MAIN = script
local ROOT = script.Parent
local UpgradesController = require(ROOT.UpgradesController)

-- / MAIN
local StatsController = {}

function StatsController.UpdatePlayer(plr: Player)
    local char = plr.Character or plr.CharacterAdded:Wait()
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")

    local data = DataController.GetPlayerData(plr)
    local speed = UpgradesController.CalculateSpeedStat(data.Upgrades.Speed)
    local health = UpgradesController.CalculateHealthStat(data.Upgrades.Health)

    hum.WalkSpeed = speed
    hum.MaxHealth = health
    hum.Health = health
end

return StatsController