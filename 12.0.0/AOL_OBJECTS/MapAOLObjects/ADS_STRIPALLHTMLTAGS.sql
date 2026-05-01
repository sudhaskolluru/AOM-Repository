  CREATE OR REPLACE EDITIONABLE FUNCTION "ADS_STRIPALLHTMLTAGS" (
   p_HTMLString   IN CLOB
 )
 RETURN CLOB
 IS
   v_GoodHTML CLOB;
 BEGIN
   v_GoodHTML := p_HTMLString;
   v_GoodHTML := REPLACE(v_GoodHTML, '&'||'amp;', '&');
   v_GoodHTML := REPLACE(v_GoodHTML, '&'||'nbsp;', ' ');
   v_GoodHTML := REPLACE(v_GoodHTML, '&'||'quot;', '''');
   OWA_PATTERN.CHANGE(v_GoodHTML, '<[^>]+>','','gi');
   OWA_PATTERN.CHANGE(v_GoodHTML, '\'||'&[^;]+;', ' ', 'gi');
   RETURN v_GoodHTML;
 END ADS_STRIPALLHTMLTAGS;
/
