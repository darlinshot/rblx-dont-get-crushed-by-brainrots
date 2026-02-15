local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local ProgressControllers = require(MODULES.ProgressControllers)
local DataController = require(MODULES.DataController)
local ProgressControllers = require(MODULES.ProgressControllers)

local MAIN = script
local Errors = require(MAIN.Errors)

-- / MAIN
return function(plr, packet)
	local upgrade = packet.Upgrade
	assert(upgrade, Errors.NO_UPGRADE_PROVIDED)

	local data = DataController.GetPlayerData(plr)

	local plrCash = data.Cash

	local rebirthLvl = data.Rebirths
	local upgrades = data.Upgrades
	local speedLvl = upgrades.Speed
	local healthLvl = upgrades.Health
	local cashLvl = upgrades.Cash

	local costs = ProgressControllers.UpgradesController.CalculateCosts(speedLvl, cashLvl, healthLvl)

	local upgradeCost = costs[upgrade]
	assert(upgradeCost, string.format(Errors.UPGRADE_NOT_EXISTS, upgrade))

	if upgradeCost > plrCash then
        print("POOR")
		-- TODO: NOTIFICATION SERVICE TO
		-- ANNOUNCE TO PLAYER THAT THEY
		-- DON'T HAVE ENOUGH MONEY

		return
	end
	-- local newStats = UpgradesController.CalculateStats(speedLvl + 1, cashLvl + 1, healthLvl + 1, rebirthLvl)
    
    local ok, err = pcall(function()
        data.Upgrades[upgrade] += 1
        data.Cash -= upgradeCost

		-- Health and Speed
		ProgressControllers.StatsController.UpdatePlayer(plr)

		-- Cash, Upgrade related data(CurrentStat, NewStat, Cost)
		ProgressControllers.RenderAllData(plr)

    end)
    if not ok then warn(`Error setting upgrade: {err}`) return end
end
