-- / MODULES
local MAIN = script

local ROOT = MAIN.Parent
local Errors = require(ROOT.Errors)

-- / MAIN
local RenderTypes = {}
RenderTypes.Registry = {}

function RenderTypes.Init()
    for _, renderType in MAIN:GetChildren() do
        if RenderTypes.Registry[renderType.Name] then continue end

        RenderTypes.Registry[renderType.Name] = require(renderType)
    end
end

function RenderTypes.Render(packet)
    local renderType = packet.RenderType
    assert(renderType, Errors.NO_RENDER_TYPE)

    local render = RenderTypes.Registry[renderType]
    if not render then
        warn(string.format(Errors.RENDER_TYPE_NOT_EXISTS, renderType))
        return
    end

    render.Render(packet)

end

return RenderTypes