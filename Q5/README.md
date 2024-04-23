# Q5

There are two versions of the frigo spell. The first version (frigo) attempts to match the example video as closely as possible and will have the same result each time. However, as the spell was only cast once in the example video so it is not entirely clear if it was meant to be fixed or randomized. The second version (frigo_random) creates a similar effect, but will be randomized each time.

spells.xml already exists in the default server implementation so the contents of spells.xml would be added to the existing spells.xml.

frigo.lua and frigo_random.lua are new files that get run when the spell is cast. Both should be placed in the appropriate place for spell files (see spells.xml for additional notes on file placement).

frigo.mp4 demonstrates the fixed version being cast. frigo_random.mp4 demonstrates the randomized version being cast. In each video, the spell is cast four times.

Note: Both versions are slightly offset from the example video; I was unable to center the spell on the character.
