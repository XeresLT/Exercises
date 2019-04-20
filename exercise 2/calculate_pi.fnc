create or replace function calculate_pi(p_precision in integer) return number is
  l_pi number := 0;
  l_intermediate_result number;
  l_power_value number;
 
begin
  execute immediate 'truncate table PI_COUNT';
  for i in 0..p_precision loop
    l_power_value := power(16,i);
    l_intermediate_result := (1/l_power_value*(4/(8*i+1)-2/(8*i+4)-1/(8*i+5)-1/(8*i+6)));
    insert into PI_COUNT(RUN_SEQ, RESULT)values(i,l_intermediate_result);
    commit;
    l_pi := l_pi + l_intermediate_result;
  end loop;
  return l_pi;
  exception when others then
    dbms_output.put_line('Number precision too large');
    return null;
end calculate_pi;
/
