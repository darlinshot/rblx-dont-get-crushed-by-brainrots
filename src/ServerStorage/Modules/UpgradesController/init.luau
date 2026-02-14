local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / REMOTE EVENTS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

local upgradeEvent = REMOTE_EVENTS.Upgrade

-- / MODULES
local MODULES = ServerStorage.Modules
local DataManager = require(MODULES.DataManager)

-- / MAIN
local UpgradesController = {}

UpgradesController.BASE_SPEED = 10
UpgradesController.BASE_SPEED_UPGRADE_COST = 200
UpgradesController.SPEED_GROWTH = 1.5
UpgradesController.SPEED_COST_GROWTH = 1.15

function UpgradesController.CalculateSpeedStat(level: number)
    return math.floor(UpgradesController.BASE_SPEED+(level-1)*UpgradesController.SPEED_GROWTH)
end

function UpgradesController.CalculateSpeedCost(level: number)
    return math.floor(UpgradesController.BASE_SPEED_UPGRADE_COST*(math.pow(UpgradesController.SPEED_COST_GROWTH, level-1)))
end

UpgradesController.BASE_CASH = 1000
UpgradesController.BASE_CASH_UPGRADE_COST = 200
UpgradesController.BASE_CASH_GROWTH = 500
UpgradesController.BASE_CASH_COST_GROWTH = 1.25

function UpgradesController.CalculateCashStat(level: number)
    return math.floor(UpgradesController.BASE_CASH+(level-1)*UpgradesController.BASE_CASH_GROWTH)
end

function UpgradesController.CalculateCashCost(level: number)
    return math.floor(UpgradesController.BASE_CASH_UPGRADE_COST*(math.pow(UpgradesController.BASE_CASH_COST_GROWTH, level-1)))
end

UpgradesController.BASE_HEALTH = 100
UpgradesController.BASE_HEALTH_UPGRADE_COST = 200
UpgradesController.HEALTH_GROWTH = 25
UpgradesController.HEALTH_COST_GROWTH = 1.2

function UpgradesController.CalculateHealthStat(level: number)
   return math.floor(UpgradesController.BASE_HEALTH+(level-1)*UpgradesController.HEALTH_GROWTH) 
end

function UpgradesController.CalculateHealthCost(level: number)
   return math.floor(UpgradesController.BASE_HEALTH_UPGRADE_COST*(math.pow(UpgradesController.HEALTH_COST_GROWTH, level-1)))
end

UpgradesController.BASE_REBIRTH_COST = 5000
UpgradesController.REBIRTH_GROWTH = 2.5
UpgradesController.REBIRTH_CASH_MULTIPLIER = 0.5
    
function UpgradesController.CalculateCashMultiplier(rebirth: number)
    local multiplier = 1+(rebirth*0.5)
    
    return tonumber(string.format("%.1f", tostring(multiplier)))
end

function UpgradesController.CalculateRebirthCost(rebirth: number)
   return math.floor(UpgradesController.BASE_REBIRTH_COST+(UpgradesController.REBIRTH_GROWTH*rebirth))
end

function UpgradesController.CalculateTotalCash(level: number, rebirth: number)
    local cash = UpgradesController.CalculateCashStat(level)
    local multipler = UpgradesController.CalculateCashMultiplier(rebirth)
    return math.floor(cash*multipler)
end

function UpgradesController.CalculateStats(speedLvl: number, cashLvl: number, healthLvl: number, rebirth: number)
    local speed  = UpgradesController.CalculateSpeedStat(speedLvl)
    local health = UpgradesController.CalculateHealthStat(healthLvl)
    local cash = UpgradesController.CalculateTotalCash(cashLvl, rebirth)
    
    return {
        Speed = speed,
        Cash = cash,
        Health = health
    }
end

function UpgradesController.CalculateCosts(speedLvl: number, cashLvl: number, healthLvl: number)
    local healthCost = UpgradesController.CalculateHealthCost(healthLvl)
	local speedCost = UpgradesController.CalculateSpeedCost(speedLvl)
	local cashCost = UpgradesController.CalculateCashCost(cashLvl)

    return {
        Speed = speedCost,
        Cash = cashCost,
        Health = healthCost
    }
end

function UpgradesController.RenderStats(plr: Player)
	local renderType = "ShowUI"
    local stats = DataManager.GetPlayerData(plr)

    local rebirthLvl = stats.Rebirths
    local upgrades = stats.Upgrades
    local speedLvl = upgrades.Speed
    local healthLvl = upgrades.Health
    local cashLvl = upgrades.Cash

    local currentStats = UpgradesController.CalculateStats(speedLvl, cashLvl, healthLvl, rebirthLvl)
    local newStats = UpgradesController.CalculateStats(speedLvl+1, cashLvl+1, healthLvl+1, rebirthLvl)
    local costs = UpgradesController.CalculateCosts(speedLvl, cashLvl, healthLvl)

    local packet = {
        RenderType = renderType,
        
        Upgrades = {
            Speed = {
                CurrentStat = currentStats.Speed,
                NewStat = newStats.Speed,
                Cost = costs.Speed
            },
            Cash = {
                CurrentStat = currentStats.Cash,
                NewStat = newStats.Cash,
                Cost = costs.Cash
            },
            Health = {
                CurrentStat = currentStats.Health,
                NewStat = newStats.Health,
                Cost = costs.Health
            }   
        }
    }
    upgradeEvent:FireClient(plr, packet)
end

function UpgradesController.UpgradePlayer(plr: Player)
    -- TODO: ADD SPEED + HEALTH
    UpgradesController.RenderStats(plr) 
end

return UpgradesController