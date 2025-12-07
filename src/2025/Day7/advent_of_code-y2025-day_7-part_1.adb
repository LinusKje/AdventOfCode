with Ada.Text_IO;

procedure Advent_Of_Code.Y2025.Day_7.Part_1 is
   Input_File : Ada.Text_IO.File_Type;
   Input_File_Path : constant String := "src/2025/Day7/Part1.txt";
   
   Number_Of_Columns : Natural := 0;
   Beam_Start_Index  : Positive;
   Splitter_Matrix   : Row_Vectors.Vector;
   
   Result : Natural := 0;
begin
   Ada.Text_IO.Open 
     (File => Input_File, 
      Mode => Ada.Text_IO.In_File, 
      Name => Input_File_Path);
   
   Read_Beam_Start:
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line 
           (File => Input_File);
      begin
         Number_Of_Columns := Read_Line'Last;
         for I in Read_Line'Range loop
            if Read_Line (I) = 'S' then
               Beam_Start_Index := I;
               exit;
            end if;
         end loop;
      end;
      
      exit;
   end loop Read_Beam_Start;
   
   Read_Splitter_Positions:
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line 
           (File => Input_File);
         
         Splitter_Positions : Flag_Array_T (1 .. Number_Of_Columns) := 
           (others => False);
      begin
         for I in Read_Line'Range loop
            if Read_Line (I) = '^' then
               Splitter_Positions (I) := True;
            end if;
         end loop;
         
         Splitter_Matrix.Append 
           (New_Item => Splitter_Positions);
      end;
   end loop Read_Splitter_Positions;
   
   Result := Calculate_How_Many_Times_The_Beam_Splits 
     (Beam_Start_Index   => Beam_Start_Index,
      Splitter_Positions => Splitter_Matrix);
   
   Ada.Text_IO.Put_Line ("Beam split:" & Result'Image & " times");
   
   Ada.Text_IO.Close 
     (File => Input_File);
end Advent_Of_Code.Y2025.Day_7.Part_1;
