private with Ada.Containers.Indefinite_Vectors;

package Advent_Of_Code.Y2025.Day_7 is
private
   
   -----------------------------------------------------------------------------
   
   type Flag_Array_T is array (Positive range <>) of Boolean;
   
   -----------------------------------------------------------------------------
   
   package Row_Vectors is new Ada.Containers.Indefinite_Vectors
     (Index_Type   => Positive,
      Element_Type => Flag_Array_T);
   
   -----------------------------------------------------------------------------
   
   function Calculate_How_Many_Times_The_Beam_Splits 
     (Beam_Start_Index   : in Positive;
      Splitter_Positions : in Row_Vectors.Vector) 
      return Natural;
   
   -----------------------------------------------------------------------------
   
   function Calculate_How_Many_Timelines_The_Beam_Ends_Up_On 
     (Beam_Start_Index   : in Positive;
      Splitter_Positions : in Row_Vectors.Vector) 
      return Long_Long_Long_Integer;
   
   -----------------------------------------------------------------------------
   
end Advent_Of_Code.Y2025.Day_7;
