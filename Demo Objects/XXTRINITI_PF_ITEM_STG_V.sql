/*
  REM ===============================================================================
  REM
  REM File Name         : XXTRINITI_PF_ITEM_STG_V.sql
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
  REM 03-July-18   XXXXXXXXXXX         Created
  REM ===============================================================================
*/
CREATE OR REPLACE VIEW xxtriniti_pf_item_stg_v as SELECT * FROM xxtriniti_pf_item_stg_tbl;