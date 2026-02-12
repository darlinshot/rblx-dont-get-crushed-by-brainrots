-- / SERVICES
local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES


-- / MAIN
local Character = {}

function Character.OnCharacterAdded(char: Model)
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum: Humanoid = char:FindFirstChild("Humanoid")
    if not (root and hum) then return end

    hum.BreakJointsOnDeath = false

    root.CollisionGroup = "CharacterRootPart"

    root:SetAttribute("SetupComplete")
end

return Character