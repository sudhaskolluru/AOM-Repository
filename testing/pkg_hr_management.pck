-- ============================================================
-- FILE        : pkg_hr_management.pck
-- TYPE        : Package (Spec + Body Combined)
-- DESCRIPTION : HR Management Package
-- ============================================================

-- ========================
-- PACKAGE SPECIFICATION
-- ========================

CREATE OR REPLACE PACKAGE pkg_hr_management AS

    -- Constants
    c_max_salary     CONSTANT NUMBER := 50000;
    c_min_salary     CONSTANT NUMBER := 1000;
    c_bonus_pct      CONSTANT NUMBER := 10;

    -- Types
    TYPE t_emp_rec IS RECORD (
        employee_id   employees.employee_id%TYPE,
        full_name     VARCHAR2(100),
        salary        employees.salary%TYPE,
        department    VARCHAR2(100)
    );

    TYPE t_emp_table IS TABLE OF t_emp_rec INDEX BY PLS_INTEGER;

    -- Public Procedures
    PROCEDURE get_employee_info    (p_emp_id IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE hire_employee        (p_first_name IN VARCHAR2, p_last_name IN VARCHAR2, p_dept_id IN NUMBER, p_job_id IN VARCHAR2, p_salary IN NUMBER);
    PROCEDURE terminate_employee   (p_emp_id IN NUMBER, p_reason IN VARCHAR2);
    PROCEDURE promote_employee     (p_emp_id IN NUMBER, p_new_job_id IN VARCHAR2, p_new_salary IN NUMBER);

    -- Public Functions
    FUNCTION  get_annual_ctc       (p_emp_id IN NUMBER) RETURN NUMBER;
    FUNCTION  get_dept_headcount   (p_dept_id IN NUMBER) RETURN NUMBER;
    FUNCTION  is_eligible_bonus    (p_emp_id IN NUMBER) RETURN BOOLEAN;

END pkg_hr_management;
/


-- ========================
-- PACKAGE BODY
-- ========================

CREATE OR REPLACE PACKAGE BODY pkg_hr_management AS

    -- Private helper
    PROCEDURE log_action (p_action IN VARCHAR2, p_emp_id IN NUMBER) AS
    BEGIN
        INSERT INTO audit_logs (action_type, record_id, changed_at)
        VALUES (p_action, p_emp_id, SYSDATE);
    END log_action;

    -- Get Employee Info
    PROCEDURE get_employee_info (p_emp_id IN NUMBER, p_cursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT e.employee_id, e.first_name || ' ' || e.last_name AS full_name,
                   e.salary, d.department_name, j.job_title
            FROM   employees e
            JOIN   departments d ON e.department_id = d.department_id
            JOIN   jobs         j ON e.job_id        = j.job_id
            WHERE  e.employee_id = p_emp_id;
    END get_employee_info;

    -- Hire Employee
    PROCEDURE hire_employee (
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_dept_id    IN NUMBER,
        p_job_id     IN VARCHAR2,
        p_salary     IN NUMBER
    ) AS
        v_new_id NUMBER;
    BEGIN
        SELECT emp_seq.NEXTVAL INTO v_new_id FROM dual;

        INSERT INTO employees (
            employee_id, first_name, last_name,
            department_id, job_id, salary, hire_date
        ) VALUES (
            v_new_id, p_first_name, p_last_name,
            p_dept_id, p_job_id, p_salary, SYSDATE
        );

        log_action('HIRE', v_new_id);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee hired with ID: ' || v_new_id);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END hire_employee;

    -- Terminate Employee
    PROCEDURE terminate_employee (p_emp_id IN NUMBER, p_reason IN VARCHAR2) AS
    BEGIN
        UPDATE employees
        SET    status = 'TERMINATED', updated_at = SYSDATE
        WHERE  employee_id = p_emp_id;

        INSERT INTO terminated_employees (employee_id, termination_date, reason)
        VALUES (p_emp_id, SYSDATE, p_reason);

        log_action('TERMINATE', p_emp_id);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END terminate_employee;

    -- Promote Employee
    PROCEDURE promote_employee (
        p_emp_id     IN NUMBER,
        p_new_job_id IN VARCHAR2,
        p_new_salary IN NUMBER
    ) AS
    BEGIN
        UPDATE employees
        SET    job_id = p_new_job_id, salary = p_new_salary
        WHERE  employee_id = p_emp_id;

        log_action('PROMOTE', p_emp_id);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END promote_employee;

    -- Get Annual CTC
    FUNCTION get_annual_ctc (p_emp_id IN NUMBER) RETURN NUMBER AS
        v_salary NUMBER;
        v_comm   NUMBER;
    BEGIN
        SELECT salary, NVL(commission_pct, 0)
        INTO   v_salary, v_comm
        FROM   employees
        WHERE  employee_id = p_emp_id;

        RETURN ROUND((v_salary + (v_salary * v_comm)) * 12, 2);
    EXCEPTION
        WHEN OTHERS THEN RETURN 0;
    END get_annual_ctc;

    -- Get Dept Headcount
    FUNCTION get_dept_headcount (p_dept_id IN NUMBER) RETURN NUMBER AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM   employees
        WHERE  department_id = p_dept_id;
        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN RETURN 0;
    END get_dept_headcount;

    -- Is Eligible for Bonus
    FUNCTION is_eligible_bonus (p_emp_id IN NUMBER) RETURN BOOLEAN AS
        v_tenure NUMBER;
    BEGIN
        SELECT MONTHS_BETWEEN(SYSDATE, hire_date)
        INTO   v_tenure
        FROM   employees
        WHERE  employee_id = p_emp_id;

        RETURN v_tenure >= 6;
    EXCEPTION
        WHEN OTHERS THEN RETURN FALSE;
    END is_eligible_bonus;

END pkg_hr_management;
/
