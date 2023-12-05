CREATE OR REPLACE PACKAGE BODY XXTPI_TEST_TU_PKG IS
  --Function Implimentation
  FUNCTION prnt_strng RETURN VARCHAR2 IS
    BEGIN
      RETURN 'TU Bu bir Çin dili ve test nesnesidir SP Buenos días Feliz cumpleaños Hola Buenos días ¿Cómo estás? Me gustaría I cant even No big deal 你叫什么名字 你来自哪里  多少钱';
    END prnt_strng;
END XXTPI_AOM_TEST_TU_PKG;
/