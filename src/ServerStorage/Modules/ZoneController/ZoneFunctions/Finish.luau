local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)
local ProgressControllers = require(MODULES.ProgressControllers)

-- / MAIN
local Zone = {}

Zone.OnPlayerEntered = function(plr: Player)
    local data = DataController.GetPlayerData(plr)
    local rebirths = data.Rebirths
    local upgrades = data.Upgrades

	local cashToGive = ProgressControllers.UpgradesController.CalculateTotalCash(upgrades.Cash, rebirths)
    data.Cash += cashToGive
    data.Wins += 1

    plr:LoadCharacterAsync()

    ProgressControllers.CurrenciesController.RenderAll(plr)
end

return Zone