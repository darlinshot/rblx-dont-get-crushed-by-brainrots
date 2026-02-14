-- / MODULES
local MAIN = script

local ROOT = MAIN.Parent
local Config = require(ROOT.Config)

-- / FUNCTIONS
local function Round(n: number | string, decimals: number)
    if typeof(n) == "number" then
        n = tostring(n)
    end

    if not decimals then decimals = 0 end
    decimals = math.floor(decimals)
    local formatString = `%.{decimals}f`

    return tonumber(string.format(formatString, n))
end

-- / MAIN
local Calculator = {}

function Calculator.CalculateSpeedStat(level: number)
    return Round(Config.BASE_SPEED+(level-1)*Config.SPEED_GROWTH, 2)
end

function Calculator.CalculateSpeedCost(level: number)
    return Round(Config.BASE_SPEED_UPGRADE_COST*(math.pow(Config.SPEED_COST_GROWTH, level-1)))
end

function Calculator.CalculateCashStat(level: number)
    return Round(Config.BASE_CASH+(level-1)*Config.BASE_CASH_GROWTH, 2)
end

function Calculator.CalculateCashCost(level: number)
    return Round(Config.BASE_CASH_UPGRADE_COST*(math.pow(Config.BASE_CASH_COST_GROWTH, level-1)))
end

function Calculator.CalculateHealthStat(level: number)
   return Round(Config.BASE_HEALTH+(level-1)*Config.HEALTH_GROWTH, 2) 
end

function Calculator.CalculateHealthCost(level: number)
   return Round(Config.BASE_HEALTH_UPGRADE_COST*(math.pow(Config.HEALTH_COST_GROWTH, level-1)))
end

function Calculator.CalculateCashMultiplier(rebirth: number)
    return Round(1+(rebirth*0.5), 2)
end

function Calculator.CalculateRebirthCost(rebirth: number)
   return Round(Config.BASE_REBIRTH_COST+(Config.REBIRTH_GROWTH*rebirth), 2)
end

function Calculator.CalculateTotalCash(level: number, rebirth: number)
    local cash = Calculator.CalculateCashStat(level)
    local multipler = Calculator.CalculateCashMultiplier(rebirth)
    return math.floor(cash*multipler)
end

function Calculator.CalculateStats(speedLvl: number, cashLvl: number, healthLvl: number, rebirth: number)
    local speed  = Calculator.CalculateSpeedStat(speedLvl)
    local health = Calculator.CalculateHealthStat(healthLvl)
    local cash = Calculator.CalculateTotalCash(cashLvl, rebirth)
    
    return {
        Speed = speed,
        Cash = cash,
        Health = health
    }
end

function Calculator.CalculateCosts(speedLvl: number, cashLvl: number, healthLvl: number)
    local healthCost = Calculator.CalculateHealthCost(healthLvl)
	local speedCost = Calculator.CalculateSpeedCost(speedLvl)
	local cashCost = Calculator.CalculateCashCost(cashLvl)

    return {
        Speed = speedCost,
        Cash = cashCost,
        Health = healthCost
    }
end

return Calculator