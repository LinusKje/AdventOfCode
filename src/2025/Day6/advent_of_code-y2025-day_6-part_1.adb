with Ada.Text_IO;

procedure Advent_Of_Code.Y2025.Day_6.Part_1 is
   Input_File : Ada.Text_IO.File_Type;
   Input_File_Path : constant String := "src/2025/Day6/Part1.txt";

   Operand_Index : String_Index_Vectors.Vector;
   
   Problem_Data : Problem_Vectors.Vector;
   Result       : Long_Long_Long_Integer := 0;
begin
   Ada.Text_IO.Open 
     (File => Input_File, 
      Mode => Ada.Text_IO.In_File, 
      Name => Input_File_Path);
   
   Read_Operand_Data:
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line
           (File => Input_File);
         
         Number_Of_Groups : Natural := 0;
      begin
         if Ada.Text_IO.End_Of_File (File => Input_File) then
            for I in Read_Line'Range loop
               declare
                  Operation : constant Operation_T :=
                    (case Read_Line (I) is
                        when '+'    => Addition,
                        when '*'    => Multiplication,
                        when others => Not_Set);
               begin
                  if not (Operation = Not_Set) then
                     Operand_Index.Append (I);
                     Number_Of_Groups := Number_Of_Groups + 1;
                     if Number_Of_Groups > Problem_Data.Last_Index then
                        Problem_Data.Append 
                          (New_Item => Problem_T'
                             (Operation => Operation, 
                              Numbers   => <>));
                     end if;
                  end if;
               end;
            end loop;
         end if;
      end;
   end loop Read_Operand_Data;
   
   Ada.Text_IO.Reset 
     (File => Input_File);

   Read_Problem_Numbers:
   while Ada.Text_IO.Is_Open (File => Input_File) 
     and then not Ada.Text_IO.End_Of_File (File => Input_File) 
   loop
      declare
         Read_Line : constant String := Ada.Text_IO.Get_Line 
           (File => Input_File);
      begin
         -- do not need to re-read operand line
         exit when Ada.Text_IO.End_Of_File (File => Input_File);
         
         for Group in Operand_Index.First_Index .. Operand_Index.Last_Index loop
            declare
               Start_Index : constant Positive := Operand_Index.Element (Group);
               Stop_Index  : constant Positive := (if Group = Operand_Index.Last_Index then Read_Line'Last else Operand_Index (Group + 1) - 2);
               Temp_Value  : Long_Long_Long_Integer := 0;
            begin
               for J in Start_Index .. Stop_Index loop
                  if Read_Line (J) in '1' .. '9' then
                     Temp_Value := Temp_Value * 10 + As_Digit (Read_Line (J));
                  end if;
               end loop;
               
               Problem_Data (Group).Numbers.Append 
                 (New_Item => Temp_Value);
            end;
         end loop;
      end;
   end loop Read_Problem_Numbers;
   
   Result := Calculate_Sum_Of_Problems 
     (Groups => Problem_Data);
   
   Ada.Text_IO.Put_Line ("Total sum of problems:" & Result'Image);
   
   Ada.Text_IO.Close 
     (File => Input_File);
end Advent_Of_Code.Y2025.Day_6.Part_1;
