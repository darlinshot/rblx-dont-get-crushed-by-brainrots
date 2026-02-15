local Players = game:GetService("Players")

-- / PLAYER
local plr = Players.LocalPlayer
local PLAYER_GUI = plr.PlayerGui

-- / MODULES
local ROOT = script.Parent

-- / UI
local MAIN_UI = PLAYER_GUI:WaitForChild(ROOT.Name)
local HOLDER = MAIN_UI.Holder

-- / MAIN
local Objects = {}

function Objects.GetMainUI()
    return MAIN_UI
end

function Objects.GetCash()
    return HOLDER.Cash.Amount
end

function Objects.GetWins()
    return HOLDER.Wins.Amount
end

function Objects.GetCurrencyObjects()
    return {
        Cash = Objects.GetCash(),
        Wins = Objects.GetWins()
    }
end

return Objects