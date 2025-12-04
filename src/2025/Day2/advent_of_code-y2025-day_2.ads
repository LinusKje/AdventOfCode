package Advent_Of_Code.Y2025.Day_2 is
private
   
   -----------------------------------------------------------------------------
   
   type Version_T is 
     (Version_1, 
      Version_2);
   
   -----------------------------------------------------------------------------
   
   function Sum_Of_Invalid_Ids 
     (Range_Start : in Long_Long_Long_Integer; 
      Range_End   : in Long_Long_Long_Integer;
      Version     : in Version_T) 
      return Long_Long_Long_Integer;
   
   -----------------------------------------------------------------------------
   
end Advent_Of_Code.Y2025.Day_2;
