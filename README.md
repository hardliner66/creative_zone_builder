# Creative Zone Builder
A small tool to generate a datapack, which creates a creative zone in minecraft.

## Datapack Features
### General
- Creates a zone at the given coordinates in which creative mode is enabled.
- Provides commands to enter and leave the creative zone
- Remembers the position of the player, so they will return to the exact position they were, when they entered

### Anti-cheating measures
- Entering is only possible if the player has nothing in his inventory
- The inventory of the player gets cleared, when he leaves the zone
- The creative zone is surrounded by a teleport zone, which teleports the player back if he tries to escape (after a warning is shown)
- The player inventory gets cleared of obsidian, ender_chests and end_portal_frame while inside the creative or teleport zone so they can't portal out

### Currently unsolved problems
If the player hits the teleport zone from the outside, he gets teleported inside the creative zone.
This means that any player who gets to close to the zone, will be stuck until an admin teleports him back.

Sadly I found no easy way to secure the zone from entering from the outside,
so it's advised create the zone somewhere near the world border

e.g:
```
creative_zone_builder 29999250 127 0
```

_The travel time from x = 0 to x = 29999250 is approximately 89092 minutes (or 61 days) when sprinting in a straight line._

If a player __still__ manages to wrongly get into the zone, the admin should clear his inventory before teleporting him out of the zone.

## Command Line Options
```
Creative Zone Builder 1.1.0
Create a custom datapack for a creative zone in minecraft.

USAGE:
    creative_zone_builder.exe [OPTIONS] <x> <y> <z>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -r, --radius <r>                  The radius of the creative zone [default: 300]
    -t, --teleport-zone-width <tz>    The width of the teleport zone [default: 100]
    -w, --warning-zone-width <wz>     The width of the warning zone [default: 5]

ARGS:
    <x>    The x position of the creative zone.
    <y>    The y position of the creative zone.
    <z>    The z position of the creative zone.
```

## Example
### Creating the zone at X: 29999250, Z:0

Teleport to the coordinates to find out the best Z coordinate:
```
/tp 29999250 127 0
```

If you have chosen a Z coordinate (I will use z = 74 in this example), you can create the datapack with the following comand:
```
creative_zone_builder 29999250 74 0
```

This will create a creative_zone.zip file. Upload this zip into your datapacks folder and load it ingame with:
```
/reload
```

## Usage inside of Minecraft
To enter the creative zone, the player needs to type:
```
/trigger cz_enter
```

To leave the creative zone, the player needs to type:
```
/trigger cz_leave
```

## Troubleshooting
If a player can't access the cz_enter trigger, you can remove cz_enabled tag from him:
```
/tag <PlayerName> remove cz_enabled
```

The datapack should then automatically re-assign the tag and enable the trigger command