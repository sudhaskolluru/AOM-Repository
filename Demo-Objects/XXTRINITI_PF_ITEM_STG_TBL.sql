/*
  REM ===============================================================================
  REM
  REM File Name         : XXTRINITI_PF_ITEM_STG_TBL.sql
  REM
  REM Author            : XXXXXXX
  REM
  REM
  REM Purpose           : Staging table to store PF item information
  REM                     
  REM
  REM Revision History
  REM ----------------
  REM
  REM DATE        DEVELOPER           DESCRIPTION
  REM ---------   ------------        -----------------------------------------------
  REM 09-May-18   Sangeetha Sudha Kolluru         Created
  REM ===============================================================================
*/
CREATE TABLE xxtriniti_pf_item_stg_tbl
  (
    segment1                    VARCHAR2(240),
    description                 VARCHAR2(240),
    template_name               VARCHAR2(240),
    organization_code           VARCHAR2(240),
    creation_date               DATE,
    created_by                  NUMBER,                  
    process_flag                VARCHAR2(1),
    err_message                 VARCHAR2(1000)
  ); 