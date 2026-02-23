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

    -- Root
    root.CollisionGroup = "CharacterRootPart"
    
    local rootY = root.Size.Y
    local rootZ = root.Size.Z

    local trailAtt0 = Instance.new("Attachment")
	trailAtt0.Position = Vector3.new(0, rootY / 2, 0)
    trailAtt0.Name = "TrailAttachment0"
    trailAtt0.Parent = root

    local trailAtt1 = trailAtt0:Clone()
    trailAtt1.Position = Vector3.new(0, -rootY / 2, 0)
    trailAtt1.Name = "TrailAttachment1"
    trailAtt1.Parent = root

    root:SetAttribute("SetupComplete")
end

return Character