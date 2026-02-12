--[[
local packet = {
        Action = action,

        CurrentSpeed = currentSpeed,
        NewSpeed = newSpeed,
        SpeedCost = speedCost,

        CurrentHealth = currentHealth,
        HewHealth = newHealth,
        HealthCost = healthCost,

        CurrentCash = currentCash,
        NewCash = newCash,
        CashCost = cashCost
    }]]

-- / MAIN
local MAIN = script
local ACTION_MODULES = MAIN.Actions

local actions = {}
for _, actionModule in ACTION_MODULES:GetChildren() do
    if actions[actionModule.Name] then continue end

    actions[actionModule.Name] = require(actionModule)
end

return function (args)
    local action = args.Action
    if not action then return end

end