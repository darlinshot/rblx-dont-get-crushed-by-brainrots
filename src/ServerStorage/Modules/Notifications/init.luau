local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES
local MAIN = script
local Types = require(MAIN.Types)

-- / REMOTE EVENTS
local REMOTE_EVENTS = ReplicatedStorage.Remotes.RemoteEvents
local renderUIRE: RemoteEvent = REMOTE_EVENTS.RenderUI

-- / TYPES
export type NotificationInfo = Types.NotificationInfo

-- / MAIN
local Notifications = {}

function Notifications.ShowNotification(plr: Player, info: NotificationInfo)
    local packet = {
        UI = "NotificationsUI",
        RenderType = "NewNotification",
        Data = info
    }
    if not plr then
        renderUIRE:FireAllClients(packet)
        return
    end

    renderUIRE:FireClient(plr, packet)
end

return Notifications