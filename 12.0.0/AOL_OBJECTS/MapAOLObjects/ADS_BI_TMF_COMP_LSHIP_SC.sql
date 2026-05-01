  CREATE OR REPLACE EDITIONABLE FUNCTION "ADS_BI_TMF_COMP_LSHIP_SC" ( p_PERSON_ID IN NUMBER)
  RETURN NUMBER
  IS lookup_value NUMBER;
  v_step_value NUMBER;
  BEGIN
    SELECT   hrcp.step_value
      INTO   v_step_value
      FROM   hrfg_competence_profiles hrcp
     WHERE   hrcp.person_id = p_PERSON_ID
       AND   ((SYSDATE BETWEEN hrcp.DATE_FROM and hrcp.DATE_TO) or (SYSDATE > hrcp.DATE_FROM and hrcp.DATE_TO is NULL))
       AND   hrcp.COMPETENCE_NAME = 'Core.People Motivation';
    lookup_value:=v_step_value;
    RETURN(lookup_value);
  END;
/
