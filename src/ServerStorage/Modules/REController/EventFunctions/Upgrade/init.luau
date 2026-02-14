local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local UpgradesController = require(MODULES.UpgradesController)
local DataController = require(MODULES.DataController)
local ProgressController = require(MODULES.ProgressController)

local MAIN = script
local Errors = require(MAIN.Errors)

-- / MAIN
return function(plr, packet)
	local upgrade = packet.Upgrade
	assert(upgrade, Errors.NO_UPGRADE_PROVIDED)

	local stats = DataController.GetPlayerData(plr)

	local plrCash = stats.Cash

	local rebirthLvl = stats.Rebirths
	local upgrades = stats.Upgrades
	local speedLvl = upgrades.Speed
	local healthLvl = upgrades.Health
	local cashLvl = upgrades.Cash

	local costs = UpgradesController.CalculateCosts(speedLvl, cashLvl, healthLvl)

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
        stats.Upgrades[upgrade] += 1
        stats.Cash -= upgradeCost

		ProgressController.RenderMainStats(plr)
        UpgradesController.UpgradePlayer(plr)

        -- TODO: SET SPEED/HEALTH
    end)
    if not ok then warn(`Error setting upgrade: {err}`) return end
end
