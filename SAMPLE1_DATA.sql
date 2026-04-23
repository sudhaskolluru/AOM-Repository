  CREATE OR REPLACE EDITIONABLE FUNCTION "SAMPLE1_DATA" (x number, y number)
return number
as
v_num number;
begin
  v_num:=x*y;
  return v_num;
  dbms_output.put_line(v_num);
end;
/
