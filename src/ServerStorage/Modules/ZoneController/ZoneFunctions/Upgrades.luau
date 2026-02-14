local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local UpgradesController = require(MODULES.UpgradesController)
local DataManager = require(MODULES.DataManager)

-- / REMOTE EVENTS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

local upgradeEvent = REMOTE_EVENTS.Upgrade

-- / MAIN
local Zone = {}

Zone.OnPlayerEntered = function(plr: Player)
    UpgradesController.RenderStats(plr)
end

Zone.OnPlayerExit = function(plr: Player)
    local renderType = "HideUI"

    local packet = {
        RenderType = renderType
    }
    upgradeEvent:FireClient(plr, packet)
end

return Zone