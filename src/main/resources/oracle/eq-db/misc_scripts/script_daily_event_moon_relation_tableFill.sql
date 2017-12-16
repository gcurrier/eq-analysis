declare
  relId     varchar2(100 char);
  pDate     DATE;
  startDate date;
  endDate   date;
  dayRange  number := 60;

begin
  select max(eq_event_time) into pDate from event_moon_relation;
  if pDate is null
  then
    startDate := to_date('1900-01-01T00:00:01',
                         'rrrr-mm-dd"T"hh24:mi:ss');
  else
    startDate := pDate;
  end if;
  endDate := startDate + dayRange;
  relId   := sys_guid();
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
     where event_time between startDate and endDate;
  commit;
end;
