local ServerStorage = game:GetService("ServerStorage")

-- / MODULES
local MODULES = ServerStorage.Modules
local Zone = require(MODULES.Zone)

local MAIN = script
local ROOT = MAIN.Parent

-- / MAIN
local ZoneContainer = {}

function ZoneContainer.New(container: BasePart)
    local self = {}
    local zone = Zone.new(container)

    

    setmetatable(self, ZoneContainer)
    return self
end

return ZoneContainer