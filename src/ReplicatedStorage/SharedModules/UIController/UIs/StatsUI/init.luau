local MarketplaceService = game:GetService("MarketplaceService")

-- / MODULES
local MAIN = script
local RenderTypes = require(MAIN.RenderTypes)

-- / MAIN
local UI = {}
UI.Connections = {}

function UI.Init()
    RenderTypes.Init()
end

function UI.Render(packet)
    RenderTypes.Render(packet)
end

return UI