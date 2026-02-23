local GroupService = game:GetService("GroupService")

local DEFAULT_GROUP_ID = 1078990756

-- / MAIN
return function (packet)
    local groupID = packet.GroupID
    if not groupID then groupID = DEFAULT_GROUP_ID end

    GroupService:PromptJoinAsync(groupID)
end