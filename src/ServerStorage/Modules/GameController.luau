local GameController = {}
GameController.Running = false
GameController.Thread = nil

function GameController:StartGame()
    if GameController.Running == true then return end

    GameController.Running = true

    
end

return GameController