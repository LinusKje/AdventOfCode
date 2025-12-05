package body Advent_Of_Code.Y2025.Day_5 is

   -----------------------------------------------------------------------------
   
   function Count_Number_Of_Fresh_Ids 
     (Fresh_Id_Ranges : in Fresh_Id_Ranges_T; 
      Availble_Ids    : in Available_Ids_T) 
      return Long_Long_Long_Integer 
   is
      Result : Long_Long_Long_Integer := 0;
   begin
      for Available_Id of Availble_Ids loop
         for Fresh_Id_Range of Fresh_Id_Ranges loop
            if Available_Id in Fresh_Id_Range.Start .. Fresh_Id_Range.Stop then
               Result := Result + 1;
               exit;
            end if;
         end loop;
      end loop;
      
      return Result;
   end Count_Number_Of_Fresh_Ids;
   
   -----------------------------------------------------------------------------
   
   function Ranges_Overlap 
     (Left  : in Range_T; 
      Right : in Range_T) 
      return Boolean 
   is
      Temp_Start : constant Long_Long_Long_Integer := 
        Long_Long_Long_Integer'Max (Left.Start, Right.Start);
      
      Temp_Stop : constant Long_Long_Long_Integer := 
        Long_Long_Long_Integer'Min (Left.Stop, Right.Stop);
   begin
      return Temp_Stop >= Temp_Start;
   end Ranges_Overlap;
   
   -----------------------------------------------------------------------------
   
   function Merge_Ranges 
     (Left  : in Range_T; 
      Right : in Range_T)
      return Range_T is
   begin
      return Result : Range_T do
         Result.Start := Long_Long_Long_Integer'Min (Left.Start, Right.Start);
         Result.Stop  := Long_Long_Long_Integer'Max (Left.Stop, Right.Stop);
      end return;
   end Merge_Ranges;

   -----------------------------------------------------------------------------
   
   function Count_Number_Of_Fresh_Ids 
     (Fresh_Id_Ranges : in Fresh_Id_Ranges_T) 
      return Long_Long_Long_Integer 
   is
      function Merge_Ranges_Recusive 
        (Ranges : in Fresh_Id_Ranges_T)
         return Fresh_Id_Ranges_T 
      is
         Modifiable_Copy : Fresh_Id_Ranges_T := Ranges;
      begin
         if Ranges'Length = 1 then
            return Ranges;
         end if;
         
         for I in Ranges'First + 1 .. Ranges'Last loop
            if Ranges_Overlap 
              (Left  => Ranges (Ranges'First), 
               Right => Ranges (I)) 
            then
               Modifiable_Copy (I) := Merge_Ranges 
                 (Left  => Ranges (Ranges'First), 
                  Right => Ranges (I));
               
               return Merge_Ranges_Recusive 
                 (Ranges => Modifiable_Copy (Modifiable_Copy'First + 1 .. Modifiable_Copy'Last));
            end if;
         end loop;
         
         return Ranges (Ranges'First) & Merge_Ranges_Recusive 
           (Ranges => Ranges (Ranges'First + 1 .. Ranges'Last));
      end Merge_Ranges_Recusive;
      
      Merged_Ranges : constant Fresh_Id_Ranges_T := Merge_Ranges_Recusive 
        (Ranges => Fresh_Id_Ranges);
      
      Result : Long_Long_Long_Integer := 0;
   begin
      for Fresh_Range of Merged_Ranges loop
         Result := Result + Fresh_Range.Stop - Fresh_Range.Start + 1;
      end loop;
      
      return Result;
   end Count_Number_Of_Fresh_Ids;
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_5;
