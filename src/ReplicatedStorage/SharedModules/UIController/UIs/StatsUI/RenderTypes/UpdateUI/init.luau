-- / MODULES
local MAIN = script
local RenderFormats = require(MAIN.RenderFormats)

local ROOT = MAIN.Parent.Parent
local Objects = require(ROOT.Objects)

-- / MAIN
local Render = {}

function Render.Render(packet)
    local stat_objects = Objects.GetStatObjects()
    local stats = packet.Stats

    for stat, amountText in stat_objects do
        local amount = stats[stat]
        if not amount then continue end

        local format = RenderFormats[stat]
        if format then
            amountText.Text = string.format(format, amount)
        else
			amountText.Text = amount
        end
    end
end

return Render