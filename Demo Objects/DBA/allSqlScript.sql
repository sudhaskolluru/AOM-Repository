CREATE OR REPLACE PROCEDURE proc_test IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello World');
END;
/

drop table test_table;
-- Create a test table
CREATE TABLE test_table (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

-- Insert some sample data
INSERT INTO test_table (id, name) VALUES (1, 'Alice');
INSERT INTO test_table (id, name) VALUES (2, 'Bob');
INSERT INTO test_table (id, name) VALUES (3, 'Mike');
INSERT INTO test_table (id, name) VALUES (4, 'Ben');

-- Select data
SELECT * FROM test_table;

-- Update a row
UPDATE test_table SET name = 'Charlie' WHERE id = 1;

-- Delete a row
DELETE FROM test_table WHERE id  in (2,4);

SELECT * FROM test_table;
