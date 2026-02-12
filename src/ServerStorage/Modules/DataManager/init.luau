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
local DataManager = {}
DataManager.PlayerData = {} -- Live data
DataManager.DataProfiles = {} -- Saved data

function DataManager.AddPlayer(plr: Player)
    local profile = DataManager.DataProfiles["Player_"..plr.UserId]

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

        -- This data is for live game editing.
        DataManager.PlayerData["Player_"..plr.UserId] = profile.Data

        return profile
    else
        -- Roblox server shutting down
        warn(Errors.LOAD_PROFILE_FAILED)
        plr:Kick(Errors.LOAD_PROFILE_FAILED)
    end
end

function DataManager.RemovePlayer(plr: Player)
    local profile = DataManager.DataProfiles["Player_"..plr.UserId]
    if profile then
        profile:EndSession()

        DataManager.DataProfiles["Player_"..plr.UserId] = nil
    end

    local data = DataManager.PlayerData["Player_"..plr.UserId]
    if data then
        DataManager.PlayerData["Player_"..plr.UserId] = nil 
    end
end

function DataManager.GetPlayerProfile(plr: Player)
    local profile = DataManager.DataProfiles["Player_"..plr.UserId]
    if not profile then
        return DataManager.AddPlayer(plr)
    end

    return profile
end

function DataManager.GetPlayerData(plr: Player)
    local profile = DataManager.DataProfiles["Player_"..plr.UserId]
    if not profile then
        profile = DataManager.AddPlayer(plr)
        if not profile then
            warn(Errors.LOAD_PROFILE_FAILED)
            plr:Kick(Errors.LOAD_PROFILE_FAILED)
        end
    end

    return profile.Data
end

return DataManager