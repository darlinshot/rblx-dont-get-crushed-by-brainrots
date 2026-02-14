local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / REMOTE EVENTS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

local upgradeEvent = REMOTE_EVENTS.Upgrade

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)

local MAIN = script
local Calculator = require(MAIN.Calculator)

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