-- Renamed the function to reflect what it does
function removeMemberFromPlayerParty(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()

    -- Check if membername is actually a player.
    local member = Player(membername)
    if not member then
        return --If membername is not a player, no need to check the party.
    end

    for k,v in pairs(party:getMembers()) do
        if v == member then
            party:removeMember(member)
            return -- If the member has been found in the party, no need to check the rest of the party.
        end
    end
end