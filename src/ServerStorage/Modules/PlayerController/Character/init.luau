-- / SERVICES
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local ProgressControllers = require(MODULES.ProgressControllers)

-- / MAIN
local Character = {}

function Character.OnCharacterAdded(char: Model)
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum: Humanoid = char:FindFirstChild("Humanoid")
    if not (root and hum) then return end

	-- Health and Speed
	local plr = Players:GetPlayerFromCharacter(char)
    ProgressControllers.StatsController.UpdatePlayer(plr)

    root.CollisionGroup = "CharacterRootPart"

    root:SetAttribute("SetupComplete")
end

return Character