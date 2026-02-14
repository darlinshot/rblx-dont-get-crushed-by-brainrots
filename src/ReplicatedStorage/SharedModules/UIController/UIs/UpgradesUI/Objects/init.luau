local Players = game:GetService("Players")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)

local ROOT = script.Parent

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild(ROOT.Name)
local HOLDER = MAIN_UI.Holder

local title = HOLDER.Title
local contentsContainer = HOLDER.Contents.Container

-- / MAIN
local Objects = {}

function Objects.GetMainUI()
    return MAIN_UI
end

function Objects.GetUpgrade(upgrade: string)
    -- Should be here so no need for error message
    local upgradeFrame = contentsContainer:FindFirstChild(upgrade)
    if not upgradeFrame then
        return
    end

    local objects = {}
    objects.BuyButton = upgradeFrame.BuyButtons.CurrencyBuyButton.Button
    objects.RobuxBuyButton = upgradeFrame.BuyButtons.RobuxBuyButton.Button
    objects.CurrentStat = upgradeFrame.InfoDisplay.CurrentStat
    objects.NewStat = upgradeFrame.InfoDisplay.NewStat
    objects.Product = upgradeFrame.InfoDisplay.Product

    return objects
end

function Objects.GetTitle()
    local objects = {}

    objects.CloseButton = title.CloseButton.Button
    objects.Title = title.IconAndTitle.Title

    return objects
end

function Objects.GetButtons()
    local objects = {}
    objects.UpgradeButtons = {}
    for _, upgradeFrame in contentsContainer:GetChildren() do
        if upgradeFrame:IsA("UIGridStyleLayout") then continue end

        local upgrade = upgradeFrame.Name
        local upgrade_objects = Objects.GetUpgrade(upgrade)
        
        local upgrade_buttons = {}
        upgrade_buttons.BuyButton = upgrade_objects.BuyButton
        upgrade_buttons.RobuxBuyButton = upgrade_objects.RobuxBuyButton
        objects.UpgradeButtons[upgrade] = upgrade_buttons
    end

    local title_objects = Objects.GetTitle()
    
    objects.CloseButton = title_objects.CloseButton

    return objects
end
return Objects