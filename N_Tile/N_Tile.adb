----------------------------------------
--
-- Handler for N tile data
--
-- See /doc/mapformat.rtf for more info
----------------------------------------

package body N_Tile is
   -- Converts a human-readable (x, y) coord to tile offset
   function Coord_To_Offset(X : Tile_Width;
                            Y : Tile_Height)
                            return Tile_Offset is
   begin

      return (X * MAX_TILE_HEIGHT) + (MAX_TILE_WIDTH - Y);

   end Coord_To_Offset;

   -- Gets X value of a tile offset
   function Offset_X(Offset : Tile_Offset)
                     return Tile_Width is
   begin
      return Offset / MAX_TILE_HEIGHT;
   end Offset_X;

   -- Gets Y value of a tile offset
   function Offset_Y(Offset : Tile_Offset)
                     return Tile_Height is
   begin
      return MAX_TILE_HEIGHT - (Offset rem MAX_TILE_HEIGHT);
   end Offset_Y;

   -- Returns if a tile is of base+OID format
   function Is_Rotatable(Tile : Serialized_Tile)
                         return Boolean is
   begin
      return Tile > '2' and Tile < 'N';

   end Is_Rotatable;

   -- Returns the OID of a tile, INVALID_TILE_ORIENTATION if not orientable
   function Get_Orientation(Tile : Serialized_Tile)
                            return Tile_Orientation is
      Orientation : Tile_Orientation;
   begin
      if not Is_Rotatable(Tile) then
         return INVALID_TILE_ORIENTATION;
      end if;
      -- Otherwise OID is lower two bits
      return Tile and 3;
   end Get_Orientation;

   -- Returns the base+Orientation of a tile, or the tile if it is not
   -- orientable
   function Set_Orientation(Tile : Serialzed_Tile;
                            Orientation : Tile_Orientation)
                             return Serialzed_Tile is
   begin
      if not Is_Rotatable(Tile) then
         return Tile;
      end if;

      return (Tile and (not 3)) + Orientation;
   end Set_Orientation;


end N_Tile;
