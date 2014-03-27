----------------------------------------
--
-- Handler for N tile data
--
-- See /doc/mapformat.rtf for more info
----------------------------------------

package N_Tile is

   MAX_TILE_WIDTH : constant := 31;
   MAX_TILE_HEIGHT : constant := 23;

   -- 0-indexed values because conversion to 1 based was annoying and
   -- introduced potential errors

   -- Cartesian (standard) style coordinates
   subtype Tile_Width is Natural range 0 .. MAX_TILE_WIDTH - 1;
   subtype Tile_Height is Natural range 0 .. MAX_TILE_HEIGHT - 1;

   -- N map data style
   subtype Tile_Offset is Natural range 0 .. MAX_TILE_WIDTH*MAX_TILE_HEIGHT - 1;

   -- Subtype to allow "glitched" tiles can be implemented later point
   type Serialized_Tile is new Character range '0' .. 'Q'
      with Default_Value => '0';

   -- Orientation ID (see /doc/mapformat.rtf)
   -- To convert to quadrant add 1
   subtype Tile_Orientation is Integer range -1 .. 3;
   -- If a tile cannot be rotated, Orientation = INVALID_TILE
   INVALID_TILE_ORIENTATION : constant Tile_Orientation := -1;

   -- aliased? why not
   type Tile_Map is array(Tile_Offset) of aliased Serialized_Tile;

   -- Converts a human-readable (x, y) coord to tile offset
   function Coord_To_Offset(X : Tile_Width;
                            Y : Tile_Height)
                            return Tile_Offset;

   -- Gets X value of a tile offset
   function Offset_X(Offset : Tile_Offset)
                     return Tile_Width;

   -- Gets Y value of a tile offset
   function Offset_Y(Offset : Tile_Offset)
                     return Tile_Height;

   -- Returns if a tile is of base+OID format
   function Is_Rotatable(Tile : Serialized_Tile)
                         return Boolean;

   -- Returns the OID of a tile, INVALID_TILE_ORIENTATION if not orientable
   function Get_Orientation(Tile : Serialized_Tile)
                            return Tile_Orientation;

   -- Returns the base+Orientation of a tile, or the tile if it is not
   -- orientable
   function Set_Orientation(Tile : Serialized_Tile;
                            Orientation : Tile_Orientation)
                            return Serialized_Tile;
end N_Tile;
