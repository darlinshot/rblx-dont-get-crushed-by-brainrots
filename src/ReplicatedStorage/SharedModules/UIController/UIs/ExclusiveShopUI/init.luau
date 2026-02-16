local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local SHARED_MODULES = ReplicatedStorage.SharedModules
local DeveloperProducts = require(SHARED_MODULES.DeveloperProducts)

local MAIN = script
local Objects = require(MAIN.Objects)
local Interactions = require(MAIN.Interactions)
local RenderTypes = require(MAIN.RenderTypes)

-- / MAIN
local UI = {}
UI.Connections = {}

function UI.Init()
    RenderTypes.Init()
    
    local buttons = Objects.GetButtons()
    for amount, buyBtn in buttons.CashButtons do
        local buy_connections = {}

        local info =  MarketplaceService:GetProductInfoAsync(DeveloperProducts.Cash[amount], Enum.InfoType.Product)
        local rbxPrice = info.PriceInRobux
        buyBtn.Text = `{rbxPrice}`

        buy_connections.BuyButtonConnection = buyBtn.Activated:Connect(function()
            Interactions.OnBuyButtonClicked(amount)
        end)

        UI.Connections[amount] = buy_connections
    end

    UI.Connections.CloseConnection = buttons.CloseButton.Activated:Connect(Interactions.OnCloseButonClicked)
end

function UI.Render(packet)
    RenderTypes.Render(packet)
end

return UI