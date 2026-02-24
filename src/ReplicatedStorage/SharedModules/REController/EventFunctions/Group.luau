local GroupService = game:GetService("GroupService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / MODULES
local SHARED_MODULES = ReplicatedStorage.SharedModules
local IDs = require(SHARED_MODULES.IDs)

-- / MAIN
return function (packet)
    local groupID = packet.GroupID
    if not groupID then groupID = IDs.GROUP_ID end

    GroupService:PromptJoinAsync(groupID)
end