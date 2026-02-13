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

    local currentSpeed, newSpeed = UpgradesController.CalculateSpeedStat(speedLvl), UpgradesController.CalculateSpeedStat(speedLvl+1)
    local speedCost = UpgradesController.CalculateSpeedCost(speedLvl)

    local currentHealth, newHealth = UpgradesController.CalculateHealthStat(healthLvl), UpgradesController.CalculateHealthStat(healthLvl+1)
    local healthCost = UpgradesController.CalculateHealthCost(healthLvl)

    local currentCash, newCash = UpgradesController.CalculateTotalCash(cashLvl, rebirthLvl), UpgradesController.CalculateTotalCash(cashLvl+1, rebirthLvl)
    local cashCost = UpgradesController.CalculateCashCost(cashLvl)

    local packet = {
        RenderType = renderType,
        
        Upgrades = {
            Speed = {
                CurrentStat = currentSpeed,
                NewStat = newSpeed,
                Cost = speedCost
            },
            Cash = {
                CurrentStat = currentCash,
                NewStat = newCash,
                Cost = cashCost
            },
            Health = {
                CurrentStat = currentHealth,
                NewStat = newHealth,
                Cost = healthCost
            }   
        }
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