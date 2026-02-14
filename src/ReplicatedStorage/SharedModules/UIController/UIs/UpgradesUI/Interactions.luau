local MarketplaceService = game:GetService("MarketplaceService")

-- / MODULES
local MAIN = script

local ROOT = MAIN.Parent
local Config = require(ROOT.Config)
local RenderTypes = require(ROOT.RenderTypes)

-- / MAIN
local Interactions = {}

function Interactions.OnCloseButonClicked()
    RenderTypes.Registry.HideUI.Render()
end

function Interactions.OnBuyButtonClicked(upgrade: string)
    print("heave hooo")
end

function Interactions.OnRobuxBuyButtonClicked(upgrade: string)

end

return Interactions