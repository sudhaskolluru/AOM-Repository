-- ============================================================
-- FILE        : hr_postgres.pgsql
-- TYPE        : PostgreSQL Script
-- DESCRIPTION : HR Schema for PostgreSQL with Functions & Triggers
-- ============================================================

-- ============================================================
-- SECTION 1: CREATE SCHEMA & TABLES
-- ============================================================

CREATE SCHEMA IF NOT EXISTS hr;
SET search_path TO hr;

-- REGIONS
CREATE TABLE IF NOT EXISTS regions (
    region_id    SERIAL        PRIMARY KEY,
    region_name  VARCHAR(50)   NOT NULL
);

-- COUNTRIES
CREATE TABLE IF NOT EXISTS countries (
    country_id    CHAR(2)      PRIMARY KEY,
    country_name  VARCHAR(60)  NOT NULL,
    region_id     INT          REFERENCES regions(region_id)
);

-- LOCATIONS
CREATE TABLE IF NOT EXISTS locations (
    location_id     SERIAL       PRIMARY KEY,
    street_address  VARCHAR(40),
    postal_code     VARCHAR(12),
    city            VARCHAR(30)  NOT NULL,
    state_province  VARCHAR(25),
    country_id      CHAR(2)      REFERENCES countries(country_id)
);

-- DEPARTMENTS
CREATE TABLE IF NOT EXISTS departments (
    department_id    SERIAL       PRIMARY KEY,
    department_name  VARCHAR(50)  NOT NULL,
    manager_id       INT,
    location_id      INT          REFERENCES locations(location_id)
);

-- JOBS
CREATE TABLE IF NOT EXISTS jobs (
    job_id      VARCHAR(10)  PRIMARY KEY,
    job_title   VARCHAR(50)  NOT NULL,
    min_salary  NUMERIC(8,2),
    max_salary  NUMERIC(8,2)
);

-- EMPLOYEES
CREATE TABLE IF NOT EXISTS employees (
    employee_id    SERIAL        PRIMARY KEY,
    first_name     VARCHAR(30),
    last_name      VARCHAR(30)   NOT NULL,
    email          VARCHAR(60)   NOT NULL UNIQUE,
    phone_number   VARCHAR(20),
    hire_date      DATE          NOT NULL DEFAULT CURRENT_DATE,
    job_id         VARCHAR(10)   REFERENCES jobs(job_id),
    salary         NUMERIC(8,2)  CHECK (salary > 0),
    commission_pct NUMERIC(2,2)  DEFAULT 0,
    manager_id     INT           REFERENCES employees(employee_id),
    department_id  INT           REFERENCES departments(department_id),
    status         VARCHAR(20)   DEFAULT 'ACTIVE',
    updated_at     TIMESTAMP
);

-- AUDIT LOGS
CREATE TABLE IF NOT EXISTS audit_logs (
    log_id       SERIAL        PRIMARY KEY,
    action_type  VARCHAR(50)   NOT NULL,
    table_name   VARCHAR(50),
    record_id    INT,
    old_value    TEXT,
    new_value    TEXT,
    changed_by   VARCHAR(100),
    changed_at   TIMESTAMP     DEFAULT NOW()
);


-- ============================================================
-- SECTION 2: POSTGRESQL FUNCTIONS
-- ============================================================

-- Function: Get Annual Salary
CREATE OR REPLACE FUNCTION fn_get_annual_salary(p_emp_id INT)
RETURNS NUMERIC AS $$
DECLARE
    v_salary       NUMERIC;
    v_commission   NUMERIC;
BEGIN
    SELECT salary, COALESCE(commission_pct, 0)
    INTO   v_salary, v_commission
    FROM   employees
    WHERE  employee_id = p_emp_id;

    RETURN ROUND((v_salary * 12) + (v_salary * v_commission * 12), 2);
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 0;
    WHEN OTHERS        THEN RETURN -1;
END;
$$ LANGUAGE plpgsql;


