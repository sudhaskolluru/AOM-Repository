CREATE OR REPLACE PACKAGE BODY XXTPI_AOM_TEST_TU_PKG IS
  --Function Implimentation
  FUNCTION prnt_strng RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Bu bir Çin dili ve test nesnesidir';
    END prnt_strng;
END XXTPI_AOM_TEST_TU_PKG;
/
