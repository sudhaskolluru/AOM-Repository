CREATE OR REPLACE FUNCTION get_employee_name(
    p_emp_id NUMBER
)
RETURN VARCHAR2
IS
    v_name employee.emp_name%TYPE;
BEGIN
    SELECT emp_name
    INTO v_name
    FROM employee
    WHERE emp_id = p_emp_id;

    RETURN v_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/