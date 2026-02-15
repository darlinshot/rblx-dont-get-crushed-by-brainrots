-- / MODULES
local MAIN = script
local RenderFormats = require(MAIN.RenderFormats)

local ROOT = MAIN.Parent.Parent
local Objects = require(ROOT.Objects)

-- / MAIN
local Render = {}

function Render.Render(packet)
    local currency_objects = Objects.GetCurrencyObjects()
    local data = packet.Data

    for currency, amountText in currency_objects do
        local amount = data[currency]
        if not amount then continue end

        local format = RenderFormats[currency]
        if format then
            amountText.Text = string.format(format, amount)
        else
			amountText.Text = amount
        end
    end
end

return Render