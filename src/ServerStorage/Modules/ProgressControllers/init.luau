local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)

local MAIN = script

-- / MAIN
local ProgressControllers = {}

function ProgressControllers.Init()
    for _, controller in MAIN:GetChildren() do
        if not controller:IsA("ModuleScript") then continue end
        if ProgressControllers[controller.Name] then continue end

        local ok, err = pcall(function()
			local load = require(controller)
            if load.Init then load.Init() end
            
			ProgressControllers[controller.Name] = load
        end)
    end

	ProgressControllers.RenderCurrencies = ProgressControllers.CurrenciesController.RenderAll
	ProgressControllers.RenderStats = ProgressControllers.UpgradesController.RenderStats
end

function ProgressControllers.UpgradePlayer(plr: Player, upgrade: string, checkCash: boolean)
    local ok, msg = ProgressControllers.UpgradesController.UpgradePlayer(plr, upgrade, checkCash)
    if not ok then
        if msg then warn(msg) end
        return false
    end
	-- Health and Speed
	ProgressControllers.StatsController.UpdatePlayer(plr)

	-- Cash, Upgrade related data(CurrentStat, NewStat, Cost)
	ProgressControllers.RenderAllData(plr)

    return true
end



function ProgressControllers.RenderAllData(plr: Player)
    ProgressControllers.RenderCurrencies(plr)
	ProgressControllers.RenderStats(plr)
end
return ProgressControllers