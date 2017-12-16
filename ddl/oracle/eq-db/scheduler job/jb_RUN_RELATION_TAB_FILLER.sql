BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"QUAKE"."RUN_RELATION_TAB_FILLER"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'declare
  cursor c1 is
    select event_data_id,
           id,
           place,
           event_time,
           longitude,
           latitude,
           depth,
           magnitude,
           null moon_dist,
           null yr,
           null mth
      from eq_event;
  type type_c1 is table of eq_event_relation%rowtype index by PLS_INTEGER;
  xOut type_c1;
begin
  open c1;
  fetch c1 bulk collect into xOut;
  forall i in 1 .. xOut.count save exceptions
    insert into eq_event_relation
      (event_data_id,
       id,
       place,
       event_time,
       latitude,
       longitude,
       depth,
       magnitude,
       moon_dist,
       yr,
       mth)
    values
      (xOut(i).event_data_id,
       xOut(i).id,
       xOut(i).place,
       xOut(i).event_time,
       xOut(i).latitude,
       xOut(i).longitude,
       xOut(i).depth,
       xOut(i).magnitude,
       pk_astrocalc.getLunarValue(xOut(i).event_time, ''DIST''),
       extract(year from xOut(i).event_time),
       extract(month from xOut(i).event_time));
  commit;
  dbms_scheduler.run_job(''RUN_EVENT_MOON_REL_DAILY'');
exception
  when others then
    for x in 1 .. sql%bulk_exceptions.count
    loop
      dbms_output.put_line(SQL%BULK_EXCEPTIONS(x).ERROR_INDEX || '': '' || SQL%BULK_EXCEPTIONS(x)
                           .ERROR_CODE);
    end loop;
    dbms_output.put_line(dbms_utility.format_error_backtrace);
end;',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2016-05-29 00:00:00.000000000 +02:00','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=DAILY;BYTIME=180000',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => '');
    DBMS_SCHEDULER.enable(
             name => '"QUAKE"."RUN_RELATION_TAB_FILLER"');
END;
