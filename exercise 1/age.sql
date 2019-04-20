SET SERVEROUTPUT ON
SET VERIFY OFF 

DEFINE i_age  = '&&AGE'
BEGIN
   CASE
      WHEN '&i_age' < 0 THEN
         Dbms_output.put_line('Age can''t be negative');
      WHEN '&i_age' < 7 THEN
         Dbms_output.put_line('You are infant');
      WHEN trunc('&i_age') BETWEEN 7 AND 17 THEN
         Dbms_output.put_line('You are schoolchild');
      WHEN trunc('&i_age') BETWEEN 18 AND 39 THEN
         Dbms_output.put_line('You are adult');
      WHEN trunc('&i_age') BETWEEN 40 AND 54 THEN
         Dbms_output.put_line('You are in middle-age');
      WHEN trunc('&i_age') >= 55 THEN
         Dbms_output.put_line('You are aged');
   END CASE;
EXCEPTION
   WHEN OTHERS THEN
      Dbms_output.put_line('"'||'&i_age' || '" is not a valid age');
END;
/
EXIT;
/
