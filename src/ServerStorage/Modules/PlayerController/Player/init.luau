local ServerStorage = game:GetService("ServerStorage")


-- / MODULES
local MODULES = ServerStorage.Modules
local DataManager = require(MODULES.DataManager)

local MAIN = script
local Errors = require(MAIN.Errors)

local MAIN_PARENT = MAIN.Parent
local Character = require(MAIN_PARENT.Character)

-- / MAIN
local Player = {}
Player.__index = Player

function Player.New(plr: Player)
    local profile = DataManager.AddPlayer(plr)
    if not profile then
       print(Errors.DATA_PROFILE_CREATION_FAILED) 
       return
    end

    local self = {}
    self.DataProfile = profile
    self.CharacterAddedConnection = plr.CharacterAdded:Connect(Character.OnCharacterAdded)

    if plr.Character then
        if not plr.Character:GetAttribute("SetupComplete") == true then
            Character.OnCharacterAdded(plr.Character)
        end
    end

    setmetatable(self, Player)
    return self
end

function Player:Destroy()
    self.DataProfile = nil
    self.CharacterAddedConnection:Disconnect()
end

return Player