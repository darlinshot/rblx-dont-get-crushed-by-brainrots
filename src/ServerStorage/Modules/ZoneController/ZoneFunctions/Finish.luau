local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)
local ProgressControllers = require(MODULES.ProgressControllers)
local Notifications = require(MODULES.Notifications)

-- / NOTIFICATIONS
local winMessage = "You finished and got %i Cash! Remember to upgrade!"
local notifColor = Color3.fromRGB(0, 255, 0)

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
    Notifications.ShowNotification(plr, {
        Message = string.format(winMessage, cashToGive),
        TextColor = notifColor
    })
end

return Zone