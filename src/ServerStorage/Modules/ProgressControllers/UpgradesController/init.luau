local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / REMOTE EVENTS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

local renderUIRE = REMOTE_EVENTS.RenderUI

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)
local Notifications = require(MODULES.Notifications)

local MAIN = script
local Calculator = require(MAIN.Calculator)
local Errors = require(MAIN.Errors)
local Config = require(MAIN.Config)

-- / MAIN
local UpgradesController = {}

function UpgradesController.Init()
    for name, func in Calculator do
        UpgradesController[name] = func
    end
end

function UpgradesController.RenderStats(plr: Player)
	local renderType = "ShowUI"
    local stats = DataController.GetPlayerData(plr)

    local rebirthLvl = stats.Rebirths
    local upgrades = stats.Upgrades
    local speedLvl = upgrades.Speed
    local healthLvl = upgrades.Health
    local cashLvl = upgrades.Cash

    local currentStats = UpgradesController.CalculateStats(speedLvl, cashLvl, healthLvl, rebirthLvl)
    local newStats = UpgradesController.CalculateStats(speedLvl+1, cashLvl+1, healthLvl+1, rebirthLvl)
    local costs = UpgradesController.CalculateCosts(speedLvl, cashLvl, healthLvl)

    local packet = {
        UI = "UpgradesUI",
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
    renderUIRE:FireClient(plr, packet)
end

function UpgradesController.UpgradePlayer(plr: Player, upgrade: string, checkCash: boolean)
    if checkCash == nil then checkCash = true end

    if not upgrade then
       warn(Errors.NO_UPGRADE_PROVIDED)
       return false 
    end 

	local data = DataController.GetPlayerData(plr)

	local plrCash = data.Cash

	local rebirthLvl = data.Rebirths
	local upgrades = data.Upgrades
	local speedLvl = upgrades.Speed
	local healthLvl = upgrades.Health
	local cashLvl = upgrades.Cash

	local costs = UpgradesController.CalculateCosts(speedLvl, cashLvl, healthLvl)

	local upgradeCost = costs[upgrade]
    if not upgradeCost then
        warn(Errors.UPGRADE_NOT_EXISTS)
        return false
    end

	if checkCash == true then
        if upgradeCost > plrCash then
            local packet = {
                UI = "ExclusiveShopUI",
                RenderType = "ShowUI"
            }
            Notifications.ShowNotification(plr, Config.ERROR_MESSAGE)
            renderUIRE:FireClient(plr, packet)
			-- TODO: NOTIFICATION SERVICE TO
			-- ANNOUNCE TO PLAYER THAT THEY
			-- DON'T HAVE ENOUGH MONEY

			return false
	    end
    end
    
	-- local newStats = UpgradesController.CalculateStats(speedLvl + 1, cashLvl + 1, healthLvl + 1, rebirthLvl)
    
    local ok, err = pcall(function()
        data.Upgrades[upgrade] += 1

        if checkCash == true then
			data.Cash -= upgradeCost
        end
	end)
    if not ok then warn(`Error setting upgrade: {err}`) return false end

    return true
end

return UpgradesController