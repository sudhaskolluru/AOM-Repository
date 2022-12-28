CREATE OR REPLACE PACKAGE BODY XXTPI_AOM_TEST_GE_PKG IS
  --Function Implimentation
  FUNCTION prnt_strng RETURN VARCHAR2 IS
    BEGIN
      RETURN 'ACHTUNG: Bitte nur bei geänderter Bankverbindung eine Mitteilung an uns senden. Wir überweisen den Betrag auf das uns bekannte Konto';
    END prnt_strng;
END XXTPI_AOM_TEST_GE_PKG;
/
