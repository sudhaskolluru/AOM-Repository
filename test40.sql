SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

 
  create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL

alter
--
alter
--create
--
create
SELECT "STATE_NAME",replace

       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
  
  /*create table;
  alter table
  --alter
  */

UNION ALL
SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061
 
UNION ALL


SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       STATE_NAME "ACTION_ITEM_DESCRIPTION",
       'COMPLETED' "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       t_users.FIRST_NAME || ' ' || t_users.MIDDLE_NAME || ' ' ||
       t_users.LAST_NAME USER_NAME,
       t_instances.creation_date "START_DATE",
       t_instances.creation_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       issues.notes "COMMENTS",
       null "MANAGER_COMMENTS",
       issues.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       issue_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

  from t_instances           t_instances,
       tri2gps_dev.issues    issues,
       t_gps_workflow_states t_gps_workflow_states,
       t_gps_workflow_types  t_gps_workflow_types,
       tas.t_users           t_users,
       t_gps_state_operations t_gps_state_operations,
       t_gps_operation_to_states t_gps_operation_to_states
       
 where t_instances.instance_id = issues.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
  and issues.created_by = t_users.user_id
   and t_gps_workflow_states.startnode = 1
    and t_instances.active=1
   and t_gps_workflow_states.state_descriptor <> 'Workflow Move'
   and t_gps_workflow_states.state_id = t_gps_state_operations.from_state_id
   and t_gps_state_operations.operation_id = t_gps_operation_to_states.operation_id  
  AND issues.issue_number in ('TINC00061')-- TCC/ISOE/20022 -- TINC00061        
 UNION
 
 SELECT "STATE_NAME",
       null "PROJECT_TASK_ID",
       STATE_NAME "ACTUAL_STATE_NAME",
       null "ACTION_ITEM_DESCRIPTION",
       decode(moved_out_date, null, 'STARTED', 'COMPLETED') "STATUS",
       t_gps_state_operations.operation_name "OPERATION NAME",
       null "RESOURCE_NAME",
       'AOM System' USER_NAME,
       t_instances.created_date "START_DATE",
       t_instances.moved_out_date "FINISH_DATE",
       null "DURATION",
       null "DAYSREMAINING",
       decode(moved_out_date, null, '', 'Moved by System') "COMMENTS",
       null "MANAGER_COMMENTS",
       t_migration_requests.instance_id "INSTANCE_ID",
       "STATE_ORDER",
       "DISPLAY_ORDER",
       migration_request_number "PROPERTY_VALUE",
       "WORKFLOW_TYPE_NAME",
       '' for_order

       
  from t_gps_instances                  t_instances,
       tri2gps_dev.t_migration_requests t_migration_requests,
       t_gps_workflow_states            t_gps_workflow_states,
       t_gps_workflow_types             t_gps_workflow_types,
       t_gps_state_operations           t_gps_state_operations,
       t_gps_operation_to_states        t_gps_operation_to_states
       
       
 where t_instances.instance_id = t_migration_requests.instance_id
   and t_instances.workflow_type_id =
       t_gps_workflow_states.workflow_type_id
   and t_gps_workflow_states.workflow_type_id =
       t_gps_workflow_types.workflow_type_id
   and t_instances.current_state_id = t_gps_workflow_states.state_id
   and t_gps_workflow_states.state_descriptor = 'Self Move State'
   and t_instances.active=1
   and t_instances.current_state_id = t_gps_state_operations.from_state_id --
   and t_gps_operation_to_states.operation_id = t_gps_operation_to_states.operation_id --
   and t_migration_requests.migration_request_number = 'TCC/ISOE/20022' --1512
 ORDER BY start_date, STATE_ORDER, FINISH_DATE;

