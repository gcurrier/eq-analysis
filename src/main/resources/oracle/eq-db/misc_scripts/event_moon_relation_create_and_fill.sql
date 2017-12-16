/*CREATE TABLE "QUAKE"."EVENT_MOON_RELATION" 
   (  "REL_ID" VARCHAR2(100 CHAR) NOT NULL ENABLE, 
  "EVENT_DATA_ID" VARCHAR2(50 CHAR), 
  "EQ_EVENT_ID" VARCHAR2(50 CHAR), 
  "USGS_ID" VARCHAR2(50 CHAR), 
  "EQ_EVENT_TIME" DATE, 
  "MOON_DIST" NUMBER, 
  "MOON_DECL" NUMBER, 
  "MOON_RA" NUMBER
   )
  TABLESPACE "EQ_DATA" ;
  
  CREATE INDEX "QUAKE"."EV_MOON_REL_EV_DATA_ID_IX1" ON "QUAKE"."EVENT_MOON_RELATION" ("EVENT_DATA_ID") TABLESPACE "EQ_IX" ;
  CREATE INDEX "QUAKE"."EV_MOON_REL_USGS_ID_IX2" ON "QUAKE"."EVENT_MOON_RELATION" ("USGS_ID") TABLESPACE "EQ_IX" ;*/


declare
  relId         varchar2(100 char);
  startReadDate date;
  function getStartDate return date is
    startDate date;
  begin
    select max(eq_event_time) into startDate from event_moon_relation;
    if startDate is null
    then
      startDate := to_date('1/1/1900 12:00:00 AM',
                           'mm/dd/rrrr hh:mi:ss AM');
      dbms_output.put_line('Start read date-time (DEFAULT): ' || startDate);
    else
      dbms_output.put_line('Start read date-time (FOUND): ' || startDate);
    end if;
    return startDate;
  end;

begin
  /* Set NLS and session environment variables */
  execute immediate 'alter session set nls_date_format = ''YYYY-MM-DD''';
  execute immediate 'alter session set nls_time_format = ''"T"HH24:MI:SS''';
  execute immediate 'alter session set plscope_settings=''identifiers:all''';
  relId         := sys_guid();
  startReadDate := getStartDate();
  insert into event_moon_relation
    (rel_id,
     event_data_id,
     eq_event_id,
     usgs_id,
     eq_event_time,
     moon_dist,
     moon_decl,
     moon_ra)
    select relId,
           event_data_id,
           eq_event_id,
           id,
           event_time,
           pk_astrocalc.getLunarValue(event_time,
                                      'DIST'),
           pk_astrocalc.getLunarValue(event_time,
                                      'LAT'),
           pk_astrocalc.getLunarValue(event_time,
                                      'LON')
      from eq_event
     where event_time between startReadDate and startReadDate + 10;
  commit;
exception
  when others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
