void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId) 
{
    bool allocatedPlayer = false; // Add a flag for if memory was allocated for the player.
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        allocatedPlayer = true; // Memory is allocated here
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // We didn't find a player to load, so clean up the player.
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (allocatedPlayer) { // Early return from the function, so if memory was allocated for the player, clean it up.
            delete player;
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (allocatedPlayer) { // End of the function so if memory was allocated for the player, clean it up.
        delete player;
    }
}