package Advent_Of_Code.Y2025.Day_5 is
private
   
   -----------------------------------------------------------------------------
   
   type Range_T is record
      Start : Long_Long_Long_Integer;
      Stop  : Long_Long_Long_Integer;
   end record;
   
   -----------------------------------------------------------------------------
   
   type Fresh_Id_Ranges_T is array (Positive range <>) of Range_T;
   
   -----------------------------------------------------------------------------
   
   type Available_Ids_T is array (Positive range <>) of Long_Long_Long_Integer;
   
   -----------------------------------------------------------------------------
   
   function Count_Number_Of_Fresh_Ids 
     (Fresh_Id_Ranges : in Fresh_Id_Ranges_T; 
      Availble_Ids    : in Available_Ids_T) 
      return Long_Long_Long_Integer;
   
   -----------------------------------------------------------------------------
   
   function Count_Number_Of_Fresh_Ids 
     (Fresh_Id_Ranges : in Fresh_Id_Ranges_T) 
      return Long_Long_Long_Integer;
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_5;
