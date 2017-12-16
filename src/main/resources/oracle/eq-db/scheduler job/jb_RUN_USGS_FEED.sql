BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"QUAKE"."RUN_USGS_FEED"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'declare
  iterations number;
  daysDiff   number;
begin
/*  with a as
   (select max(event_time) evt, sysdate syst from eq_event)
  select syst - evt, round((syst - evt) / 30)
    into daysDiff, iterations
    from a;
  for i in 1 .. iterations
  loop*/
    pk_quakedata.loadFeedAuto(30);
/*  end loop;
    pk_quakedata.loadFeedAuto(30);*/
    /* load the event_moon_relation table with current relation data from eq_event */
		/*pk_quakedata.load_eventmoonrelation;*/
end;',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2016-10-18 18:00:00.000000000 +02:00','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'Freq=DAILY',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Job that starts the extraction process from http://earthquake.usgs.gov');
    DBMS_SCHEDULER.enable(
             name => '"QUAKE"."RUN_USGS_FEED"');
END;