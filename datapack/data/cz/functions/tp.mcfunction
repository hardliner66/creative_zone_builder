summon minecraft:area_effect_cloud ~ ~ ~ {Duration:2000,Radius:1,Tags:["tp_cloud"]}
scoreboard players operation @e[tag=tp_cloud,limit=1,distance=..1] pos0 = @s pos0
scoreboard players operation @e[tag=tp_cloud,limit=1,distance=..1] pos1 = @s pos1
scoreboard players operation @e[tag=tp_cloud,limit=1,distance=..1] pos2 = @s pos2
tag @e[tag=tp_cloud,limit=1,distance=..1] add tp_moving
tag @e[tag=tp_moving,limit=1,distance=..1] remove tp_cloud
execute as @e[tag=tp_moving] store result entity @s Pos[0] double 0.01 run scoreboard players get @s pos0
execute as @e[tag=tp_moving] store result entity @s Pos[1] double 0.01 run scoreboard players get @s pos1
execute as @e[tag=tp_moving] store result entity @s Pos[2] double 0.01 run scoreboard players get @s pos2
tag @e[tag=tp_moving] add tp_ready
tag @e[tag=tp_ready,limit=1,distance=..1] remove tp_moving
teleport @p[limit=1] @e[tag=tp_ready,limit=1]
kill @e[tag=tp_ready]