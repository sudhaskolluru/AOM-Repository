  CREATE OR REPLACE EDITIONABLE FUNCTION "ADS_GETBASE64STRING" ( lv_blob blob )
Return clob is
Result clob;
Result1 clob;
resultString VARCHAR2(80);
resultString1 clob;
--l_amt number default 57;
l_amt number default 48;
l_amt1 number default 64;
l_raw raw(80);
buffer       VARCHAR2(300);
l_offset number default 1;
l_clob clob;
BEGIN
dbms_output.put_line( 'length blob: ' || dbms_lob.getlength( lv_blob )
);
begin
DBMS_LOB.CREATETEMPORARY(resultString1,FALSE,DBMS_LOB.CALL);
DBMS_LOB.CREATETEMPORARY(result,FALSE,DBMS_LOB.CALL);
loop
dbms_lob.read( lv_blob, l_amt, l_offset, l_raw );
l_offset := l_offset + l_amt;
resultString := utl_raw.cast_to_varchar2( utl_encode.base64_encode(l_raw ) );
--resultString := utl_raw.cast_to_varchar2( utl_encode.base64_encode(l_raw ) );
dbms_output.put_line( resultString);
resultString1:=to_clob(resultString);
dbms_lob.append(result,resultString1);
end loop;
exception
when no_data_found then
null;
end;
RETURN ( result);
END ads_getbase64String;
/
