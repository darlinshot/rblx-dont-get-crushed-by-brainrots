local PhysicsService = game:GetService("PhysicsService")

local Character = {}

function Character.CharacterAdded(char: Model)
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    root.CollisionGroup = "CharacterRootPart"
end

return Character