local Players = game:GetService("Players")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local MAIN = script
local ROOT
local Errors = require(MAIN.Errors)

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild()
local HOLDER = MAIN_UI.Holder

local title = HOLDER.Title
local close = title.CloseButton
local closeButton: GuiButton = close.Button



local Render = {}

function Render.Render()

end

return Render