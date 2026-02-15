local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)

local MAIN = script
local UpgradesController = require(MAIN.UpgradesController)

-- / REMOTE EVENTS
local REMOTE_EVENTS = ReplicatedStorage.Remotes.RemoteEvents
local renderUIRE = REMOTE_EVENTS.RenderUI

-- / MAIN
local ProgressController = {}
ProgressController.UpgradesController = UpgradesController

function ProgressController.Init()
    UpgradesController.Init()
end

function ProgressController.RenderMainStats(plr: Player)
    local stats = DataController.GetPlayerData(plr)
    
    local packet = {
        UI = "CurrencyUI",
        RenderType = "UpdateUI",
        Stats = {
            Cash = stats.Cash,
            Wins = stats.Wins
        }
    }
    renderUIRE:FireClient(plr, packet)

end

return ProgressController