local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / PLAYER
local plr = Players.LocalPlayer

-- / MODULES
local SHARED_MODULES = ReplicatedStorage.SharedModules
local DeveloperProducts = require(SHARED_MODULES.DeveloperProducts)

local MAIN = script

local ROOT = MAIN.Parent
local RenderTypes = require(ROOT.RenderTypes)
local Errors = require(ROOT.Errors)

-- / REMOTE EVENTS
local REMOTE_EVENTS = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents
local upgradeEvent: RemoteEvent = REMOTE_EVENTS.Upgrade

-- / MAIN
local Interactions = {}

function Interactions.OnCloseButonClicked()
	RenderTypes.Registry.HideUI.Render()
end

function Interactions.OnBuyButtonClicked(upgrade: string)
    upgradeEvent:FireServer({Upgrade = upgrade})
end

function Interactions.OnRobuxBuyButtonClicked(upgrade: string)
    local productId = DeveloperProducts.Upgrades[upgrade]
    assert(productId, Errors.PRODUCT_ID_NOT_EXISTS)

    MarketplaceService:PromptProductPurchase(plr, productId)
end

return Interactions