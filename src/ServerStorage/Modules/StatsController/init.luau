local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)

-- / REMOTE EVENTS
local REMOTE_EVENTS = ReplicatedStorage.Remotes.RemoteEvents
local statsEvent = REMOTE_EVENTS.Stats

local StatsController = {}

function StatsController.RenderMainStats(plr: Player)
    local stats = DataController.GetPlayerData(plr)
    
    local packet = {
        RenderType = "UpdateUI",
        Stats = {
            Cash = stats.Cash,
            Wins = stats.Wins
        }
    }
    statsEvent:FireClient(plr, packet)

end

return StatsController