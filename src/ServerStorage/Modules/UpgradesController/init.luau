local UpgradeController = {}

UpgradeController.BASE_SPEED = 10
UpgradeController.BASE_SPEED_UPGRADE_COST = 200
UpgradeController.SPEED_GROWTH = 1.5
UpgradeController.SPEED_COST_GROWTH = 1.15

function UpgradeController.CalculateSpeedStat(level: number)
    return UpgradeController.BASE_SPEED+(level-1)*UpgradeController.SPEED_GROWTH
end

function UpgradeController.CalculateSpeedCost(level: number)
    return UpgradeController.BASE_SPEED_UPGRADE_COST*(math.pow(UpgradeController.SPEED_COST_GROWTH, level-1))
end

UpgradeController.BASE_CASH = 1000
UpgradeController.BASE_CASH_UPGRADE_COST = 200
UpgradeController.BASE_CASH_GROWTH = 500
UpgradeController.BASE_CASH_COST_GROWTH = 1.25

function UpgradeController.CalculateCashStat(level: number)
    return UpgradeController.BASE_CASH+(level-1)*UpgradeController.BASE_CASH_GROWTH
end

function UpgradeController.CalculateCashCost(level: number)
    return UpgradeController.BASE_CASH_UPGRADE_COST*(math.pow(UpgradeController.BASE_CASH_COST_GROWTH, level-1))
end

UpgradeController.BASE_HEALTH = 100
UpgradeController.BASE_HEALTH_UPGRADE_COST = 200
UpgradeController.HEALTH_GROWTH = 25
UpgradeController.HEALTH_COST_GROWTH = 1.2

function UpgradeController.CalculateHealthStat(level: number)
   return UpgradeController.BASE_HEALTH+(level-1)*UpgradeController.HEALTH_GROWTH 
end

function UpgradeController.CalculateHealthCost(level: number)
   return UpgradeController.BASE_HEALTH_UPGRADE_COST*(math.pow(UpgradeController.HEALTH_COST_GROWTH, level-1)) 
end

UpgradeController.BASE_REBIRTH_COST = 5000
UpgradeController.REBIRTH_GROWTH = 2.5
UpgradeController.REBIRTH_CASH_MULTIPLIER = 0.5
    
function UpgradeController.CalculateCashMultiplier(rebirth: number)
    return 1+(rebirth*0.5)
end

function UpgradeController.CalculateRebirthCost(rebirth: number)
   return UpgradeController.BASE_REBIRTH_COST+(UpgradeController.REBIRTH_GROWTH*rebirth) 
end

function UpgradeController.CalculateTotalCash(level: number, rebirth: number)
    local cash = UpgradeController.CalculateCashStat(level)
    local multipler = UpgradeController.CalculateCashMultiplier(rebirth)
    return cash*multipler
end
return UpgradeController