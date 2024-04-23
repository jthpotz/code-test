-- Custom area for the spell. Can be added to spells.lua as new presets if there is a need to reuse it.
local customArea = {
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 3, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 0, 0, 0},
}

local effectChance = 30 -- Percent chance that a tile will have the effect happen.
local timeDelay = 200 -- Time between each possible spell flicker.
local totalChances = 12 -- Total times to try a spell flicker for each tile.

-- Damage range, can be set to whatever value (note: negative value is damage, positive value is healing)
local minDamage = -100
local maxDamage = -100

local function spellFlicker(cid, position, count)
	if Creature(cid) then
		if math.random(0, 100) < effectChance then -- Get a random number to see if the spell effect should be applied to the tile.
			doAreaCombat(cid, COMBAT_ICEDAMAGE, position, 0, minDamage, maxDamage, CONST_ME_ICETORNADO) -- If so, do the effect.
		end

		if count < totalChances then -- If the total chances hasn't been reached yet, queue up another flicker chance for the tile.
			count = count + 1
			addEvent(spellFlicker, timeDelay, cid, position, count)
		end
	end
end

-- This gets called with the position being each tile in the combat area.
function perTileCallback(creature, position)
	spellFlicker(creature:getId(), position, 0) -- Call the flicker on each tile.
end

local combat = Combat()
combat:setArea(createCombatArea(customArea))
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "perTileCallback")

function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end
