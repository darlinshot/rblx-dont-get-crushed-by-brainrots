local Errors = require(script.Errors)

local Crusher = {}

function Crusher.New(model: Model, speed: number, targetPosition: Vector3)
    local root = model.PrimaryPart
    if not root then warn(Errors.NO_ROOT_PART) return end

    local self = {}
    self.Name = model.Name

    self.Model = model
    self.Root = root

    self.Speed = speed
    self.Force = Crusher.CalculateForce(speed, 1)
    self.TargetPosition = targetPosition

    setmetatable(self, Crusher)
    return self
end

function Crusher.CalculateForce(speed: number, k: number)
    if not k then k = 1 end
    return k * (speed^1.3)
end

function Crusher:Update(delta: number)
    local model: Model = self.Model
    local root: BasePart = self.Root

    local speed = self.Speed
    local currentCF = root.CFrame

    model:PivotTo(currentCF * root.CFrame.LookVector*speed*delta)
end

function Crusher:Destroy()
    local model = self.Model
    
    model:Destroy()

    table.clear(self)
end

return Crusher