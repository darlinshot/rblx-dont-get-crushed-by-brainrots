local Players = game:GetService("Players")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local ROOT = script.Parent

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild(ROOT.Name)
local HOLDER = MAIN_UI:WaitForChild("Holder")

local container = HOLDER.Container
local baseNotif = container.BaseNotification

-- / MAIN
local Objects = {}

function Objects.GetMainUI()
    return MAIN_UI
end

function Objects.GetContainer()
    return container
end

function Objects.GetBaseNotification()
    return baseNotif
end

function Objects.GetNewNotification()
    return Objects.GetBaseNotification():Clone()
end

return Objects