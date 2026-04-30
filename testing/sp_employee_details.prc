-- ============================================================
-- FILE        : sp_employee_details.prc
-- TYPE        : Stored Procedure
-- DESCRIPTION : Get employee details by department
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_employee_details (
    p_dept_id    IN  employees.department_id%TYPE,
    p_emp_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_emp_cursor FOR
        SELECT  e.employee_id,
                e.first_name,
                e.last_name,
                e.email,
                e.phone_number,
                e.hire_date,
                e.salary,
                e.commission_pct,
                d.department_name,
                j.job_title
        FROM    employees   e
        JOIN    departments d ON e.department_id = d.department_id
        JOIN    jobs         j ON e.job_id        = j.job_id
        WHERE   e.department_id = p_dept_id
        ORDER   BY e.last_name, e.first_name;

    DBMS_OUTPUT.PUT_LINE('Procedure executed successfully for dept_id: ' || p_dept_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employees found for department: ' || p_dept_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END sp_employee_details;
/

-- ============================================================
-- PROCEDURE: sp_update_salary
-- DESCRIPTION: Update employee salary with audit log
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_update_salary (
    p_employee_id IN employees.employee_id%TYPE,
    p_new_salary  IN employees.salary%TYPE,
    p_updated_by  IN VARCHAR2
)
AS
    v_old_salary  employees.salary%TYPE;
    v_emp_name    VARCHAR2(100);
BEGIN
    -- Get current salary
    SELECT salary, first_name || ' ' || last_name
    INTO   v_old_salary, v_emp_name
    FROM   employees
    WHERE  employee_id = p_employee_id;

    -- Update salary
    UPDATE employees
    SET    salary     = p_new_salary,
           updated_at = SYSDATE
    WHERE  employee_id = p_employee_id;

    -- Insert audit record
    INSERT INTO audit_logs (
        action_type, table_name, record_id,
        old_value, new_value, changed_by, changed_at
    ) VALUES (
        'UPDATE', 'EMPLOYEES', p_employee_id,
        'SALARY=' || v_old_salary,
        'SALARY=' || p_new_salary,
        p_updated_by, SYSDATE
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated for ' || v_emp_name ||
                         ' from ' || v_old_salary || ' to ' || p_new_salary);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found: ' || p_employee_id);
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating salary: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END sp_update_salary;
/

-- ============================================================
-- PROCEDURE: sp_transfer_employee
-- DESCRIPTION: Transfer employee to another department
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_transfer_employee (
    p_employee_id   IN employees.employee_id%TYPE,
    p_new_dept_id   IN departments.department_id%TYPE,
    p_new_job_id    IN jobs.job_id%TYPE,
    p_new_salary    IN employees.salary%TYPE DEFAULT NULL
)
AS
    v_old_dept_id  employees.department_id%TYPE;
    v_old_job_id   employees.job_id%TYPE;
    v_old_salary   employees.salary%TYPE;
BEGIN
    SELECT department_id, job_id, salary
    INTO   v_old_dept_id, v_old_job_id, v_old_salary
    FROM   employees
    WHERE  employee_id = p_employee_id;

    -- Save history
    INSERT INTO job_history (
        employee_id, start_date, end_date,
        job_id, department_id
    )
    SELECT employee_id, hire_date, SYSDATE,
           job_id, department_id
    FROM   employees
    WHERE  employee_id = p_employee_id;

    -- Transfer employee
    UPDATE employees
    SET    department_id = p_new_dept_id,
           job_id        = p_new_job_id,
           salary        = NVL(p_new_salary, v_old_salary),
           hire_date     = SYSDATE
    WHERE  employee_id  = p_employee_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employee ' || p_employee_id || ' transferred successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
        RAISE;
END sp_transfer_employee;
/