-- Function: Get Department Headcount
CREATE OR REPLACE FUNCTION fn_dept_headcount(p_dept_id INT)
RETURNS INT AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM   employees
    WHERE  department_id = p_dept_id AND status = 'ACTIVE';
    RETURN v_count;
EXCEPTION
    WHEN OTHERS THEN RETURN 0;
END;
$$ LANGUAGE plpgsql;


-- Function: Employee Tenure in Years
CREATE OR REPLACE FUNCTION fn_tenure_years(p_emp_id INT)
RETURNS NUMERIC AS $$
DECLARE
    v_hire_date DATE;
BEGIN
    SELECT hire_date INTO v_hire_date
    FROM   employees WHERE employee_id = p_emp_id;

    RETURN ROUND(EXTRACT(DAY FROM (NOW() - v_hire_date::TIMESTAMP)) / 365.0, 1);
EXCEPTION
    WHEN OTHERS THEN RETURN -1;
END;
$$ LANGUAGE plpgsql;


-- ============================================================
-- SECTION 3: TRIGGERS
-- ============================================================

-- Trigger Function: Update updated_at timestamp on employee update
CREATE OR REPLACE FUNCTION trg_fn_employee_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_employee_updated_at
    BEFORE UPDATE ON employees
    FOR EACH ROW
    EXECUTE FUNCTION trg_fn_employee_updated_at();


-- Trigger Function: Log salary changes to audit_logs
CREATE OR REPLACE FUNCTION trg_fn_log_salary_change()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary <> OLD.salary THEN
        INSERT INTO audit_logs (
            action_type, table_name, record_id,
            old_value, new_value, changed_by, changed_at
        ) VALUES (
            'SALARY_UPDATE', 'EMPLOYEES', NEW.employee_id,
            'SALARY=' || OLD.salary,
            'SALARY=' || NEW.salary,
            CURRENT_USER, NOW()
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_salary_audit
    AFTER UPDATE OF salary ON employees
    FOR EACH ROW
    EXECUTE FUNCTION trg_fn_log_salary_change();


-- ============================================================
-- SECTION 4: VIEWS
-- ============================================================

CREATE OR REPLACE VIEW vw_employee_summary AS
SELECT  e.employee_id,
        e.first_name || ' ' || e.last_name     AS full_name,
        e.email,
        e.salary,
        ROUND(e.salary * 12, 2)                AS annual_salary,
        fn_tenure_years(e.employee_id)         AS tenure_years,
        d.department_name,
        j.job_title,
        e.status
FROM    employees   e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN jobs         j ON e.job_id        = j.job_id;


CREATE OR REPLACE VIEW vw_dept_salary_summary AS
SELECT  d.department_name,
        COUNT(e.employee_id)           AS headcount,
        ROUND(AVG(e.salary), 2)        AS avg_salary,
        MIN(e.salary)                  AS min_salary,
        MAX(e.salary)                  AS max_salary,
        SUM(e.salary)                  AS total_salary
FROM    employees   e
JOIN    departments d ON e.department_id = d.department_id
WHERE   e.status = 'ACTIVE'
GROUP   BY d.department_name
ORDER   BY total_salary DESC;


-- ============================================================
-- SECTION 5: SAMPLE DATA
-- ============================================================

INSERT INTO regions (region_name) VALUES
    ('Asia Pacific'),
    ('Europe'),
    ('Americas'),
    ('Middle East & Africa')
ON CONFLICT DO NOTHING;

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
    ('IT_PROG',    'Programmer',            4000,  10000),
    ('IT_MGR',     'IT Manager',            8000,  20000),
    ('FI_ANALYST', 'Finance Analyst',       5000,  15000),
    ('HR_EXEC',    'HR Executive',          3500,   9000),
    ('SA_MAN',     'Sales Manager',         7000,  20000),
    ('SA_REP',     'Sales Representative',  4000,  12000)
ON CONFLICT DO NOTHING;


-- ============================================================
-- END OF POSTGRESQL SCRIPT
-- ============================================================
