local Debris = game:GetService("Debris")
-- / MODULES
local MAIN = script
local Errors = require(MAIN.Errors)
local Config = require(MAIN.Config)

local ROOT = MAIN.Parent.Parent
local Objects = require(ROOT.Objects)

-- / UI
local container = Objects.GetContainer()

-- / MAIN
local Render = {}

function Render.Render(packet)
    local info = packet.Data
    local msg = info.Message
    if not msg then
        warn(Errors.NO_MESSAGE_PROVIDED)
        return
    end
    local textColor = info.TextColor
    local strokeColor = info.StrokeColor
    local duration = info.Duration

    if not textColor then textColor = Config.BASE_TEXT_COLOR end
    if not strokeColor then strokeColor = Config.BASE_STROKE_COLOR end
    if not duration then duration = Config.BASE_DURATION end

    local newNotif = Objects.GetNewNotification()
    local notifText = newNotif:WaitForChild("NotificationText")

    notifText.Text = msg
    notifText.TextColor3 = textColor
    notifText.TextStroke.Color = strokeColor
    
    newNotif.Visible = true

    newNotif.Parent = container
    Debris:AddItem(newNotif)
end

return Render