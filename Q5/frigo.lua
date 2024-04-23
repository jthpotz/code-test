-- Custom areas to make the flickering effect of the spell
-- Can be added to spells.lua as new presets if there is a need to reuse them
area1 = {
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 1, 0, 0, 0, 0, 0},
	{1, 0, 2, 0, 0, 0, 1},
	{0, 1, 0, 0, 0, 0, 0},
	{0, 0, 1, 0, 0, 0, 0},
	{0, 0, 0, 1, 0, 0, 0},
}

area2 = {
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 1, 0, 1, 0, 0},
	{0, 0, 0, 0, 0, 1, 0},
	{0, 0, 2, 0, 0, 0, 0},
	{0, 0, 0, 1, 0, 1, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
}

area3 = {
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 3, 0, 1, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 1, 0, 1, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
}

area4 = {
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 2, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0},
}

-- Create the CombatArea for each area
areas = {
    createCombatArea(area1),
    createCombatArea(area2),
    createCombatArea(area3),
    createCombatArea(area4),
}

-- Damage range, can be set to whatever value (note: negative value is damage, positive value is healing)
minDamage = -100
maxDamage = -100

numberOfLoops = 3 -- How many time to loop through the spell pieces.
timeBetweenPieces = 200 -- How long between each piece of the spell to be cast (ms).

-- Cast part of the spell. 
function doSpell(cid, position, count)
    if count < (#areas * numberOfLoops) then -- Check how many times the spell has been looped through.
        doAreaCombat(cid, COMBAT_ICEDAMAGE, position, areas[(count % #areas) + 1], minDamage, maxDamage, CONST_ME_ICETORNADO) -- Need the +1 on the modulo because lua defaults to 1 indexed.
        count = count + 1
        addEvent(doSpell, timeBetweenPieces, cid, position, count) -- Queue the next piece of the spell to get called.
    end
end

function onCastSpell(creature, variant)
    doSpell(creature:getId(), creature:getPosition(), 0) -- Start the spell.
end
