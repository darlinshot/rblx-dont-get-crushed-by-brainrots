
local MAIN = script
local MAIN_PARENT = MAIN.Parent

local Character = require(MAIN_PARENT.Character)

-- / MAIN
local Player = {}
Player.__index = Player

function Player.New(plr: Player)
    local self = {}

    self.CharacterAddedConnection = plr.CharacterAdded:Connect(Character.CharacterAdded)
    
    setmetatable(self, Player)
    return self
end

function Player:Destroy()
    self.CharacterAddedConnection:Disconnect()

end

return Player