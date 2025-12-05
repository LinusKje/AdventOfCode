with Ada.Text_IO;

procedure Advent_Of_Code.Y2025.Day_5.Part_1 is
   Input_File : Ada.Text_IO.File_Type;
   Input_File_Path : constant String := "src/2025/Day5/Part1.txt";
   
   Max_Items : constant := 2048;
   
   Fresh_Id_Ranges : Fresh_Id_Ranges_T (1 .. Max_Items);
   Number_Of_Fresh_Ranges : Natural := 0;
   
   Available_Ids : Available_Ids_T (1 .. Max_Items);
   Number_Of_Available_Ids : Natural := 0;
   
   Result : Long_Long_Long_Integer := 0;
begin
   Ada.Text_IO.Open 
     (File => Input_File, 
      Mode => Ada.Text_IO.In_File, 
      Name => Input_File_Path);
   
   Extract_Fresh_Id_Ranges:
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line 
           (File => Input_File);
      begin
         exit when Read_Line'Length = 0;
         
         for I in Read_Line'Range loop
            if Read_Line (I) = '-' then
               Number_Of_Fresh_Ranges := Number_Of_Fresh_Ranges + 1;
               Fresh_Id_Ranges (Number_Of_Fresh_Ranges) := Range_T'
                 (Start => Long_Long_Long_Integer'Value (Read_Line (Read_Line'First .. I - 1)),
                  Stop  => Long_Long_Long_Integer'Value (Read_Line (I + 1 .. Read_Line'Last)));
            end if;
         end loop;
      end;
   end loop Extract_Fresh_Id_Ranges;
   
   Extract_Available_Ids:
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line 
           (File => Input_File);
      begin
         Number_Of_Available_Ids := Number_Of_Available_Ids + 1;
         Available_Ids (Number_Of_Available_Ids) := Long_Long_Long_Integer'Value (Read_Line);
      end;
   end loop Extract_Available_Ids;
   
   Result := Count_Number_Of_Fresh_Ids 
     (Fresh_Id_Ranges => Fresh_Id_Ranges (1 .. Number_Of_Fresh_Ranges), 
      Availble_Ids    => Available_Ids (1 .. Number_Of_Available_Ids));
   
   Ada.Text_IO.Put_Line ("Total number of fresh ingredient IDs:" & Result'Image);
   
   Ada.Text_IO.Close 
     (File => Input_File);
end Advent_Of_Code.Y2025.Day_5.Part_1;
