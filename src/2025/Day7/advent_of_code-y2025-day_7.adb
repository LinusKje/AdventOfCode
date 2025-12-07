with Ada.Text_IO;

package body Advent_Of_Code.Y2025.Day_7 is

   -----------------------------------------------------------------------------
   
   function Calculate_How_Many_Times_The_Beam_Splits 
     (Beam_Start_Index   : in Positive;
      Splitter_Positions : in Row_Vectors.Vector) 
      return Natural 
   is
      function Calculate_Beam_Split_Recusive 
        (Times_Beam_Split   : in Natural;
         Beam_Positions     : in Flag_Array_T; 
         Splitter_Positions : in Row_Vectors.Vector)
         return Natural 
      is
         use type Ada.Containers.Count_Type;
      begin
         if Splitter_Positions.Length = 0 then
            return Times_Beam_Split;
         end if;
         
         declare
            Modifieable_Splitter_Positions : Row_Vectors.Vector := 
              Splitter_Positions;
               
            Modifieable_Times_Beam_Split : Natural := Times_Beam_Split;
               
            New_Beam_Positions : Flag_Array_T (Beam_Positions'Range) := 
              (others => False);
         begin
            for I in Beam_Positions'Range loop
               if Beam_Positions (I) then
                  if Splitter_Positions.First_Element (I) then
                     if I - 1 in Beam_Positions'Range then
                        New_Beam_Positions (I - 1) := True;
                     end if;
                        
                     if I + 1 in Beam_Positions'Range then
                        New_Beam_Positions (I + 1) := True;
                     end if;
                     
                     Modifieable_Times_Beam_Split := Modifieable_Times_Beam_Split + 1;
                  else
                     New_Beam_Positions (I) := True;
                  end if;
               end if;
            end loop;
               
            Modifieable_Splitter_Positions.Delete_First;
               
            return Calculate_Beam_Split_Recusive 
              (Times_Beam_Split   => Modifieable_Times_Beam_Split,
               Beam_Positions     => New_Beam_Positions,
               Splitter_Positions => Modifieable_Splitter_Positions);
         end;
      end Calculate_Beam_Split_Recusive;
      
      Start_Beam_Position : Flag_Array_T (1 .. Splitter_Positions.First_Element'Last) := 
        (others => False);
   begin
      Start_Beam_Position (Beam_Start_Index) := True;

      return Calculate_Beam_Split_Recusive 
        (Times_Beam_Split   => 0,
         Beam_Positions     => Start_Beam_Position,
         Splitter_Positions => Splitter_Positions);
   end Calculate_How_Many_Times_The_Beam_Splits;
   
   -----------------------------------------------------------------------------
   
   function Calculate_How_Many_Timelines_The_Beam_Ends_Up_On 
     (Beam_Start_Index   : in Positive;
      Splitter_Positions : in Row_Vectors.Vector) 
      return Long_Long_Long_Integer 
   is
      type Open_Timeline_Count_T is array 
        (Splitter_Positions.First_Element'Range) of Long_Long_Long_Integer;
      
      function Calculate_Timelines_Recursive 
        (Open_Timeline_Positions : in Open_Timeline_Count_T; 
         Splitter_Positions      : in Row_Vectors.Vector)
         return Long_Long_Long_Integer 
      is
         use type Ada.Containers.Count_Type;
      begin
         if Splitter_Positions.Length = 0 then
            declare
               Result : Long_Long_Long_Integer := 0;
            begin
               for E of Open_Timeline_Positions loop
                  Result := Result + E;
               end loop;
               
               return Result;
            end;
         end if;
         
         declare
            Modifieable_Splitter_Positions : Row_Vectors.Vector := 
              Splitter_Positions;
               
            New_Open_Timeline_Positions : Open_Timeline_Count_T := 
              (others => 0);
         begin
            for I in Open_Timeline_Positions'Range loop
               if Open_Timeline_Positions (I) > 0 then
                  if Splitter_Positions.First_Element (I) then
                     if I - 1 in Open_Timeline_Positions'Range then
                        New_Open_Timeline_Positions (I - 1) := New_Open_Timeline_Positions (I - 1) + Open_Timeline_Positions (I);
                     end if;
                        
                     if I + 1 in Open_Timeline_Positions'Range then
                        New_Open_Timeline_Positions (I + 1) := New_Open_Timeline_Positions (I + 1) + Open_Timeline_Positions (I);
                     end if;
                  else
                     New_Open_Timeline_Positions (I) := New_Open_Timeline_Positions (I) + Open_Timeline_Positions (I);
                  end if;
               end if;
            end loop;
               
            Modifieable_Splitter_Positions.Delete_First;
               
            return Calculate_Timelines_Recursive 
              (Open_Timeline_Positions => New_Open_Timeline_Positions,
               Splitter_Positions      => Modifieable_Splitter_Positions);
         end;
      end Calculate_Timelines_Recursive;
      
      Start_Open_Timeline_Positions : Open_Timeline_Count_T := 
        (others => 0);
   begin
      Start_Open_Timeline_Positions (Beam_Start_Index) := 1;
      
      return Calculate_Timelines_Recursive 
        (Open_Timeline_Positions => Start_Open_Timeline_Positions, 
         Splitter_Positions      => Splitter_Positions);
   end Calculate_How_Many_Timelines_The_Beam_Ends_Up_On;
   
   -----------------------------------------------------------------------------

end Advent_Of_Code.Y2025.Day_7;
