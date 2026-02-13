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

local contents = HOLDER.Contents
local contentsContainer = contents.Container

-- / MAIN
local Objects = {}

function Objects.GetMainUI()
    return MAIN_UI
end

Objects.UpgradeContainerNames = {
    ["Speed"] = "1_Speed",
    ["Cash"] = "2_Cash",
    ["Health"] = "3_Health"
}
function Objects.GetUpgrade(upgrade: string)
    local name = Objects.UpgradeContainerNames[upgrade]
    assert(name, string.format(Errors.INVALID_UPGRADE, upgrade))

    -- Should be here so no need for error message
    local upgradeFrame = contentsContainer:FindFirstChild(name)
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
return Objects