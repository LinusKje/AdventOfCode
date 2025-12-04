with Ada.Text_IO;
with Ada.Strings.Fixed;

procedure Advent_Of_Code.Y2025.Day_2.Part_2 is
   Input_File : Ada.Text_IO.File_Type;
   Input_File_Path : constant String := "src/2025/Day2/Part2.txt";
   
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
         
         Iterator    : Positive := Read_Line'First;
         Start_Index : Positive := Iterator;
         Range_Start : Long_Long_Long_Integer := 0;
         Range_Stop  : Long_Long_Long_Integer := 0;
         Range_Found : Boolean;
      begin
         while Iterator <= Read_Line'Last loop
            Range_Found := False;
            
            if Read_Line (Iterator) = '-' then
               Range_Start := Long_Long_Long_Integer'Value (Read_Line (Start_Index .. Iterator - 1));
               Start_Index := Iterator + 1;
            elsif Read_Line (Iterator) = ',' then
               Range_Stop := Long_Long_Long_Integer'Value (Read_Line (Start_Index .. Iterator - 1));
               Start_Index := Iterator + 1;
               Range_Found := True;
            elsif Iterator = Read_Line'Last then
               Range_Stop := Long_Long_Long_Integer'Value (Read_Line (Start_Index .. Iterator));
               Range_Found := True;
            end if;
            
            if Range_Found then
               Result := Result + Sum_Of_Invalid_Ids
                 (Range_Start => Range_Start, 
                  Range_End   => Range_Stop,
                  Version     => Version_2);
            end if;
            
            Iterator := Iterator + 1;
         end loop;
      end;
   end loop;
   
   Ada.Text_IO.Put_Line ("Total sum of invalid ids:" & Result'Image);
   
   Ada.Text_IO.Close 
     (File => Input_File);
end Advent_Of_Code.Y2025.Day_2.Part_2;
