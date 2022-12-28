CREATE OR REPLACE PACKAGE BODY XXTPI_AOM_TEST_CH_PKG IS
  --Function Implimentation
  FUNCTION prnt_strng RETURN VARCHAR2 IS
    BEGIN
      RETURN '这是中文和测试对象';
    END prnt_strng;
END XXTPI_AOM_TEST_CH_PKG;
/
