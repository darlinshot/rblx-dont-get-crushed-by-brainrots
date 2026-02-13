-- / MODULES
local MAIN = script

local ROOT = MAIN.Parent.Parent
local Objects = require(ROOT.Objects)

-- / UI
local MAIN_UI = Objects.GetMainUI()

-- / MAIN
local Render = {}

function Render.RenderUpgrade(upgrade: string, args)
    local objects = Objects.GetUpgrade(upgrade)

    local buyBtn = objects.BuyButton
    local robuxBuyBtn = objects.RobuxBuyButton
    local currentStat = objects.CurrentStat
    local newStat = objects.NewStat
    local product = objects.Product

    buyBtn.Text = `${args.Cost}`
    currentStat.Text = `+{args.CurrentStat} {upgrade}`
    newStat.Text = `+{args.NewStat} {upgrade}`
    product.Text = `+{args.NewStat-args.CurrentStat} {upgrade}`

end

function Render.Render(packet)
    local upgrades = packet.Upgrades
    for upgrade, upgradeArgs in upgrades do
        Render.RenderUpgrade(upgrade, upgradeArgs)
    end

    MAIN_UI.Enabled = true
end

return Render