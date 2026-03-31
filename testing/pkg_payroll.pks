-- ============================================================
-- FILE        : pkg_payroll.pks
-- TYPE        : Package Specification
-- DESCRIPTION : Payroll Package - Public Interface Definition
-- ============================================================

CREATE OR REPLACE PACKAGE pkg_payroll AS

    -- --------------------------------------------------------
    -- CONSTANTS
    -- --------------------------------------------------------
    c_tax_rate          CONSTANT NUMBER := 0.12;
    c_pf_rate           CONSTANT NUMBER := 0.05;
    c_bonus_threshold   CONSTANT NUMBER := 6;      -- months
    c_max_bonus_pct     CONSTANT NUMBER := 20;
    c_currency          CONSTANT VARCHAR2(5) := 'INR';

    -- --------------------------------------------------------
    -- CUSTOM TYPES
    -- --------------------------------------------------------
    TYPE t_payslip_rec IS RECORD (
        employee_id   NUMBER,
        full_name     VARCHAR2(100),
        gross_pay     NUMBER,
        tax           NUMBER,
        pf            NUMBER,
        net_pay       NUMBER,
        pay_month     NUMBER,
        pay_year      NUMBER
    );

    TYPE t_payslip_table IS TABLE OF t_payslip_rec INDEX BY PLS_INTEGER;

    TYPE t_dept_payroll_rec IS RECORD (
        department_id   NUMBER,
        dept_name       VARCHAR2(100),
        total_gross     NUMBER,
        total_net       NUMBER,
        emp_count       NUMBER
    );

    TYPE t_dept_payroll_table IS TABLE OF t_dept_payroll_rec INDEX BY PLS_INTEGER;

    -- --------------------------------------------------------
    -- PROCEDURES
    -- --------------------------------------------------------

    -- Process full monthly payroll run
    PROCEDURE process_monthly_payroll (
        p_month IN NUMBER,
        p_year  IN NUMBER
    );

    -- Generate individual payslip
    PROCEDURE generate_payslip (
        p_employee_id IN NUMBER,
        p_month       IN NUMBER,
        p_year        IN NUMBER
    );

    -- Generate department payroll summary
    PROCEDURE dept_payroll_summary (
        p_dept_id IN NUMBER,
        p_month   IN NUMBER,
        p_year    IN NUMBER,
        p_cursor  OUT SYS_REFCURSOR
    );

    -- Reverse payroll for a given month
    PROCEDURE rollback_payroll (
        p_month IN NUMBER,
        p_year  IN NUMBER
    );

    -- --------------------------------------------------------
    -- FUNCTIONS
    -- --------------------------------------------------------

    -- Calculate net salary after deductions
    FUNCTION calc_net_salary (
        p_gross_salary IN NUMBER,
        p_tax_rate     IN NUMBER DEFAULT c_tax_rate,
        p_pf_rate      IN NUMBER DEFAULT c_pf_rate
    ) RETURN NUMBER;

    -- Check if payroll already processed
    FUNCTION is_payroll_processed (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) RETURN BOOLEAN;

    -- Get total payroll cost for month
    FUNCTION get_total_payroll_cost (
        p_month IN NUMBER,
        p_year  IN NUMBER
    ) RETURN NUMBER;

END pkg_payroll;
/
