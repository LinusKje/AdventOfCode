with Ada.Strings.Fixed;

package body Advent_Of_Code.Y2025.Day_2 is

   -----------------------------------------------------------------------------
   
   function Contains_Invalid_Id_Part_1 
     (Value : in String) 
      return Boolean is
   begin
      return (Value'Length mod 2) = 0 
        and then Value (Value'First .. Value'Length / 2) = Value (Value'Length / 2 + 1 .. Value'Last);
   end Contains_Invalid_Id_Part_1;
   
   -----------------------------------------------------------------------------
   
   function Contains_Invalid_Id_Part_2
     (Value : in String) 
      return Boolean 
   is
      function Contains_Invalid_Sequence_Recursive 
        (Sequence        : in String; 
         String_To_Check : in String) 
         return Boolean is
      begin
         if String_To_Check'Length = 0 then
            return True;
         end if;

         if not (Sequence = String_To_Check (String_To_Check'First .. String_To_Check'First + Sequence'Length - 1)) then
            return False;
         end if;
            
         return Contains_Invalid_Sequence_Recursive 
           (Sequence        => Sequence, 
            String_To_Check => String_To_Check (String_To_Check'First + Sequence'Length .. String_To_Check'Last));
      end Contains_Invalid_Sequence_Recursive;
   begin
      for I in 1 .. Value'Length / 2 loop
         if (Value'Length mod I) = 0 then
            if Contains_Invalid_Sequence_Recursive 
              (Sequence        => Value (Value'First .. Value'First + I - 1),
               String_To_Check => Value (Value'First + I .. Value'Last))
            then
               return True;
            end if;
         end if;
      end loop;
         
      return False;
   end Contains_Invalid_Id_Part_2;
   
   -----------------------------------------------------------------------------
   
   function Sum_Of_Invalid_Ids 
     (Range_Start : in Long_Long_Long_Integer; 
      Range_End   : in Long_Long_Long_Integer;
      Version     : in Version_T) 
      return Long_Long_Long_Integer 
   is
      Total_Sum : Long_Long_Long_Integer := 0;
   begin
      for I in Range_Start .. Range_End loop
         declare
            Value : constant String := Ada.Strings.Fixed.Trim 
              (Source => Long_Long_Long_Integer'Image (I), 
               Side   => Ada.Strings.Both);
            
            Contains_Bad_Id : constant Boolean := 
              (case Version is
                  when Version_1 => Contains_Invalid_Id_Part_1 (Value),
                  when Version_2 => Contains_Invalid_Id_Part_2 (Value));
         begin
            if Contains_Bad_Id then
               Total_Sum := Total_Sum + I;
            end if;
         end;
      end loop;
      
      return Total_Sum;
   end Sum_Of_Invalid_Ids;
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_2;
