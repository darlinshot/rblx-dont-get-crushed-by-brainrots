-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)

-- / MAIN
local BaseEvent = {}
BaseEvent.__index = BaseEvent

function BaseEvent.New(remoteEvent: RemoteEvent)
    local self = {}

    self.EventFunctions = {}

    BaseEvent.Connection = remoteEvent.OnServerEvent:Connect(function(plr, packet)
        for _, func in self.EventFunctions do
            BaseEvent:Activate(func, plr, packet)
        end
    end)

    setmetatable(self, BaseEvent)
    return self
end

function BaseEvent:Activate(func: (any)->any, plr: Player, packet)
    task.defer(function()
        local ok, err = pcall(func, plr, packet)
        if not ok then
            warn("Function failed: ", err)
        end
    end)
end

function BaseEvent:Unload()
    local connection = self.Connection
    if connection and typeof(connection) == "RBXScriptConnection" then 
        connection:Disconnect()
    end
    self.Connection = nil
    connection = nil
end

function BaseEvent:AddFunction(func: ()->any)
    if typeof(func) ~= "function" then
        warn(Errors.NOT_A_FUNCTION)
        return
    end

    if table.find(self.EventFunctions, func) then
        return
    end

    table.insert(self.EventFunctions, func)
end

function BaseEvent:RemoveFunction(func: ()->any)
    local event_functions = self.EventFunctions
    local i = table.find(event_functions, func)
    if not i then warn(Errors.FUNCTION_NOT_EXISTS); return end

    table.remove(event_functions, i) 
end

function BaseEvent:RemoveAllFunctions()
    table.clear(self.EventFunctions)
end

return BaseEvent