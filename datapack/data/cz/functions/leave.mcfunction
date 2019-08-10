execute if entity @s[tag=cz] run clear @s
execute if entity @s[tag=cz,nbt={Inventory:[]}] run title @s title "Survival"
execute if entity @s[tag=cz,nbt={Inventory:[]}] run execute as @s run function cz:tp
execute if entity @s[tag=cz,nbt={Inventory:[]}] run scoreboard players reset @s[tag=cz,nbt={Inventory:[]}] cz_leave
execute if entity @s[tag=cz,nbt={Inventory:[]}] run scoreboard players enable @s[tag=cz,nbt={Inventory:[]}] cz_enter
gamemode survival @s[tag=cz,nbt={Inventory:[]}]
execute if entity @s[tag=cz,nbt={Inventory:[]}] run tag @s remove cz
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run scoreboard players reset @s[tag=cz,nbt={Inventory:[]}] cz_leave
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run scoreboard players reset @s[tag=cz,nbt={Inventory:[]}] cz_enter
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run scoreboard players enable @s[tag=cz,nbt={Inventory:[]}] cz_enter
# execute if entity @s[tag=!cz,nbt={Inventory:[]}] run function cz:give_book