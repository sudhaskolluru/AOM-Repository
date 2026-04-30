  CREATE OR REPLACE EDITIONABLE PACKAGE "T_TRI2_IA_ANALYZE_DATA" AS
  TYPE DATAHOLDER_TYPE IS TABLE OF IA_DBA_DEPENDENCIES%ROWTYPE INDEX BY BINARY_INTEGER;
  DATAHOLDER    DATAHOLDER_TYPE;
  V_SIZE        NUMBER := 2;
  G_LEVEL       NUMBER := 0;
  G_OBJECT_NAME VARCHAR2(40) := NULL;
  G_REQUEST_ID  NUMBER;
  G_PATCH_ID    NUMBER;
  G_ACTION_ID   NUMBER;
  G_OBJECT_ID   NUMBER;
  G_LATEST      VARCHAR2(10) := NULL;
  G_MAX_LEVEL   NUMBER := 0;
  PROCEDURE GET_DEPENDENCY_DETAILS(P_REQUEST_ID  IN NUMBER,
                                   P_PATCH_ID    IN NUMBER,
                                   P_ACTION_ID   IN NUMBER,
                                   P_OBJECT_ID   IN NUMBER,
                                   P_OBJECT_NAME IN VARCHAR2,
                                   P_CONNECTION_NAME IN VARCHAR2,
                                   P_LATEST      IN VARCHAR2,
                                   P_MAX_LEVEL   IN NUMBER DEFAULT 5);
  PROCEDURE CHECK_RECURSIVELY(V_OBJECT_NAME IN VARCHAR2, V_CONNECTION_NAME IN VARCHAR2 /*,P_LEVEL NUMBER*/);
