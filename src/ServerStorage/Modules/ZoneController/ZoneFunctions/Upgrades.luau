local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local ProgressController = require(MODULES.ProgressController)
local DataController = require(MODULES.DataController)

-- / REMOTE EVENTS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

local renderUIRE = REMOTE_EVENTS.RenderUI

-- / MAIN
local Zone = {}

Zone.OnPlayerEntered = function(plr: Player)
    ProgressController.UpgradesController.RenderStats(plr)
end

Zone.OnPlayerExit = function(plr: Player)

    local packet = {
        UI = "UpgradesUI",
        RenderType = "HideUI"
    }
    renderUIRE:FireClient(plr, packet)
end

return Zone