DECLARE 
   lines dbms_output.chararr; 
   num_lines number; 
BEGIN 
   -- enable the buffer with default size 20000 
   dbms_output.enable; 
   
   dbms_output.put_line('Hello Reader!'); 
   dbms_output.put_line('Hope you have enjoyed the tutorials!'); 
   dbms_output.put_line('Have a great time exploring pl/sql!'); 
  /* BEGIN
     BEGIN
     DECLARE
     CREATE
        KEY   CONCURRENT_PROGRAM_NAME         VARCHAR2(30)
        KEY   APPLICATION_SHORT_NAME          VARCHAR2(50)
        CTX   OWNER                           VARCHAR2(4000)
        BASE  LAST_UPDATE_DATE                VARCHAR2(75)
        TRANS USER_CONCURRENT_PROGRAM_NAME    VARCHAR2(240)
        BASE  EXEC                            REFERENCES EXECUTABLE
        BASE  EXECUTION_METHOD_CODE           VARCHAR2(1)
        BASE  ARGUMENT_METHOD_CODE            VARCHAR2(1)
        BASE  QUEUE_CONTROL_FLAG              VARCHAR2(1)
        BASE  QUEUE_METHOD_CODE               VARCHAR2(1)
        BASE  REQUEST_SET_FLAG                VARCHAR2(1)
        BASE  ENABLED_FLAG                    VARCHAR2(1)
        BASE  PRINT_FLAG                      VARCHAR2(1)
        BASE  RUN_ALONE_FLAG                  VARCHAR2(1)
        BASE  SRS_FLAG                        VARCHAR2(1)
        TRANS DESCRIPTION                     VARCHAR2(240)
         KEY   CONCURRENT_PROGRAM_NAME         VARCHAR2(30)
  KEY   APPLICATION_SHORT_NAME          VARCHAR2(50)
  CTX   OWNER                           VARCHAR2(4000)
  BASE  LAST_UPDATE_DATE                VARCHAR2(75)
  TRANS USER_CONCURRENT_PROGRAM_NAME    VARCHAR2(240)
  BASE  EXEC                            REFERENCES EXECUTABLE
  BASE  EXECUTION_METHOD_CODE           VARCHAR2(1)
  BASE  ARGUMENT_METHOD_CODE            VARCHAR2(1)
  BASE  QUEUE_CONTROL_FLAG              VARCHAR2(1)
  BASE  QUEUE_METHOD_CODE               VARCHAR2(1)
  BASE  REQUEST_SET_FLAG                VARCHAR2(1)
  BASE  ENABLED_FLAG                    VARCHAR2(1)
  BASE  PRINT_FLAG                      VARCHAR2(1)
  BASE  RUN_ALONE_FLAG                  VARCHAR2(1)
  BASE  SRS_FLAG                        VARCHAR2(1)
  TRANS DESCRIPTION                     VARCHAR2(240)
   KEY   CONCURRENT_PROGRAM_NAME         VARCHAR2(30)
  KEY   APPLICATION_SHORT_NAME          VARCHAR2(50)
  CTX   OWNER                           VARCHAR2(4000)
  BASE  LAST_UPDATE_DATE                VARCHAR2(75)
  TRANS USER_CONCURRENT_PROGRAM_NAME    VARCHAR2(240)
  BASE  EXEC                            REFERENCES EXECUTABLE
  BASE  EXECUTION_METHOD_CODE           VARCHAR2(1)
  BASE  ARGUMENT_METHOD_CODE            VARCHAR2(1)
  BASE  QUEUE_CONTROL_FLAG              VARCHAR2(1)
  BASE  QUEUE_METHOD_CODE               VARCHAR2(1)
  BASE  REQUEST_SET_FLAG                VARCHAR2(1)
  BASE  ENABLED_FLAG                    VARCHAR2(1)
  BASE  PRINT_FLAG                      VARCHAR2(1)
  BASE  RUN_ALONE_FLAG                  VARCHAR2(1)
  BASE  SRS_FLAG                        VARCHAR2(1)
  TRANS DESCRIPTION                     VARCHAR2(240)
    
  */
   num_lines := 3; 
  
   dbms_output.get_lines(lines, num_lines); 
   dbms_output.get_lines('CREATE BEGIN SELECT', num_lines); 
   --CREATE CREATE CREATE
   FOR i IN 1..num_lines LOOP 
      dbms_output.put_line(lines(i)); 
   END LOOP; 
END; 
/
