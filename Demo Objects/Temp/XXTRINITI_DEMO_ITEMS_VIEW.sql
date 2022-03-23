  CREATE OR REPLACE VIEW XXTRINITI_DEMO_ITEMS_VIEW AS
   SELECT ITEM_NUMBER,   
    DESCRIPTION,          
    TEMPLATE_NAME,            
    ORGANIZATION_CODE,          
    CREATION_DATE,             
    CREATED_BY,                                  
    PROCESS_FLAG,               
    ERR_MESSAGE, sysdate sys_date from XXTRINITI_DEMO_ITEMS_TABLE;
