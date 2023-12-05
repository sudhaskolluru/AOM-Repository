CREATE OR REPLACE PROCEDURE XXTPI.XXTPI_AOM_TEST_PRC AS
/* Header: TicketNumber Date User 1.1 */

/******************************************************************************
   NAME:       XXTPI_AOM_TEST
   PURPOSE:   This procedure is for demo purpose
   CREATION DATE:  
   CREATED BY: Sangeetha Sudha
   CREATION TICKET NUMBER: 
   REVISIONS:
   Ver        Date           Author           Action            Request               Description
   ---------  ------------  ---------------  --------------    ----------------       ------------------------------------
   1.1     today        isin                    test                test for AOM--- 
******************************************************************************/
begin
--TR
dbms_output.put_line('Ç, Ş, Ğ, I, İ, Ö, Ü');
dbms_output.put_line('Günaydın. Tünaydın. Nasılsın?');
dbms_output.put_line('Günaydın  Ğ');
--E
dbms_output.put_line('Buenos días Hasta mañana');
dbms_output.put_line('Feliz cumpleaños');
--ESA
dbms_output.put_line('Hola Buenos días');
dbms_output.put_line('¿Cómo estás? Me gustaría');
--US
dbms_output.put_line('I cant even');
dbms_output.put_line('No big deal');
--ZHS
dbms_output.put_line('你叫什么名字');
dbms_output.put_line('你来自哪里  多少钱');
--Dummy Package Body for AOM test in UAT
--The line added by Sangeetha Sudha Kolluru for testing
NULL;

end;
/
