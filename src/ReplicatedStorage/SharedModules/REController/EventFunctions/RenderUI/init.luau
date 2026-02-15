local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES
local SHARED_MODULES = ReplicatedStorage.SharedModules
local UIController = require(SHARED_MODULES.UIController)

local MAIN = script
local Errors = require(MAIN.Errors)

-- / MAIN
return function (packet)
    local ui = packet.UI
    assert(ui, Errors.NO_UI_PROVIDED)

    UIController.Render(ui, packet)
end