N v1.4 map format:
==================

Tiles:
------

ID: Character that is shown in map data.
NEditor ID (NID): Key that tile is referenced by (1-8, e, d)
Orientation ID (OID): Orientation it is facing. See Figure 1.
Reference angle: Angle that 1st quadrant (OID(0)) tile faces

***

### Figure 1: Orientations:

| OID  |  Quadrant  |  Nedtitor key  |
|:--:|:--------:|:-----------:|
| 0 | 1 | w |
| 1 | 2 | q |
| 2 | 3 | a |
| 3 | 4 | s |

***

### Figure 2: Tile data

| ID  | NEditor ID | Reference Angle | Notes | 
|:---:|:----------:|:---------------:|:-----:|
| "0" | d | n/a | empty | 
| "1" | e | n/a | solid | 
| "2"+OID | 1 | 45 | 
| "6"+OID | 4 | n/a | inverted elliptical | 
| ";"+OID | 8 | n/a | elliptical | 
| ">"+OID | 3 | 30 | half tile | 
| "B"+OID | 7 | 30 | combines NID(3) with half tile | 
| "F"+OID | 2 | 60 | half tile | 
| "J"+OID | 6 | 60 | combines NID(2) + half tile | 
| "N" | 5 | n/a | bottom | 
| "O" |  | n/a | right | 
| "P" |  | n/a | top | 
| "Q" |  | n/a | left | 

***

I don't completely understand M&R's reason for this mapping ("0" - "Q" ascii). The only pattern I see is that "2" - "M" are all ID+OID, and "N"-"Q" is oriented counter-clockwise starting from the bottom half. Maybe it was just convenient. I'm sure that there are bitmasks here that would explain "glitch" tiles, but I'll find them later. Source release pls

If tile is orientable, the lowest two bits are the tile orientation.

***
### Tile Constants:

```Ada
MAX_TILE_WIDTH : constant := 31;
MAX_TILE_HEIGHT : constant := 23;
```

***
### Map data serialization:

Tiles are stored in downwards order vertical rows starting from the upper left corner. To convert between a cartesian (x, y) point to an offset, the following function is used:

```Ada
Offset := (X * MAX_TILE_HEIGHT) + (MAX_TILE_WIDTH - Y);
```

... and retrieving X and Y values from an offset:

```Ada
X := Offset / MAX_TILE_HEIGHT;
Y := MAX_TILE_HEIGHT - (Offset rem MAX_TILE_HEIGHT)
```