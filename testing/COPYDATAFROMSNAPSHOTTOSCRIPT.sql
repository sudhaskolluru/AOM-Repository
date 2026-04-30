  CREATE OR REPLACE EDITIONABLE PROCEDURE "COPYDATAFROMSNAPSHOTTOSCRIPT" (SNAPSHOT_NAMEE varchar2) is
  insertCount NUMBER DEFAULT 0;
  sql_stmt    VARCHAR2(1000);
  cursor CursorForCopyingData is
    select distinct TSL.SCRIPT_LINE_ID,
                    TS.SCRIPT_ID,
                    RMS.UPDATED_LABEL,
                    RMS.TESTING_LABEL,
                    TSL.ACTUAL_LABEL,
                    TSL.LABEL,
                    RMS.ALIAS,
                    RMS.EDITABLE,
                    RMS.DATASET_REQUIRED,
                    RMS.DRILLDOWN_FLAG,
                    RMS.USAGE
      from T_SNAPSHOT_HEADER        TSH,
           REPLAY_METADATA_SNAPSHOT RMS,
           T_SCRIPT_LINES           TSL,
           T_SCRIPTS                TS,
           TEST_CASES               TC,
           TEST_CASE_STEPS          TCS
     where TSH.T_SNAPSHOT_ID = RMS.SNAPSHOT_ID
       and TC.CASE_ID = TCS.CASE_ID
       and TCS.STEP_NAME = RMS.BPM_STEP_NAME
       and TS.SCRIPT_NAME = TCS.TESTING_SCRIPT_NAME
       and TS.SCRIPT_ID = TSL.SCRIPT_ID
       and RMS.TESTING_LABEL = TSL.ACTUAL_LABEL(+)
       and ((RMS.ALIAS is not null) or (RMS.EDITABLE is not null) or
           (RMS.DATASET_REQUIRED is not null) or
           (RMS.DRILLDOWN_FLAG is not null) or (RMS.USAGE is not null))
       and TSH.T_SNAPSHOT_NAME = SNAPSHOT_NAMEE; --Dynamically passing snapshot name for entire snapshot update. or
  -- and TSH.T_SNAPSHOT_ID = 1081;  --Dynamically passing snapshot_Id for updating entire snapshot update. or
  -- and TS.SCRIPT_ID = Script_idd;     --Dynamically passing script_ID and either of snapshot_name or snapshot_id for complete script update. or
  -- and TSL.SCRIPT_LINE_ID = Script_Line_IDD; --Dynamically passing script_Line_Id and either of snapshot_name or snapshot_id for single line update
  CursorDataHolder CursorForCopyingData%ROWTYPE;
BEGIN
  open CursorForCopyingData;
  LOOP
    FETCH CursorForCopyingData
      into CursorDataHolder;
    exit when CursorForCopyingData%Notfound;
    Begin
      sql_stmt := 'update T_SCRIPT_LINES TSL SET ALIAS = ' ||
                  CursorDataHolder.ALIAS || ',' || 'EDITABLE = ' ||
                  CursorDataHolder.EDITABLE || ',' || 'DATASET_REQUIRED = ' ||
                  CursorDataHolder.DATASET_REQUIRED || ',' ||
                  'DRILLDOWN_FLAG  = ' || CursorDataHolder.DRILLDOWN_FLAG || ',' ||
                  'USAGE = ' || CursorDataHolder.USAGE || 'where ' ||
                  CursorDataHolder.SCRIPT_ID || ' = TSL.SCRIPT_ID' ||
                  ' and ' || CursorDataHolder.UPDATED_LABEL ||
                  ' = TSL.LABEL';
      update T_SCRIPT_LINES TSL
         SET ALIAS            = CursorDataHolder.ALIAS,
             EDITABLE         = CursorDataHolder.EDITABLE,
             DATASET_REQUIRED = CursorDataHolder.DATASET_REQUIRED,
             DRILLDOWN_FLAG   = CursorDataHolder.DRILLDOWN_FLAG,
             USAGE            = CursorDataHolder.USAGE
       where CursorDataHolder.SCRIPT_ID = TSL.SCRIPT_ID
         and CursorDataHolder.TESTING_LABEL = TSL.ACTUAL_LABEL;
      insertCount := insertCount + SQL%ROWCOUNT;
    end;
    DBMS_OUTPUT.PUT_LINE('Query for execution is:: ' || sql_stmt);
  end loop;
  commit;
  close CursorForCopyingData;
  DBMS_OUTPUT.PUT_LINE('Total no. of records inserted ::: ' || insertCount);
end;
/
