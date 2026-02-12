--!nocheck

--[[

A global container for all REController, except a few.

Exceptions include REController that run locally in 1
region of the game and does not affect globally.

Children modules include events and functions that
will be activated on event call.

]]--

local ReplicatedStorage = game.ReplicatedStorage

-- / ASSETS
local REMOTES = ReplicatedStorage:WaitForChild("Remotes")
local REMOTE_EVENTS = REMOTES.RemoteEvents

-- / MODULES
local MAIN = script
local BaseEvent = require(MAIN.BaseEvent)
local Types = require(MAIN.Types)
local Errors = require(MAIN.Errors)

export type EventModule = Types.EventModule

-- / MISCS
local eventFunctions = MAIN.EventFunctions

-- / MAIN
local REController = {}
REController.LoadedEvents = {}

function REController.Load(remoteEvent: RemoteEvent)
    if not remoteEvent then return end

    local name = remoteEvent.Name

    local load = REController.LoadedEvents[name]
    if load then
        warn(Errors.RE_ALREADY_LOADED)
        return
    end

    local functionModule = eventFunctions:FindFirstChild(name)
    if not functionModule then
       warn(Errors.FUNCTION_MODULE_NOT_EXISTS)
       return 
    end

    load = BaseEvent.New(remoteEvent)
    local func = require(functionModule)

    load:AddFunction(func)
    REController.LoadedEvents[name] = load
end

function REController.LoadAll()
    REController.UnloadAll()

    for _, functionModule in eventFunctions:GetChildren() do
        local name = functionModule.Name

        local remoteEvent = REMOTE_EVENTS:FindFirstChild(name)
        if not remoteEvent then continue end

        REController.Load(remoteEvent)
    end
end

function REController.Unload(remoteEvent: RemoteEvent)
    if not remoteEvent then return end
    
    local name = remoteEvent.Name

    local events = REController.LoadedEvents
    local load: EventModule = events[remoteEvent]
    if not load then warn(`RemoteEvent {name} has not been loaded.`); return end
    
    load.Unload()

    events[remoteEvent] = nil
end

function REController.UnloadAll()
    local events = REController.LoadedEvents
    for remoteEvent, _ in events do
        REController.Unload(remoteEvent)
    end
end


return REController