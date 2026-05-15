  CREATE OR REPLACE EDITIONABLE VIEW "ADSSALAP_V1" ("PERSON_ID", "EMPLOYEE_NUMBER", "FIRST_NAME", "LAST_NAME", "FULL_NAME", "SUPERVISOR_ID", "EMAIL_ADDRESS", "USER_NAME") AS
  SELECT distinct e.person_id,
       e.employee_number,
       e.first_name,
       e.last_name,
       e.First_Name ||' '|| e.Last_Name full_name,
       decode(e1.supervisor_id, NULL, 0, ' ', 0, e1.supervisor_id) supervisor_id,
       substr(e.email_address, 1, 20) email_address,
       decode(substr(fnd.user_name, 1, 15), NULL, 'SYSADMIN', ' ', 'SYSADMIN', substr(fnd.user_name, 1, 15)) user_name
FROM Per_People_F e,
     per_assignments_f e1,
     fnd_user fnd
where e.person_id = e1.person_id
and e.person_id = fnd.employee_id(+)
and e.current_employee_flag = 'Y'
and e1.primary_flag = 'Y'
and to_char(e.effective_end_date, 'DD-MON-YYYY') > sysdate
and to_char(e1.effective_end_date, 'DD-MON-YYYY') > sysdate
 ;
