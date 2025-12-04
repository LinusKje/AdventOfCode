with Ada.Containers.Vectors;
with Ada.Text_IO;

package body Advent_Of_Code.Y2025.Day_3 is

   -----------------------------------------------------------------------------
   
   package Index_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Positive);
   
   -----------------------------------------------------------------------------
   
   subtype Joltage_Rating_T is Long_Long_Long_Integer range 1 .. 9;
   
   -----------------------------------------------------------------------------
   
   type Index_Cache_Map_T is array (Joltage_Rating_T) of Index_Vectors.Vector;
   
   -----------------------------------------------------------------------------
   
   function As_Joltage 
     (Value : in Character) 
      return Joltage_Rating_T 
   is (Character'Pos (Value) - Character'Pos ('0'));
   
   -----------------------------------------------------------------------------
   
   function Convert_To_Cache_Map 
     (Battery_Bank : in String) 
      return Index_Cache_Map_T is
   begin
      return Result : Index_Cache_Map_T do
         for I in Battery_Bank'Range loop
            Result (As_Joltage (Battery_Bank (I))).Append
              (New_Item => I);
         end loop;
      end return;
   end Convert_To_Cache_Map;
   
   -----------------------------------------------------------------------------
   
   function Calculate_Largest_Possible_Joltage 
     (Battery_Bank                   : in String; 
      Number_Of_Batteries_To_Turn_On : in Positive) 
      return Long_Long_Long_Integer 
   is
      Cache_Map : constant Index_Cache_Map_T := Convert_To_Cache_Map 
        (Battery_Bank => Battery_Bank);
      
      function Find_Largest_Joltage_Recursive 
        (Current_Index             : in Positive;
         Batteries_Left_To_Turn_On : in Natural;
         Current_Joltage           : in Long_Long_Long_Integer) 
         return Long_Long_Long_Integer is
      begin
         if Batteries_Left_To_Turn_On = 0 then
            return Current_Joltage;
         end if;
         
         for Joltage_Rating in reverse Cache_Map'Range loop
            for Index of Cache_Map (Joltage_Rating) loop
               if (Battery_Bank'Last - Index + 1) >= Batteries_Left_To_Turn_On and then Index >= Current_Index then
                  return Find_Largest_Joltage_Recursive 
                    (Current_Index             => Index + 1,
                     Batteries_Left_To_Turn_On => Batteries_Left_To_Turn_On - 1,
                     Current_Joltage           => Current_Joltage * 10 + Joltage_Rating);
               end if;
            end loop;
         end loop;

         return Current_Joltage;
      end Find_Largest_Joltage_Recursive;
   begin
      return Find_Largest_Joltage_Recursive 
        (Current_Index             => Battery_Bank'First,
         Batteries_Left_To_Turn_On => Number_Of_Batteries_To_Turn_On,
         Current_Joltage           => 0);
   end Calculate_Largest_Possible_Joltage;
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_3;
