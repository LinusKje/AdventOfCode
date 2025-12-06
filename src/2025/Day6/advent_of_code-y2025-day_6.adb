package body Advent_Of_Code.Y2025.Day_6 is

   -----------------------------------------------------------------------------
   
   function Add (A, B : in Long_Long_Long_Integer) return Long_Long_Long_Integer is (A + B);
   function Multiply (A, B : in Long_Long_Long_Integer) return Long_Long_Long_Integer is (A * B);
   type Operation_Access_T is access function (A, B : in Long_Long_Long_Integer) return Long_Long_Long_Integer; 
   
   -----------------------------------------------------------------------------
   
   function Calculate_Sum_Of_Problems 
     (Groups : in Problem_Vectors.Vector) 
      return Long_Long_Long_Integer 
   is
      function Calculate_Group_Sum_Recursive 
        (Number_Vector : in Integer_Vectors.Vector;
         Cursor        : in Integer_Vectors.Cursor; 
         Operation     : in Operation_Access_T)
         return Long_Long_Long_Integer 
      is
         use type Integer_Vectors.Cursor;
         
         Next_Cursor : constant Integer_Vectors.Cursor := 
           Integer_Vectors.Next (Position => Cursor);
      begin
         if Next_Cursor = Integer_Vectors.No_Element then
            return Number_Vector (Cursor);
         end if;
         
         return Operation 
           (A => Number_Vector (Cursor), 
            B => Calculate_Group_Sum_Recursive 
              (Number_Vector => Number_Vector, 
               Cursor        => Next_Cursor, 
               Operation     => Operation));
      end Calculate_Group_Sum_Recursive;
      
      Result : Long_Long_Long_Integer := 0;
   begin
      for Group of Groups loop
         declare
            Operation : Operation_Access_T := 
              (case Group.Operation is
                  when Addition       => Add'Access,
                  when Multiplication => Multiply'Access,
                  when Not_Set        => null);
         begin
            Result := Result + Calculate_Group_Sum_Recursive 
              (Number_Vector => Group.Numbers, 
               Cursor        => Group.Numbers.First, 
               Operation     => Operation);
         end;
      end loop;
      
      return Result;
   end Calculate_Sum_Of_Problems;
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_6;
