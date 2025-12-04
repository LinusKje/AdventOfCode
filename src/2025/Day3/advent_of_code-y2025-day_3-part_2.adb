with Ada.Text_IO;

procedure Advent_Of_Code.Y2025.Day_3.Part_2 is
   Input_File : Ada.Text_IO.File_Type;
   Input_File_Path : constant String := "src/2025/Day3/Part2.txt";
   
   Result : Long_Long_Long_Integer := 0;
begin
   Ada.Text_IO.Open 
     (File => Input_File, 
      Mode => Ada.Text_IO.In_File, 
      Name => Input_File_Path);
   
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line 
           (File => Input_File);
      begin
         Result := Result + Calculate_Largest_Possible_Joltage 
           (Battery_Bank                   => Read_Line,
            Number_Of_Batteries_To_Turn_On => 12);
      end;
   end loop;
   
   Ada.Text_IO.Put_Line ("Total output Joltage:" & Result'Image);
   
   Ada.Text_IO.Close 
     (File => Input_File);
end Advent_Of_Code.Y2025.Day_3.Part_2;
