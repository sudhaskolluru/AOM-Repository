DECLARE 
   lines dbms_output.chararr; 
   num_lines number; 
BEGIN 
   -- enable the buffer with default size 20000 
   dbms_output.enable; 
   
   dbms_output.put_line('Hello Reader!'); 
   dbms_output.put_line('Hope you have enjoyed the tutorials!'); 
   dbms_output.put_line('Have a great time exploring pl/sql!'); 
  
   num_lines := 3; 
  
   dbms_output.get_lines(lines, num_lines); 
   dbms_output.get_lines('CREATE BEGIN SELECT', num_lines); 
   dbms_output.get_lines('CREATE TABLE XXBKP. BEGIN SELECT', num_lines); 
   dbms_output.get_lines('create table xxbkp. BEGIN SELECT', num_lines); 
   dbms_output.get_lines('Create table XXbkp. BEGIN SELECT', num_lines); 
   --CREATE CREATE CREATE
   FOR i IN 1..num_lines LOOP 
      dbms_output.put_line(lines(i)); 
   END LOOP; 
END; 
/
