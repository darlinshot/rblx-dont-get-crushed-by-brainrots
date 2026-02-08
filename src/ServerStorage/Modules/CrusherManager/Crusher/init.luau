local Errors = require(script.Errors)

local Crusher = {}
Crusher.__index = Crusher

function Crusher.New(model: Model, startPosition: Vector3, goalPosition: Vector3)
    local root = model.PrimaryPart
    if not root then warn(Errors.NO_ROOT_PART) return end

    local speed = model:GetAttribute("Speed")
    if not speed then warn(string.format(Errors.MISSING_ATTRIBUTE, "Speed")) return end

    local self = {}
    self.Name = model.Name

    self.Model = model
    self.Root = root

    self.Speed = speed
    self.Force = Crusher.CalculateForce(speed, 1)
    self.GoalPosition = goalPosition

    self.ERROR_MARGIN = 0.2
    self.REACHED_TARGET = false

    model:PivotTo(CFrame.new(startPosition))

    setmetatable(self, Crusher)
    return self
end

function Crusher.CalculateForce(speed: number, k: number)
    if not k then k = 1 end
    return k * (speed^1.3)
end

function Crusher:Update(delta: number)
    local root = self.Root
    local model = self.Model

    local currentPos = root.Position
    local goalPos = self.GoalPosition

    local toTarget = goalPos - currentPos

    -- Finished moving
    local distance = toTarget.Magnitude
    if distance <= self.ERROR_MARGIN then
        self.REACHED_TARGET = true
        return
    end

    -- Moving
    local direction = toTarget.Unit
    local moveDistance = math.min(self.Speed * delta, distance)

    local newPosition = currentPos + direction * moveDistance

    model:PivotTo(CFrame.new(newPosition, newPosition + direction))
end

function Crusher:GetRootPart()
    return self.Root
end

function Crusher:GetDamage()
    -- Speed = damage
    -- Change if you want
    
    return self.Speed
end

function Crusher:Destroy()
    local model = self.Model
    
    model:Destroy()

    table.clear(self)
end

return Crusher