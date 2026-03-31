-- ============================================================
-- FILE        : hr_data_load.pls
-- TYPE        : PL/SQL Anonymous Block Script
-- DESCRIPTION : Data loading and initialization script
-- ============================================================

SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    v_count       NUMBER := 0;
    v_dept_id     departments.department_id%TYPE;
    v_emp_id      employees.employee_id%TYPE;
    v_error_msg   VARCHAR2(500);

    -- Cursor to fetch all departments
    CURSOR c_departments IS
        SELECT department_id, department_name
        FROM   departments
        ORDER  BY department_id;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== HR DATA INITIALIZATION STARTED ===');
    DBMS_OUTPUT.PUT_LINE('Start Time: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));

    -- Step 1: Count existing employees
    SELECT COUNT(*) INTO v_count FROM employees;
    DBMS_OUTPUT.PUT_LINE('Existing employee count: ' || v_count);

    -- Step 2: Insert default departments if not exists
    FOR r_dept IN c_departments LOOP
        DBMS_OUTPUT.PUT_LINE('Processing Department: ' || r_dept.department_name);

        -- Check if department has employees
        SELECT COUNT(*) INTO v_count
        FROM   employees
        WHERE  department_id = r_dept.department_id;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('  WARNING: No employees in ' || r_dept.department_name);
        ELSE
            DBMS_OUTPUT.PUT_LINE('  Employee Count: ' || v_count);
        END IF;
    END LOOP;

    -- Step 3: Update null commission to 0
    UPDATE employees
    SET    commission_pct = 0
    WHERE  commission_pct IS NULL;

    DBMS_OUTPUT.PUT_LINE('Updated NULL commission rows: ' || SQL%ROWCOUNT);

    -- Step 4: Insert sample audit log
    INSERT INTO audit_logs (action_type, table_name, changed_by, changed_at)
    VALUES ('INIT_SCRIPT', 'EMPLOYEES', 'SYSTEM', SYSDATE);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('=== HR DATA INITIALIZATION COMPLETED ===');
    DBMS_OUTPUT.PUT_LINE('End Time: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));

EXCEPTION
    WHEN OTHERS THEN
        v_error_msg := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || v_error_msg);
        ROLLBACK;
END;
/
