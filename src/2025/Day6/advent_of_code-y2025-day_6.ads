private with Ada.Containers.Vectors;

package Advent_Of_Code.Y2025.Day_6 is
private
   
   -----------------------------------------------------------------------------
   
   type Operation_T is 
     (Not_Set,
      Addition, 
      Multiplication);
   
   -----------------------------------------------------------------------------
   
   package Integer_Vectors is new Ada.Containers.Vectors 
     (Index_Type   => Positive, 
      Element_Type => Long_Long_Long_Integer);
   
   -----------------------------------------------------------------------------
   
   type Problem_T is record
      Numbers   : Integer_Vectors.Vector;
      Operation : Operation_T;
   end record;
   
   -----------------------------------------------------------------------------
   
   package Problem_Vectors is new Ada.Containers.Vectors 
     (Index_Type   => Positive, 
      Element_Type => Problem_T);
   
   -----------------------------------------------------------------------------
   
   function Calculate_Sum_Of_Problems 
     (Groups : in Problem_Vectors.Vector) 
      return Long_Long_Long_Integer;
   
   -----------------------------------------------------------------------------
   -- Helpers for input reading ------------------------------------------------
   -----------------------------------------------------------------------------
   
   function As_Digit 
     (V : in Character) 
      return Long_Long_Long_Integer 
   is (Character'Pos (V) - Character'Pos ('0'));
   
   -----------------------------------------------------------------------------
   
   package String_Index_Vectors is new Ada.Containers.Vectors 
     (Index_Type   => Positive, 
      Element_Type => Positive);
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_6;
