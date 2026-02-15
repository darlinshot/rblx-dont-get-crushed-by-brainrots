local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)

-- / REMOTE EVENTS
local REMOTE_EVENTS = ReplicatedStorage.Remotes.RemoteEvents
local renderUIRE = REMOTE_EVENTS.RenderUI

local CurrenciesController = {}

function CurrenciesController.Init()
    
end

function CurrenciesController.RenderAll(plr: Player)
    local stats = DataController.GetPlayerData(plr)
    
    local packet = {
        UI = "CurrenciesUI",
        RenderType = "UpdateUI",
        Data = {
            Cash = stats.Cash,
            Wins = stats.Wins
        }
    }
    renderUIRE:FireClient(plr, packet)

end

return CurrenciesController