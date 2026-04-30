CREATE OR REPLACE PROCEDURE proc_compile_error AS
    v_message VARCHAR2(100);
BEGIN
    v_message := 'Hello World'  -- ❌ Missing semicolon here
    DBMS_OUTPUT.PUT_LINE(v_message_undefined);  -- ❌ Undefined variable name
END proc_compile_error;