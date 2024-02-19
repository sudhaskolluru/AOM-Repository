CREATE OR REPLACE PACKAGE DummyPackage AS
  PROCEDURE DisplayMessage;
END DummyPackage;
/

CREATE OR REPLACE PACKAGE BODY DummyPackage AS
  PROCEDURE DisplayMessage AS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello from DummyPackage!');
  END DisplayMessage;
END DummyPackage;
/
