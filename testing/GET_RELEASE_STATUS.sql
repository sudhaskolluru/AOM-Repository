  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_RELEASE_STATUS" (release_number in varchar2) return varchar2 is
mig_flag number(5) := 0;
skip_count number(5) := 0;
migration_count number(5) := 0;
release_status varchar2(100) := null;
str varchar2(10) := '';
begin
for i in (select tmrl.mig_migration_status
              from tri2gps_dev.t_migration_requests_log tmrl,
                   tri2gps_dev.t_migration_requests     tmr
             where tmr.mig_release_number = release_number
               and tmrl.migration_requests_id = tmr.migration_request_id
               and tmrl.migration_requests_log_id =
                   (select max(rl.migration_requests_log_id)
                      from tri2gps_dev.t_migration_requests_log rl
                     where rl.migration_requests_id =
                           tmr.migration_request_id
                       and rl.mig_release_number = release_number
                       and rl.mig_migration_status is not null))
loop
begin
i.mig_migration_status := trim(i.mig_migration_status);
if(i.mig_migration_status IS NOT NULL or i.mig_migration_status <> str) then
-- DBMS_OUTPUT.PUT_LINE('i.mig_migration_status:'|| i.mig_migration_status);
mig_flag := 1;
migration_count := migration_count +1;
if (i.MIG_MIGRATION_STATUS = 'MIGRATION FAILED') then
release_status := 'RELEASE FAILED';
exit;
elsif
(i.MIG_MIGRATION_STATUS = 'MIGRATED WITH WARNINGS') then
release_status := 'RELEASE MIGRATED WITH WARNINGS';
elsif
(i.MIG_MIGRATION_STATUS = 'Migration Moved All Objects Skipped') then
skip_count := skip_count +1;
end if;
end if;
end;
end loop;
-- DBMS_OUTPUT.PUT_LINE('mig_flag:'|| mig_flag||', migration_count:' || migration_count);
if (mig_flag = 1 and release_status IS NULL) then
if (skip_count = migration_count) then
              release_status := 'Release Moved All Migrations Skipped';
           else
             release_status := 'RELEASE COMPLETED';
           end if;
      end if;
      return release_status;
   end;
/
