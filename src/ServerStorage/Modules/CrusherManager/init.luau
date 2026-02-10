local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- / ASSETS
local REMOTES = ReplicatedStorage.Remotes
local REMOTE_EVENTS = REMOTES.RemoteEvents

-- / WORKSPACE
local GAME_SYSTEM = workspace.GameSystem
local CRUSHERS_HOLDER = GAME_SYSTEM.Crushers

-- / MODULES
local MAIN = script
local Crusher = require(MAIN.Crusher)
local Errors = require(MAIN.Errors)
local Config = require(MAIN.Config)

-- / REMOTE EVENTS
local crushedEvent = REMOTE_EVENTS.Crushed

-- / MAIN
local CrusherManager = {}

CrusherManager.ActiveCrushers = {}
CrusherManager.InactiveCrushers = {}
CrusherManager.UpdateConnection = nil
CrusherManager.LastHit = {}

function CrusherManager.NewCrusher(model: Model, startPos: Vector3, targetPos: Vector3)
    model = model:Clone()
    local crusher = Crusher.New(model, startPos, targetPos)

    if not crusher then warn(Errors.CRUSHER_CREATION_FAILED) return end
    
    CrusherManager.SetCrusherActive(crusher)
end

function CrusherManager.SetCrusherActive(crusher)
    local activeIndex = table.find(CrusherManager.ActiveCrushers, crusher) 
    if activeIndex then warn(Errors.CRUSHER_ALREADY_ACTIVE) return end
    
    local inactiveIndex = table.find(CrusherManager.InactiveCrushers, crusher)
    if inactiveIndex then
        table.remove(CrusherManager.InactiveCrushers, inactiveIndex)
    end

    table.insert(CrusherManager.ActiveCrushers, crusher)

    crusher.Model.Parent = CRUSHERS_HOLDER
end

function CrusherManager.SetCrusherInactive(crusher)
    local inactiveIndex = table.find(CrusherManager.InactiveCrushers, crusher)
    if inactiveIndex then warn(Errors.CRUSHER_ALREADY_INACTIVE) return end

    local activeIndex = table.find(CrusherManager.ActiveCrushers, crusher)
    if activeIndex then table.remove(CrusherManager.ActiveCrushers, activeIndex) end

    table.insert(CrusherManager.InactiveCrushers, crusher)

    crusher.Model.Parent = nil
end

function CrusherManager.RemoveCrusher(crusher)

end

function CrusherManager.SetAllActive()
    for i, crusher in CrusherManager.InactiveCrushers do
        table.remove(CrusherManager.InactiveCrushers, i)
        table.insert(CrusherManager.ActiveCrushers, crusher)
    end
end

function CrusherManager.SetAllInactive()
    for i, crusher in CrusherManager.ActiveCrushers do
        table.remove(CrusherManager.ActiveCrushers, i)
        table.insert(CrusherManager.InactiveCrushers, crusher)
    end
end

function CrusherManager.DeleteCrusher(crusher)
    local inactiveIndex = table.find(CrusherManager.InactiveCrushers, crusher)
    if inactiveIndex then table.remove(CrusherManager.InactiveCrushersm, inactiveIndex) end

    local activeIndex = table.find(CrusherManager.ActiveCrushers, crusher)
    if activeIndex then table.remove(CrusherManager.ActiveCrushers, activeIndex) end

    crusher:Destroy()
end

--
-- UPDATE FUNCTION
--

function CrusherManager.Update(delta: number, crusher)
    if crusher.REACHED_TARGET == true then
        CrusherManager.DeleteCrusher(crusher)
        return
    else
        crusher:Update(delta)
    end

    local crusherRoot = crusher:GetRootPart()
    local plr_root_parts = workspace:GetPartsInPart(crusherRoot, Config.OVERLAP_PARAMS)
    for _, root in plr_root_parts do
        local char = root.Parent

        local plr = Players:GetPlayerFromCharacter(char)
        if not plr then
            warn("Not a player's character.")
            continue
        end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then
            warn("No humanoid found.")
            continue
        end

        local lastHit = CrusherManager.LastHit["Player_"..plr.UserId]
        local now = os.clock()

        if lastHit and (now - lastHit) < Config.DAMAGE_COOLDOWN then
            continue
        end

        local damage = crusher:GetDamage()

        local args = {
            KnockbackForce = (crusherRoot.CFrame.LookVector+Vector3.new(0, 1, 0))*(damage*root.AssemblyMass),
            RagdollDuration = Config.STUN_DURATION
        }    

        hum:TakeDamage(damage)
        CrusherManager.LastHit["Player_"..plr.UserId] = now
        crushedEvent:FireClient(plr, args)
    end
end

function CrusherManager.UpdateAll(delta: number)
    for _, crusher in CrusherManager.ActiveCrushers do
        CrusherManager.Update(delta, crusher)
    end
end

function CrusherManager.Enable()
    local connection: RBXScriptConnection? = CrusherManager.UpdateConnection
    if connection and connection.Connected == true then warn(Errors.CONNECTION_ALREADY_ACTIVE) return end

    CrusherManager.UpdateConnection = RunService.Heartbeat:Connect(function(delta)
        CrusherManager.UpdateAll(delta)
    end)
end

function CrusherManager.Disable()
    local connection: RBXScriptConnection? = CrusherManager.UpdateConnection
    if not connection or connection.Connected == false then
        warn(Errors.CONNECTION_INVALID)
        CrusherManager.UpdateConnection = nil
        return
    end

    connection:Disconnect()
end

return CrusherManager