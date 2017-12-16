BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"QUAKE"."RUN_EVENT_MOON_REL_DAILY_FILL"',
            job_type => 'PLSQL_BLOCK',
            job_action => '/*declare
begin
  PK_QUAKEDATA.LOAD_EVENTMOONRELATION;
end;*/
--PRAGMA autonomous_transaction may be useful here
DECLARE
  maxDate   DATE;
  startDate DATE;
  endDate   DATE;
  lastDate  DATE;
  cnt       NUMBER;
BEGIN
  dbms_output.enable(NULL);
  SELECT MAX(event_time) INTO maxDate FROM eq_event;
  SELECT MAX(eq_event_time) INTO startDate FROM event_moon_relation;
  SELECT COUNT(*) INTO cnt FROM eq_event where event_time >= (select max(eq_event_time) from event_moon_relation);
  cnt := round(cnt/120);
  EXECUTE IMMEDIATE ''alter session set nls_date_format = ''''rrrr-MM-DD hh24:mi:ss'''''';
  EXECUTE IMMEDIATE ''alter session set nls_time_format = ''''"T"HH24:MI:SS'''''';
  EXECUTE IMMEDIATE ''alter session set plscope_settings=''''identifiers:all'''''';
  FOR i IN 1 .. cnt
  LOOP
    if endDate is null -- occurs only on first iteration
    then
      if maxDate > startDate --if max date in eq_event table is younger than max date in event_moon_relation table
      then
        endDate := startDate + 120; --use initial startDate date
      end if;
    else -- otherwise, if endDate is not null (on recurring iterations)
      startDate := endDate; -- reset startDate to last date used
      endDate   := startDate + 120; --reset endDate, adding 120 days
    end if;
    EXIT WHEN startDate > maxDate;
    INSERT INTO event_moon_relation
      SELECT sys_guid(),
             event_data_id,
             eq_event_id,
             id,
             event_time,
             pk_astrocalc.getlunarvalue(event_time,''DIST''),
             pk_astrocalc.getlunarvalue(event_time,''LAT''),
             pk_astrocalc.getlunarvalue(event_time,''LON''),
             systimestamp
      FROM eq_event
      WHERE event_time between startDate and endDate;
      dbms_output.put_line(startDate||'': inserted ''||SQL%rowcount||'' rows.'');
    COMMIT;
  END LOOP;
exception
  when others then
    dbms_output.put_line(SQLERRM);
END;',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2017-10-25 00:00:00.000000000 +02:00','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => NULL,
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Fills the EVENT_MOON_RELATION table.');
END;
