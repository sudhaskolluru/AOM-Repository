/*
  REM ===============================================================================
  REM
  REM File Name         : XXTRINITI_PF_BOM_COMP_INFO_TBL.sql
  REM
  REM Author            : XXXXXXX
  REM
  REM
  REM Purpose           : Staging table to store PF BOM item information
  REM                     
  REM
  REM Revision History
  REM ----------------
  REM
  REM DATE        DEVELOPER           DESCRIPTION
  REM ---------   ------------        -----------------------------------------------
  REM 09-May-18   XXXXXXXXXXX         Created
  REM ===============================================================================
*/
CREATE TABLE xxtriniti_pf_bom_comp_info_tbl
(
  pf_master_item    VARCHAR2(240),
  pf_component_item VARCHAR2(240),
  organization_code VARCHAR2(240),
  creation_date     DATE,
  created_by        NUMBER,
  process_status    VARCHAR2(1),
  err_message       VARCHAR2(2000)
);