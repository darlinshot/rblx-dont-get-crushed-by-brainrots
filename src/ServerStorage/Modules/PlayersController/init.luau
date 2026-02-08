local Players = game:GetService("Players")

-- / SERVICES

-- / MODULES
local MAIN = script
local Character = require(MAIN.Character)
local Player = require(MAIN.Player)

-- / MAIN
local PlayersController = {}
PlayersController.Controllers = {}

function PlayersController.Init()
    PlayersController.PlayerAdded = Players.PlayerAdded:Connect(function(plr)
        local controller = PlayersController.Controllers[plr.UserId]
        if controller and controller.Destroy then
            controller:Destroy()
            table.clear(controller)
        end
        controller = nil

        PlayersController.Controllers[plr.UserId] = Player.New(plr)
    end)

    PlayersController.PlayerRemoving = Players.PlayerRemoving:Connect(function(plr)
        local controller = PlayersController.Controllers[plr.UserId]
        if not controller then return end

        controller:Destroy()
        controller = nil
        PlayersController.Controllers[plr.UserId] = nil
    end)
end

return PlayersController