END T_TRI2_IA_ANALYZE_DATA;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "T_TRI2_IA_ANALYZE_DATA" AS
  PROCEDURE GET_DEPENDENCY_DETAILS(P_REQUEST_ID  IN NUMBER,
                                   P_PATCH_ID    IN NUMBER,
                                   P_ACTION_ID   IN NUMBER,
                                   P_OBJECT_ID   IN NUMBER,
                                   P_OBJECT_NAME IN VARCHAR2,
                                   P_CONNECTION_NAME IN VARCHAR2,
                                   P_LATEST      IN VARCHAR2,
                                   P_MAX_LEVEL   IN NUMBER DEFAULT 5) AS
    V_INDEX NUMBER := 1;
  BEGIN
    --FOR I IN (SELECT DISTINCT PNAME,PATCH_NUMBER FROM XX_PATCH_ANALYSIS_DATA WHERE PATCH_NUMBER=V_BUG_NUMBER) LOOP
    G_MAX_LEVEL := P_MAX_LEVEL;
    SELECT * BULK COLLECT
      INTO DATAHOLDER
      FROM IA_DBA_DEPENDENCIES
     WHERE REFERENCED_NAME = P_OBJECT_NAME
           AND CONNECTION_NAME = P_CONNECTION_NAME;
    G_OBJECT_NAME := P_OBJECT_NAME;
    G_REQUEST_ID  := P_REQUEST_ID;
    G_PATCH_ID    := P_PATCH_ID;
    G_ACTION_ID   := P_ACTION_ID;
    G_OBJECT_ID   := P_OBJECT_ID;
    G_LATEST      := P_LATEST;
    V_SIZE        := DATAHOLDER.COUNT;
    V_INDEX       := 1;
    BEGIN
      FOR I IN 1 .. DATAHOLDER.COUNT loop
        INSERT INTO T_TRI2_IA_DATA_COLLECTION
          (IA_REQUEST_ID,
           PATCH_ID,
           ACTION_ID,
           OBJECT_ID,
           NAME,
           REFERENCED_NAME,
           REF_LEVEL,
           SEARCHEDOBJ,
           TYPE,
           REFERENCED_TYPE,
           LATEST,
           application_short_name)
        VALUES
          (G_REQUEST_ID,
           G_PATCH_ID,
           G_ACTION_ID,
           G_OBJECT_ID,
           DATAHOLDER(I).NAME,
           G_OBJECT_NAME,
           0,
           G_OBJECT_NAME,
           DATAHOLDER(I).TYPE,
           DATAHOLDER(I).REFERENCED_TYPE,
           G_LATEST,
           SUBSTR(DATAHOLDER(i).NAME, 1, INSTR(DATAHOLDER(i).NAME, '_') - 1));
      end loop;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[EXCCEPTION]WHILE INSERTING INTIAL ROW[s]' ||
                             SQLERRM);
    END;
    WHILE V_INDEX <= V_SIZE LOOP
      --dbms_output.put_line(v_index||' name '|| dataholder(v_index).name);
      --IF (G_LEVEL != 0) THEN
      SELECT MAX(REF_LEVEL)
        INTO G_LEVEL
        FROM T_TRI2_IA_DATA_COLLECTION
       WHERE NAME = DATAHOLDER(V_INDEX).NAME;
      /*ELSE
        G_LEVEL := 0;
      END IF;*/
      CHECK_RECURSIVELY(DATAHOLDER(V_INDEX).NAME, P_CONNECTION_NAME);
      V_INDEX := V_INDEX + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Count:' || DATAHOLDER.COUNT);
    --end loop;
    /*for J in dataholder.first.. dataholder.last loop
          INSERT INTO XX_IA_DATA_COLLECTION
        (REF_NAME, REF_BY, REF_LEVEL, SEARCHEDOBJ ,REF_NAME_TYPE, REF_BY_TYPE)
      VALUES
        (DATAHOLDER(J).NAME,
         V_OBJECT_NAME,
         G_LEVEL,
         G_OBJECT_NAME,
         DATAHOLDER(V_SIZE).TYPE,
         DATAHOLDER(V_SIZE).REFERENCED_TYPE);
      COMMIT;
        end loop;
    */
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(DATAHOLDER(V_INDEX).NAME || ' ' || SQLERRM);
  END GET_DEPENDENCY_DETAILS;
  PROCEDURE CHECK_RECURSIVELY(V_OBJECT_NAME IN VARCHAR2,V_CONNECTION_NAME IN VARCHAR2 /*,P_LEVEL NUMBER*/) AS
  BEGIN
    --dbms_output.put_line('Before loop ' || v_object_name);
    --g_level:=g_level+1;
    G_LEVEL := G_LEVEL + 1;
    IF G_LEVEL > G_MAX_LEVEL THEN
      RETURN;
    ELSE
      FOR DEP_REC IN (SELECT *
                        FROM IA_DBA_DEPENDENCIES D
                       WHERE REFERENCED_NAME = V_OBJECT_NAME
                         AND D.REFERENCED_NAME <> D.NAME
                         AND CONNECTION_NAME = V_CONNECTION_NAME
                         AND NOT EXISTS
                       (SELECT 1
                                FROM T_TRI2_IA_DATA_COLLECTION XXRECD
                               WHERE D.NAME = XXRECD.NAME)) LOOP
        V_SIZE := V_SIZE + 1;
        DATAHOLDER(V_SIZE).NAME := DEP_REC.NAME;
        DATAHOLDER(V_SIZE).REFERENCED_TYPE := DEP_REC.REFERENCED_TYPE;
        DATAHOLDER(V_SIZE).TYPE := DEP_REC.TYPE;
        INSERT INTO T_TRI2_IA_DATA_COLLECTION
          (IA_REQUEST_ID,
           PATCH_ID,
           ACTION_ID,
           OBJECT_ID,
           NAME,
           REFERENCED_NAME,
           REF_LEVEL,
           SEARCHEDOBJ,
           TYPE,
           REFERENCED_TYPE,
           LATEST,
           APPLICATION_SHORT_NAME)
        VALUES
          (G_REQUEST_ID,
           G_PATCH_ID,
           G_ACTION_ID,
           G_OBJECT_ID,
           DATAHOLDER(V_SIZE).NAME,
           V_OBJECT_NAME,
           G_LEVEL,
           G_OBJECT_NAME,
           DATAHOLDER(V_SIZE).TYPE,
           DATAHOLDER(V_SIZE).REFERENCED_TYPE,
           G_LATEST,
           SUBSTR(DATAHOLDER(V_SIZE).NAME,
                  1,
                  INSTR(DATAHOLDER(V_SIZE).NAME, '_') - 1));
        COMMIT;
        --dbms_output.put_line(v_size|| ' -- ' || dep_rec.name || '-- '||dataholder(v_size).name);
      END LOOP;
      update T_TRI2_IA_DATA_COLLECTION xidc
         set application_name =
             (select fav.application_name
                from ia_fnd_application_vl fav /*,t_tri2_ia_dependencies xidc*/
               where fav.application_short_name = trim(xidc.application_short_name) AND CONNECTION_NAME = V_CONNECTION_NAME);
      --dbms_output.put_line('After loop');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('[EXCEPTION]WHILE INSERTING DEPENDENT ROWS' ||
                           SQLERRM);
  END CHECK_RECURSIVELY;
END T_TRI2_IA_ANALYZE_DATA;
/
