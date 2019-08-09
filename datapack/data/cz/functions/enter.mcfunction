scoreboard players reset @s cz_enter
scoreboard players enable @s cz_enter
# execute if entity @s[tag=!cz,nbt={Inventory:[{id:"minecraft:written_book",tag:{title:"Book of creativity"}}]}] run clear @s[tag=!cz,nbt={Inventory:[{id:"minecraft:written_book",tag:{title:"Book of creativity"}}]}] minecraft:written_book{title:"Book of creativity"}
execute if entity @s[tag=!cz] unless entity @s[nbt={Inventory:[]}] run title @s times 30 100 30
execute if entity @s[tag=!cz] unless entity @s[nbt={Inventory:[]}] run title @s actionbar "To enter the creative zone, you empty your inventory"
execute if entity @s[tag=!cz] unless entity @s[nbt={Inventory:[]}] run title @s reset
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run function cz:st
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run teleport @s[tag=!cz,nbt={Inventory:[]}] ||X_POS|| ||Y_POS|| ||Z_POS||
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run title @s[tag=!cz,nbt={Inventory:[]}] title "Creative Zone"
execute if entity @s[tag=!cz,nbt={Inventory:[]}] run tag @s[tag=!cz,nbt={Inventory:[]}] add cz
execute if entity @s[tag=cz,nbt={Inventory:[]}] run scoreboard players reset @s[tag=cz,nbt={Inventory:[]}] cz_enter
execute if entity @s[tag=cz,nbt={Inventory:[]}] run scoreboard players reset @s[tag=cz,nbt={Inventory:[]}] cz_leave
execute if entity @s[tag=cz,nbt={Inventory:[]}] run scoreboard players enable @s[tag=cz,nbt={Inventory:[]}] cz_leave
gamemode creative @s[tag=cz,nbt={Inventory:[]}]