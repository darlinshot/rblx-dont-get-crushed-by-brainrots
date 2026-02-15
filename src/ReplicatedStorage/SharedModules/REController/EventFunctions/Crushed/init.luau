local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / PLAYER
local plr = Players.LocalPlayer

-- / MAIN
return function(packet)
    local ragdollDuration = packet.RagdollDuration
    local knockbackForce = packet.KnockbackForce
    if not knockbackForce then return end

    local char = plr.Character or plr.CharacterAdded:Wait()
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum: Humanoid = char:FindFirstChild("Humanoid")
    if not (root and hum) then return end

    root:ApplyImpulse(knockbackForce)
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    
    if ragdollDuration then
        task.wait(ragdollDuration)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end