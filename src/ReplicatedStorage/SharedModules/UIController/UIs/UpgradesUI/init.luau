local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)
local Objects = require(MAIN.Objects)
local Config = require(MAIN.Config)

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild(MAIN.Name)

-- / CONFIG

-- / MAIN
local UI = {}
UI.RenderTypes = {}
UI.ButtonConnections = {}

function UI.Init()
    for _, renderType in MAIN.RenderTypes:GetChildren() do
        if UI.RenderTypes[renderType.Name] then continue end

        UI.RenderTypes[renderType.Name] = require(renderType)
    end    

    local buttons = Objects.GetButtons()
    for upgrade, upgradeBtn in buttons.UpgradeButtons do
        local buyBtn = upgradeBtn.BuyButton
        local rbxBuyButton = upgradeBtn.RobuxBuyButton
       
        local info =  MarketplaceService:GetProductInfoAsync(Config.DeveloperProducts.Upgrades[upgrade], Enum.InfoType.Product)
        local rbxPrice = info.PriceInRobux
        rbxBuyButton.Text = `{rbxPrice}`
    end

    UI.CloseConnection = buttons.CloseButton.MouseButton1Click:Connect(function()
        if MAIN_UI.Enabled == true then
            UI.RenderTypes.HideUI.Render()
        else
            UI.RenderTypes.ShowUI.Render()
        end
    end)
end

function UI.Render(packet)
    local renderType = packet.RenderType
    assert(renderType, Errors.NO_RENDER_TYPE)

    local render = UI.RenderTypes[renderType]
    if not render then
        warn(string.format(Errors.RENDER_TYPE_NOT_EXISTS, renderType))
        return
    end

    render.Render(packet)
end

return UI