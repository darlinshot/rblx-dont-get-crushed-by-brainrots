local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local GroupService = game:GetService("GroupService")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)
local ProgressControllers = require(MODULES.ProgressControllers)
local Notifications = require(MODULES.Notifications)

-- / REMOTE EVENTS
local REMOTE_EVENTS = ReplicatedStorage.Remotes.RemoteEvents
local groupRE = REMOTE_EVENTS.Group

-- / NOTIFICATIONS
local rewardMsg = "Congrats! You got %i from Group Rewards!"
local notInGroupMsg = "You must join the group to get this reward!"
local waitMsg = "You must wait %02ih:%02im:%02is to claim this reward!"
local goodNotifColor = Color3.fromRGB(0, 255, 0)
local badNotifColor = Color3.fromRGB(255, 0, 0)

-- / MISCS
local GROUP_ID = 1078990756
local REWARD = 2500
local REWARD_COOLDOWN = 24*60*60 -- 24 hours

-- / MAIN
local Zone = {}

Zone.OnPlayerEntered = function(plr: Player)
    local joinedGroup = plr:IsInGroupAsync(GROUP_ID)
    if not joinedGroup then
        groupRE:FireClient(plr, {GroupID = GROUP_ID})
        Notifications.ShowNotification(plr, {Message = notInGroupMsg, TextColor = badNotifColor})
        return            
    end

    local data = DataController.GetPlayerData(plr)
    local lastReceived = data.GroupRewardLastReceived
    if not lastReceived then lastReceived = 0 end

    local timePassed = os.time() - lastReceived
    if timePassed < REWARD_COOLDOWN then
        local timeLeft = REWARD_COOLDOWN - timePassed
        local hours = math.floor(timeLeft / 3600)
		local minutes = math.floor((timeLeft % 3600) / 60)
		local seconds = math.floor(timeLeft % 60)

		Notifications.ShowNotification(plr, {
            Message = string.format(waitMsg, hours, minutes, seconds),
            TextColor = badNotifColor })
        return
    end

    data.Cash += REWARD
    data.GroupRewardLastReceived = os.time()
    Notifications.ShowNotification(plr, {
            Message = string.format(rewardMsg, REWARD),
            TextColor = goodNotifColor
    })
    ProgressControllers.RenderAllData(plr)
end

return Zone