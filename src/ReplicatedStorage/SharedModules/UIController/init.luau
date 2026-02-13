local MAIN = script

local Errors = require(MAIN.Errors)

local UIController = {}
UIController.Controllers = {}

function UIController.Init()
    for _, uiModule in MAIN.UIs:GetChildren() do
        local name = uiModule.Name
        if UIController.Controllers[name] then continue end

        local controller = require(uiModule)
        controller.Init()

        UIController.Controllers[name] = controller
    end    
end

function UIController.Render(uiName: string, packet)
    local controller = UIController.Controllers[uiName]
    if not controller then
        warn(Errors.UI_NOT_EXISTS)
        return
    end

    controller.Render(packet)
end

return UIController