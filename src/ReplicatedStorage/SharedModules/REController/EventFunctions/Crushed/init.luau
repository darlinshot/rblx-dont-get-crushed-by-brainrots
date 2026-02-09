local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / PLAYER
local plr = Players.LocalPlayer

-- / MODULES
local SHARED_MODULES = ReplicatedStorage.SharedModules
local Ragdoll = require(SHARED_MODULES.Ragdoll)

-- / MAIN
return function(args)
    local char = plr.Character or plr.CharacterAdded:Wait()
    if not char then return end

    -- TODO: Ragdoll and then knock back
    
end