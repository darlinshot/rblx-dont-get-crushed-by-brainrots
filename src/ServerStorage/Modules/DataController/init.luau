local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local ProfileStore = require(MODULES.ProfileStore)

local MAIN = script
local Config = require(MAIN.Config)
local Errors = require(MAIN.Errors)

-- / SETUP
local PlayerStore = ProfileStore.New("PlayerStore", Config.DATA_TEMPLATE)

-- / MODULE
local DataController = {}
DataController.PlayerData = {} -- Live data
DataController.DataProfiles = {} -- Saved data

function DataController.AddPlayer(plr: Player)
    local profile = DataController.DataProfiles["Player_"..plr.UserId]

    if not profile then
        profile = PlayerStore:StartSessionAsync(`{plr.UserId}`, {
            Cancel = function()
                return plr.Parent ~= Players
            end,
        })
    end
    
    if profile then
        profile:AddUserId(plr.UserId)
        profile:Reconcile()
        
        -- Player left before profile could load
        if plr.Parent ~= Players then
            profile:EndSession()
            return
        end

        print(string.format(Errors.LOAD_PROFILE_SUCCESS, plr.Name))
        
        DataController.DataProfiles["Player_"..plr.UserId] = profile
        
        -- This data is for live game editing.
        DataController.PlayerData["Player_"..plr.UserId] = profile.Data

        return profile
    else
        -- Roblox server shutting down
        plr:Kick(Errors.LOAD_PROFILE_FAILED)
        error(Errors.LOAD_PROFILE_FAILED)
    end
end

function DataController.RemovePlayer(plr: Player)
    local profile = DataController.DataProfiles["Player_"..plr.UserId]
    if profile then
        profile:EndSession()

        DataController.DataProfiles["Player_"..plr.UserId] = nil
    end

    local data = DataController.PlayerData["Player_"..plr.UserId]
    if data then
        DataController.PlayerData["Player_"..plr.UserId] = nil
    end
end

function DataController.GetPlayerProfile(plr: Player)
    local profile = DataController.DataProfiles["Player_"..plr.UserId]
    if not profile then
        return DataController.AddPlayer(plr)
    end

    return profile
end

function DataController.GetPlayerData(plr: Player)
    local profile = DataController.DataProfiles["Player_"..plr.UserId]
    if not profile then
        profile = DataController.AddPlayer(plr)
        if not profile then
            plr:Kick(Errors.LOAD_PROFILE_FAILED)
            error(Errors.LOAD_PROFILE_FAILED)
        end
    end

    return profile.Data
end

return DataController