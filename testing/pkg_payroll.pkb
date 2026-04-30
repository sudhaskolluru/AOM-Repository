-- ============================================================
-- FILE        : pkg_payroll.pkb
-- TYPE        : Package Body
-- DESCRIPTION : Payroll Package Body - Full Implementation
-- ============================================================

CREATE OR REPLACE PACKAGE BODY pkg_payroll AS

    -- --------------------------------------------------------
    -- PRIVATE: Log payroll action
    -- --------------------------------------------------------
    PROCEDURE log_payroll_event (
        p_action  IN VARCHAR2,
        p_month   IN NUMBER,
        p_year    IN NUMBER,
        p_remarks IN VARCHAR2 DEFAULT NULL
    ) AS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO payroll_audit_log (
            action, pay_month, pay_year, remarks, logged_at
        ) VALUES (
            p_action, p_month, p_year, p_remarks, SYSDATE
        );
        COMMIT;
    END log_payroll_event;


    -- --------------------------------------------------------
    -- FUNCTION: calc_net_salary
    -- --------------------------------------------------------
    FUNCTION calc_net_salary (
        p_gross_salary IN NUMBER,
        p_tax_rate     IN NUMBER DEFAULT c_tax_rate,
        p_pf_rate      IN NUMBER DEFAULT c_pf_rate
    ) RETURN NUMBER AS
        v_tax     NUMBER;
        v_pf      NUMBER;
        v_net     NUMBER;
    BEGIN
        v_tax := ROUND(p_gross_salary * p_tax_rate, 2);
        v_pf  := ROUND(p_gross_salary * p_pf_rate, 2);
        v_net := ROUND(p_gross_salary - v_tax - v_pf, 2);
        RETURN v_net;
    END calc_net_salary;


    -- --------------------------------------------------------
    -- FUNCTION: is_payroll_processed
    -- --------------------------------------------------------
    FUNCTION is_payroll_processed (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) RETURN BOOLEAN AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM   payroll_ledger
        WHERE  pay_month = p_month
        AND    pay_year  = p_year;

        RETURN v_count > 0;
    EXCEPTION
        WHEN OTHERS THEN RETURN FALSE;
    END is_payroll_processed;


    -- --------------------------------------------------------
    -- FUNCTION: get_total_payroll_cost
    -- --------------------------------------------------------
    FUNCTION get_total_payroll_cost (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) RETURN NUMBER AS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(gross_pay), 0)
        INTO   v_total
        FROM   payroll_ledger
        WHERE  pay_month = p_month
        AND    pay_year  = p_year;
        RETURN v_total;
    EXCEPTION
        WHEN OTHERS THEN RETURN 0;
    END get_total_payroll_cost;


    -- --------------------------------------------------------
    -- PROCEDURE: process_monthly_payroll
    -- --------------------------------------------------------
    PROCEDURE process_monthly_payroll (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) AS
        v_total NUMBER := 0;
        v_count NUMBER := 0;

        CURSOR c_emp IS
            SELECT employee_id, salary, NVL(commission_pct, 0) AS comm_pct
            FROM   employees
            WHERE  status = 'ACTIVE';
    BEGIN
        IF is_payroll_processed(p_month, p_year) THEN
            DBMS_OUTPUT.PUT_LINE('Payroll already processed for ' || p_month || '/' || p_year);
            RETURN;
        END IF;

        FOR r IN c_emp LOOP
            DECLARE
                v_gross NUMBER;
                v_net   NUMBER;
            BEGIN
                v_gross := ROUND(r.salary + (r.salary * r.comm_pct), 2);
                v_net   := calc_net_salary(v_gross);

                INSERT INTO payroll_ledger (
                    employee_id, pay_month, pay_year,
                    gross_pay, deductions, net_pay, processed_at
                ) VALUES (
                    r.employee_id, p_month, p_year,
                    v_gross, ROUND(v_gross - v_net, 2), v_net, SYSDATE
                );

                v_total := v_total + v_net;
                v_count := v_count + 1;
            EXCEPTION
                WHEN OTHERS THEN NULL;
            END;
        END LOOP;

        log_payroll_event('PROCESS', p_month, p_year,
                          'Processed ' || v_count || ' employees. Total: ' || v_total);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Done. Employees: ' || v_count || ' | Total Net: ' || v_total);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            log_payroll_event('FAILED', p_month, p_year, SQLERRM);
            RAISE;
    END process_monthly_payroll;


    -- --------------------------------------------------------
    -- PROCEDURE: generate_payslip
    -- --------------------------------------------------------
    PROCEDURE generate_payslip (
        p_employee_id IN NUMBER,
        p_month       IN NUMBER,
        p_year        IN NUMBER
    ) AS
        v_name VARCHAR2(100);
        v_rec  payroll_ledger%ROWTYPE;
    BEGIN
        SELECT first_name || ' ' || last_name INTO v_name
        FROM   employees WHERE employee_id = p_employee_id;

        SELECT * INTO v_rec
        FROM   payroll_ledger
        WHERE  employee_id = p_employee_id
        AND    pay_month   = p_month
        AND    pay_year    = p_year;

        DBMS_OUTPUT.PUT_LINE('--- PAYSLIP ---');
        DBMS_OUTPUT.PUT_LINE('Name      : ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Period    : ' || p_month || '/' || p_year);
        DBMS_OUTPUT.PUT_LINE('Gross     : ' || c_currency || ' ' || v_rec.gross_pay);
        DBMS_OUTPUT.PUT_LINE('Deductions: ' || c_currency || ' ' || v_rec.deductions);
        DBMS_OUTPUT.PUT_LINE('Net Pay   : ' || c_currency || ' ' || v_rec.net_pay);
        DBMS_OUTPUT.PUT_LINE('---------------');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No payroll record found.');
    END generate_payslip;


    -- --------------------------------------------------------
    -- PROCEDURE: dept_payroll_summary
    -- --------------------------------------------------------
    PROCEDURE dept_payroll_summary (
        p_dept_id IN NUMBER,
        p_month   IN NUMBER,
        p_year    IN NUMBER,
        p_cursor  OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT e.department_id, d.department_name,
                   SUM(pl.gross_pay) AS total_gross,
                   SUM(pl.net_pay)   AS total_net,
                   COUNT(*)          AS emp_count
            FROM   payroll_ledger pl
            JOIN   employees      e  ON pl.employee_id   = e.employee_id
            JOIN   departments    d  ON e.department_id  = d.department_id
            WHERE  e.department_id = p_dept_id
            AND    pl.pay_month    = p_month
            AND    pl.pay_year     = p_year
            GROUP  BY e.department_id, d.department_name;
    END dept_payroll_summary;


    -- --------------------------------------------------------
    -- PROCEDURE: rollback_payroll
    -- --------------------------------------------------------
    PROCEDURE rollback_payroll (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM   payroll_ledger
        WHERE  pay_month = p_month AND pay_year = p_year;

        DELETE FROM payroll_ledger
        WHERE  pay_month = p_month AND pay_year = p_year;

        log_payroll_event('ROLLBACK', p_month, p_year,
                          'Deleted ' || v_count || ' records.');
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Rolled back ' || v_count || ' payroll records.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END rollback_payroll;

END pkg_payroll;
/
