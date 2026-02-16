-- / MODULES
local MAIN = script

local ROOT = MAIN.Parent.Parent
local Objects = require(ROOT.Objects)

-- / UI
local MAIN_UI = Objects.GetMainUI()

-- / MAIN
local Render = {}
function Render.Render(packet)
    MAIN_UI.Enabled = true
end

return Render