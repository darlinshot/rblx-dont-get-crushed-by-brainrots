local Errors = require(script.Errors)

local Crusher = {}
Crusher.__index = Crusher

function Crusher.New(model: Model, startPosition: Vector3, goalPosition: Vector3)
    local root = model.PrimaryPart
    if not root then warn(Errors.NO_ROOT_PART) return end

    local speed = model:GetAttribute("Speed")
    local damage = model:GetAttribute("Damage")
    local pushDistance = model:GetAttribute("PushDistance")
    if not speed then warn(string.format(Errors.MISSING_ATTRIBUTE, "Speed")) return end
    if not damage then damage = speed*0.65 end
    if not pushDistance then pushDistance = speed*0.75 end

    local sound = root:FindFirstChild("Sound")

    local self = {}
    self.Name = model.Name

    self.Model = model
    self.Root = root

    self.Speed = speed
    self.PushDistance = pushDistance
    self.Damage = damage
    self.GoalPosition = goalPosition

    if sound then
        self.Sound = sound
    end

    self.ERROR_MARGIN = 0.2
    self.REACHED_TARGET = false

    model:PivotTo(CFrame.new(startPosition))

    setmetatable(self, Crusher)
    return self
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
    return self.Damage
end

function Crusher:GetPushDistance()
    return self.PushDistance
end

function Crusher:PlaySound()
    local sound = self.Sound
    if sound and not sound.Playing then sound:Play() end
end

function Crusher:Destroy()
    local model = self.Model
    
    model:Destroy()

    table.clear(self)
end

return Crusher