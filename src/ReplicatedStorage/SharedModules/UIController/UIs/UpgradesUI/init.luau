local Players = game:GetService("Players")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild(script.Name)
local HOLDER = MAIN_UI.Holder

local title = HOLDER.Title
local close = title.CloseButton
local closeButton: GuiButton = close.Button

-- / MAIN
local UI = {}

function UI.Init()
    UI.CloseConnection = closeButton.MouseButton1Click:Connect(function()
        if MAIN_UI.Enabled == true then
            MAIN_UI.Enabled = false
        else
            MAIN_UI.Enabled = true
        end
    end)
end

function UI.Render(packet)
    local renderType = packet.RenderType
    assert(renderType, Errors.NO_RENDER_TYPE)


end

return UI