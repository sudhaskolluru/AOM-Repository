CREATE OR REPLACE TRIGGER XXTPI_AOM_TEST_TRG
BEFORE DELETE OR INSERT OR UPDATE ON XXTPI_AOM_TEST_EMP_TBL
FOR EACH ROW
WHEN (NEW.EMP_NO > 0)
DECLARE
   sal_diff number;
BEGIN
   sal_diff := :NEW.salary  - :OLD.salary;
   dbms_output.put_line('Old salary: ' || :OLD.salary);
   dbms_output.put_line('New salary: ' || :NEW.salary);
   dbms_output.put_line('Salary difference: ' || sal_diff);
END;
/