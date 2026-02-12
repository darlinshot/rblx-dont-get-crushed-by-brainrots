local Players = game:GetService("Players")

-- / SERVICES

-- / MODULES
local MAIN = script
local Character = require(MAIN.Character)
local Player = require(MAIN.Player)

-- / MAIN
local PlayerController = {}
PlayerController.Controllers = {}

function PlayerController.Init()
    PlayerController.PlayerAdded = Players.PlayerAdded:Connect(function(plr)
        local controller = PlayerController.Controllers["Player_"..plr.UserId]
        if controller and controller.Destroy then
            controller:Destroy()
            table.clear(controller)
        end

        controller = Player.New(plr)
        if not controller then
            return
        end
        PlayerController.Controllers["Player_"..plr.UserId] = controller
    end)

    PlayerController.PlayerRemoving = Players.PlayerRemoving:Connect(function(plr)
        local controller = PlayerController.Controllers["Player_"..plr.UserId]
        if not controller then return end

        controller:Destroy()
        controller = nil
        PlayerController.Controllers["Player_"..plr.UserId] = nil
    end)
end

return PlayerController