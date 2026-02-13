local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local UpgradesController = require(MODULES.UpgradesController)
local DataManager = require(MODULES.DataManager)

-- / REMOTE EVENTS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

local upgradeEvent = REMOTE_EVENTS.Upgrade

-- / MAIN
local Zone = {}

Zone.OnPlayerEntered = function(plr: Player)
    local renderType = "ShowUI"
    local stats = DataManager.GetPlayerData(plr)
    local upgrades = stats.Upgrades

    local rebirthLvl = stats.Rebirths
    local speedLvl = upgrades.Speed
    local healthLvl = upgrades.Health
    local cashLvl = upgrades.Cash

    local currentSpeed, newSpeed = UpgradesController.CalculateSpeedStat(speedLvl-1), UpgradesController.CalculateSpeedStat(speedLvl)
    local speedCost = UpgradesController.CalculateSpeedCost(speedLvl)

    local currentHealth, newHealth = UpgradesController.CalculateHealthStat(healthLvl-1), UpgradesController.CalculateHealthStat(healthLvl)
    local healthCost = UpgradesController.CalculateHealthCost(healthLvl)

    local currentCash, newCash = UpgradesController.CalculateTotalCash(cashLvl-1, rebirthLvl), UpgradesController.CalculateTotalCash(cashLvl, rebirthLvl)
    local cashCost = UpgradesController.CalculateCashCost(cashLvl)

    local packet = {
        RenderType = renderType,

        CurrentSpeed = currentSpeed,
        NewSpeed = newSpeed,
        SpeedCost = speedCost,

        CurrentHealth = currentHealth,
        HewHealth = newHealth,
        HealthCost = healthCost,

        CurrentCash = currentCash,
        NewCash = newCash,
        CashCost = cashCost
    }
    upgradeEvent:FireClient(plr, packet)
end

Zone.OnPlayerExit = function(plr: Player)
    local renderType = "HideUI"

    local packet = {
        RenderType = renderType
    }
    upgradeEvent:FireClient(plr, packet)
end

return Zone