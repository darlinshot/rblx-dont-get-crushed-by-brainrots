local RunService = game:GetService("RunService")
local ReplicatedStorage = game.ReplicatedStorage
local ServerStorage = game.ServerStorage

-- / ASSETS
local ASSETS = ServerStorage.Assets
local CRUSHER_MODELS = ASSETS.MODELS.CRUSHERS

-- / MODULES
local MODULES = ReplicatedStorage.Modules

local Crusher = require(MODULES.Crusher)

local MAIN = script
local Errors = require(MAIN.Errors)

-- / MAIN
local CrusherManager = {}
CrusherManager.ActiveCrushers = {}
CrusherManager.InactiveCrushers = {}
CrusherManager.UpdateConnection = nil

function CrusherManager.NewCrusher(model: Model, startPos: Vector3, targetPos: Vector3)
    local crusher = Crusher.New(model, startPos, targetPos)
    
    CrusherManager.SetCrusherActive(crusher)
end

function CrusherManager.SetCrusherActive(crusher)
    local activeIndex = table.find(CrusherManager.ActiveCrushers, crusher) 
    if activeIndex then warn(Errors.CRUSHER_ALREADY_ACTIVE) return end
    
    local inactiveIndex = table.find(CrusherManager.InactiveCrushers, crusher)
    if inactiveIndex then
        table.remove(CrusherManager.ActiveCrushers, inactiveIndex)
    end

    table.insert(CrusherManager.ActiveCrushers, crusher)
end

function CrusherManager.SetCrusherInactive(crusher)
    local inactiveIndex = table.find(CrusherManager.InactiveCrushers, crusher)
    if inactiveIndex then warn(Errors.CRUSHER_ALREADY_INACTIVE) return end

    local activeIndex = table.find(CrusherManager.ActiveCrushers, crusher)
    if activeIndex then table.remove(CrusherManager.ActiveCrushers, activeIndex) end

    table.insert(CrusherManager.InactiveCrushers, crusher)
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

function CrusherManager.Update(delta: number, crusher)
    if crusher.REACHED_TARGET == true then

        crusher:Destroy()
    end
    crusher:Update(delta)
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