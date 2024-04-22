function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"

    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    if not resultId then -- If storeQuery returns false, then there was an error executing the query
        error("There was an error executing the query.")
        return
    end

    local guildName = result.getString(resultId, "name") -- result.getString takes two paramaters, first the id of the result to search in, second the name of the column to search for.
    if not guildName then -- If getString returns false, the result no longer exists.
        error("There is no longer a result for resultID %d", resultId)
        return
    end

    if guildName == '' then
        print(string.format("No guilds with fewer than %d max members found.", memberCount))
    else
        print(guildName)
    end
end