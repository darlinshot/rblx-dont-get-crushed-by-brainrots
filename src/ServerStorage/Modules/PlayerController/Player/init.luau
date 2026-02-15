local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local DataController = require(MODULES.DataController)
local ProgressControllers = require(MODULES.ProgressControllers)

local MAIN = script
local Errors = require(MAIN.Errors)

local ROOT = MAIN.Parent
local Character = require(ROOT.Character)

-- / MAIN
local Player = {}
Player.__index = Player

function Player.New(plr: Player)
    local profile = DataController.AddPlayer(plr)
    if not profile then
       print(string.format(Errors.DATA_PROFILE_CREATION_FAILED, plr.Name)) 
       return
    end

    local self = {}
    self.Player = plr
    self.PlayerName = plr.Name
    self.DataProfile = profile
    self.CharacterAddedConnection = plr.CharacterAdded:Connect(Character.OnCharacterAdded)

	-- Cash, Upgrade related data(CurrentStat, NewStat, Cost)
	ProgressControllers.CurrenciesController.RenderAll(plr)

    if plr.Character then
        if not plr.Character:GetAttribute("SetupComplete") == true then
            Character.OnCharacterAdded(plr.Character)
        end
    end

    setmetatable(self, Player)
    return self
end

function Player:Destroy()
    DataController.RemovePlayer(self.Player)

    self.CharacterAddedConnection:Disconnect()
    table.clear(self)
end

return Player