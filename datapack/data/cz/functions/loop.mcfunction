clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=..||RADIUS_OUTER||] minecraft:end_portal_frame
clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=..||RADIUS_OUTER||] minecraft:ender_chest
clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=..||RADIUS_OUTER||] minecraft:obsidian
teleport @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=||RADIUS||..||RADIUS_OUTER||] ||X_POS|| ||Y_POS|| ||Z_POS||
execute if entity @a[tag=!cz_enabled] run scoreboard players enable @a[tag=!cz_enabled] cz_enter
execute if entity @a[tag=!cz_enabled] run tag @a[tag=!cz_enabled] add cz_enabled
execute if entity @a[scores={cz_enter=1..}] as @a[scores={cz_enter=1..}] run function cz:enter
execute if entity @a[scores={cz_leave=1..}] as @a[scores={cz_leave=1..}] run function cz:leave