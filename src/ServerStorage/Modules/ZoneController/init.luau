local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MAIN = script

local Zone = require(MAIN.Zone)
local Errors = require(MAIN.Errors)

-- / MISCS 
local ZONE_FUNCTIONS = MAIN.ZoneFunctions

-- / MAIN
local ZoneController = {}
ZoneController.Zones = {}

function ZoneController.AddZone(zonePart: Part)
    local zone = ZoneController.Zones[zonePart]
    if zone then
        warn(string.format(Errors.ZONE_EXISTS, zonePart.Name))
        return
    end

    local zoneFunctionModule = ZONE_FUNCTIONS:FindFirstChild(zonePart.Name)
    if not zoneFunctionModule then
        warn(Errors.ZONE_FUNCTION_MODULE_NOT_EIXSTS)
        return
    end

    local zone_functions = require(zoneFunctionModule)

    zone = Zone.new(zonePart)
    if zone_functions.OnPlayerEntered then
        zone.playerEntered:Connect(zone_functions.OnPlayerEntered)
    end
    if zone_functions.OnPlayerExit then
        zone.playerExited:Connect(zone_functions.OnPlayerExit)
    end

    ZoneController.Zones[zonePart] = zone
    return zone
end

function ZoneController.RemoveZone()
    
end

return ZoneController   