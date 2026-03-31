-- ============================================================
-- FILE        : fn_salary_utils.fnc
-- TYPE        : Functions
-- DESCRIPTION : Salary and employee utility functions
-- ============================================================

-- ============================================================
-- FUNCTION: fn_get_annual_salary
-- DESCRIPTION: Calculate annual salary including commission
-- ============================================================

CREATE OR REPLACE FUNCTION fn_get_annual_salary (
    p_employee_id IN employees.employee_id%TYPE
) RETURN NUMBER
AS
    v_salary        employees.salary%TYPE;
    v_commission    employees.commission_pct%TYPE;
    v_annual        NUMBER;
BEGIN
    SELECT salary, NVL(commission_pct, 0)
    INTO   v_salary, v_commission
    FROM   employees
    WHERE  employee_id = p_employee_id;

    v_annual := ROUND((v_salary * 12) + (v_salary * v_commission * 12), 2);
    RETURN v_annual;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1;
END fn_get_annual_salary;
/


-- ============================================================
-- FUNCTION: fn_calculate_bonus
-- DESCRIPTION: Calculate bonus based on salary band
-- ============================================================

CREATE OR REPLACE FUNCTION fn_calculate_bonus (
    p_employee_id IN employees.employee_id%TYPE,
    p_bonus_pct   IN NUMBER DEFAULT 10
) RETURN NUMBER
AS
    v_salary    employees.salary%TYPE;
    v_bonus     NUMBER;
BEGIN
    SELECT salary
    INTO   v_salary
    FROM   employees
    WHERE  employee_id = p_employee_id;

    v_bonus := ROUND(v_salary * (p_bonus_pct / 100), 2);
    RETURN v_bonus;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1;
END fn_calculate_bonus;
/


-- ============================================================
-- FUNCTION: fn_employee_tenure
-- DESCRIPTION: Returns years of service for an employee
-- ============================================================

CREATE OR REPLACE FUNCTION fn_employee_tenure (
    p_employee_id IN employees.employee_id%TYPE
) RETURN NUMBER
AS
    v_hire_date employees.hire_date%TYPE;
    v_tenure    NUMBER;
BEGIN
    SELECT hire_date
    INTO   v_hire_date
    FROM   employees
    WHERE  employee_id = p_employee_id;

    v_tenure := ROUND(MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12, 1);
    RETURN v_tenure;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
    WHEN OTHERS THEN
        RETURN -1;
END fn_employee_tenure;
/


-- ============================================================
-- FUNCTION: fn_get_dept_budget
-- DESCRIPTION: Returns total salary budget for a department
-- ============================================================

CREATE OR REPLACE FUNCTION fn_get_dept_budget (
    p_dept_id IN departments.department_id%TYPE
) RETURN NUMBER
AS
    v_budget NUMBER;
BEGIN
    SELECT SUM(salary)
    INTO   v_budget
    FROM   employees
    WHERE  department_id = p_dept_id;

    RETURN NVL(v_budget, 0);

EXCEPTION
    WHEN OTHERS THEN
        RETURN -1;
END fn_get_dept_budget;
/
