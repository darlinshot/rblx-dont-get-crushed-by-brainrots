-- / MODULES
local MAIN = script

local ROOT = MAIN.Parent.Parent
local Objects = require(ROOT.Objects)

local MAIN_UI = Objects.GetMainUI()

-- / MAIN
local Render = {}

function Render.Render()
    MAIN_UI.Enabled = false
end

return Render