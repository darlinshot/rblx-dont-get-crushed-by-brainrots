local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
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
end

function ProgressControllers.RenderAllData(plr: Player)
    ProgressControllers.CurrenciesController.RenderAll(plr)
	ProgressControllers.UpgradesController.RenderStats(plr)
end

return ProgressControllers