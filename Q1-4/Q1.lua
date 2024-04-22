local function releaseStorage(player, storageKey) -- Added a paramater for the storage key so the function can be reused elsewhere.
    player:setStorageValue(storageKey, -1)
end


function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        -- If there is a valid reason to delay releasing the storage, then the following can be used.
        -- addEvent(releaseStorage, 1000, player, 1000) -- The first 1000 is the delay before the function is called while the second is the storage key to be released.
        releaseStorage(player, 1000) -- If there is no reason to delay, release the storage immediately
        --[[ Assuming the below changes are made to PlayerStorageKeys in storages.lua, then these could be rewritten follows:
        addEvent(releaseStorage, 1000, player, PlayerStorageKeys.myStorageKey) -- With a delay.
        releaseStorage(player, PlayerStorageKeys.myStorageKey) -- Without a delay.
        --]]
    end
    return true
end

--[[
Add the storage key to PlayerStorageKeys in storages.lua.
This would be done by adding the line:
    myStorageKey = 1000,
to the other storage keys defined (using an appropriate name for how the storage key is used).
--]]