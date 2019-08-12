clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=..||RADIUS_OUTER||] minecraft:end_portal_frame
clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=..||RADIUS_OUTER||] minecraft:ender_chest
clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=..||RADIUS_OUTER||] minecraft:obsidian
clear @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=||RADIUS||..||RADIUS_OUTER||]
teleport @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=||RADIUS||..||RADIUS_OUTER||] ||X_POS|| ||Y_POS|| ||Z_POS||
title @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=||WARNING_RADIUS||..||RADIUS||] title "Your leaving the creative zone and will be teleported back if you don't return!"
title @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=||RADIUS_OUTER||..||WARNING_RADIUS_OUTER||] title "Your near the creative zone and will be teleported inside if you don't return!"
title @a[x=||X_POS||,y=||Y_POS||,z=||Z_POS||,distance=||RADIUS_OUTER||..||WARNING_RADIUS_OUTER||] subtitle "After entering the creative zone, your inventory will be cleared and you will be stuck until an admin teleports you!"
execute if entity @a[tag=!cz_enabled] run scoreboard players enable @a[tag=!cz_enabled] cz_enter
execute if entity @a[tag=!cz_enabled] run tag @a[tag=!cz_enabled] add cz_enabled
execute if entity @a[scores={cz_enter=1..}] as @a[scores={cz_enter=1..}] run function cz:enter
execute if entity @a[scores={cz_leave=1..}] as @a[scores={cz_leave=1..}] run function cz:leave