BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"QUAKE"."INITIALIZE_EVENT_MOON_REL"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'declare
begin
  pk_QuakeData.initialize_EventMoonRelation;
end;',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2017-10-25 00:00:00.000000000 +02:00','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => NULL,
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Fills the EVENT_MOON_RELATION table.');
END;
