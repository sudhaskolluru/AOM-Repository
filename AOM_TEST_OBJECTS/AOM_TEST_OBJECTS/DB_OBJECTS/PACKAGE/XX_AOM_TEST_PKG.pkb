CREATE OR REPLACE PACKAGE BODY XXTPI_AOM_TEST_PKG IS
  --Function Implimentation
  FUNCTION prnt_strng RETURN VARCHAR2 IS
    BEGIN
      RETURN 'www.triniti.com';
    END prnt_strng;
END XXTPI_AOM_TEST_PKG;
/