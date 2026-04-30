-- ============================================================
-- FILE        : pkg_payroll.plb
-- TYPE        : PL/SQL Package Body (Binary/Compiled)
-- DESCRIPTION : Payroll processing package body
-- ============================================================

CREATE OR REPLACE PACKAGE BODY pkg_payroll AS

    -- --------------------------------------------------------
    -- Private: Validate Salary Range
    -- --------------------------------------------------------
    FUNCTION validate_salary (
        p_job_id IN VARCHAR2,
        p_salary IN NUMBER
    ) RETURN BOOLEAN AS
        v_min_sal jobs.min_salary%TYPE;
        v_max_sal jobs.max_salary%TYPE;
    BEGIN
        SELECT min_salary, max_salary
        INTO   v_min_sal, v_max_sal
        FROM   jobs
        WHERE  job_id = p_job_id;

        RETURN (p_salary BETWEEN v_min_sal AND v_max_sal);
    EXCEPTION
        WHEN OTHERS THEN RETURN FALSE;
    END validate_salary;


    -- --------------------------------------------------------
    -- Public: Process Monthly Payroll
    -- --------------------------------------------------------
    PROCEDURE process_monthly_payroll (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) AS
        v_total_payroll NUMBER := 0;
        v_emp_count     NUMBER := 0;

        CURSOR c_employees IS
            SELECT employee_id, salary, commission_pct,
                   first_name || ' ' || last_name AS full_name
            FROM   employees
            WHERE  status = 'ACTIVE';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Processing payroll for: ' || p_month || '/' || p_year);

        FOR r_emp IN c_employees LOOP
            DECLARE
                v_gross_pay  NUMBER;
                v_deductions NUMBER;
                v_net_pay    NUMBER;
            BEGIN
                v_gross_pay  := r_emp.salary + NVL(r_emp.commission_pct * r_emp.salary, 0);
                v_deductions := ROUND(v_gross_pay * 0.12, 2);  -- 12% tax
                v_net_pay    := ROUND(v_gross_pay - v_deductions, 2);

                INSERT INTO payroll_ledger (
                    employee_id, pay_month, pay_year,
                    gross_pay, deductions, net_pay, processed_at
                ) VALUES (
                    r_emp.employee_id, p_month, p_year,
                    v_gross_pay, v_deductions, v_net_pay, SYSDATE
                );

                v_total_payroll := v_total_payroll + v_net_pay;
                v_emp_count     := v_emp_count + 1;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Skipped: ' || r_emp.full_name || ' - ' || SQLERRM);
            END;
        END LOOP;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employees processed : ' || v_emp_count);
        DBMS_OUTPUT.PUT_LINE('Total net payroll   : ' || v_total_payroll);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Payroll processing failed: ' || SQLERRM);
            RAISE;
    END process_monthly_payroll;


    -- --------------------------------------------------------
    -- Public: Generate Payslip
    -- --------------------------------------------------------
    PROCEDURE generate_payslip (
        p_employee_id IN NUMBER,
        p_month       IN NUMBER,
        p_year        IN NUMBER
    ) AS
        v_rec payroll_ledger%ROWTYPE;
        v_emp_name VARCHAR2(100);
    BEGIN
        SELECT first_name || ' ' || last_name
        INTO   v_emp_name
        FROM   employees
        WHERE  employee_id = p_employee_id;

        SELECT * INTO v_rec
        FROM   payroll_ledger
        WHERE  employee_id = p_employee_id
        AND    pay_month   = p_month
        AND    pay_year    = p_year;

        DBMS_OUTPUT.PUT_LINE('============================');
        DBMS_OUTPUT.PUT_LINE('PAYSLIP - ' || p_month || '/' || p_year);
        DBMS_OUTPUT.PUT_LINE('Employee  : ' || v_emp_name);
        DBMS_OUTPUT.PUT_LINE('Gross Pay : ' || v_rec.gross_pay);
        DBMS_OUTPUT.PUT_LINE('Deductions: ' || v_rec.deductions);
        DBMS_OUTPUT.PUT_LINE('Net Pay   : ' || v_rec.net_pay);
        DBMS_OUTPUT.PUT_LINE('============================');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No payroll record found.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END generate_payslip;

END pkg_payroll;
/
