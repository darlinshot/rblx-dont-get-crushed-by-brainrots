local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)

local ROOT = script.Parent

local SHARED_MODULES = ReplicatedStorage:WaitForChild("SharedModules")
local DeveloperProducts = require(SHARED_MODULES.DeveloperProducts)

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild(ROOT.Name)
local HOLDER = MAIN_UI:WaitForChild("Holder")

local contentsContainer = HOLDER.Contents.Container
local title = HOLDER.Title

-- / MAIN
local Objects = {}

function Objects.GetMainUI()
    return MAIN_UI
end

function Objects.GetCloseButton()
    return title.CloseButton.Button
end

function Objects.GetCashObjects()
    local objects = {}
    for amount, _ in DeveloperProducts.Cash do
        local cashFrame = contentsContainer:WaitForChild(`Cash{amount}`)
        if not cashFrame then continue end

        objects[amount] = cashFrame
    end
    return objects
end

function Objects.GetCashButtons()
    local objects = {}
    local cash_objects = Objects.GetCashObjects()
    for amount, object in cash_objects do
        objects[amount] = object.BuyButton.Button
    end
    return objects
end

function Objects.GetButtons()
    local objects = {}
    objects.CashButtons = Objects.GetCashButtons()
    objects.CloseButton = Objects.GetCloseButton()
    return objects
end

return Objects