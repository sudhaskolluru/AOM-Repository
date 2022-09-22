CREATE OR REPLACE FUNCTION "BOOL_TO_CHAR" (p_bool in boolean)
return varchar2
is
l_chr  varchar2(1) := null;
begin
l_chr := (CASE p_bool when true then 'Y' ELSE 'N' END);
return(l_chr);
end;
/