declare
  dayRange number := 60;
  ttl      number;
  loops    number;
  outDate  date;
  nextDate;
begin
  -- get total number of rows
  select count(*) into ttl from eq_event;
  -- divide by day range to give a number of row sets
  loops := round(ttl / dayRange);
  for i in 1 .. loops
  loop
    if i = 1
    then
      -- fill the table by date range and receive the "nextDate" output from the procedure /
      pk_QuakeData.load_eventMoonRelation(null,
                                          dayRange,
                                          outDate);
    else
      nextDate := outDate;
      pk_QuakeData.load_eventMoonRelation(nextDate,
                                          dayRange,
                                          outDate);
    end if;
  end loop;
  -- pickup the left-over rows 
  pk_QuakeData.load_eventMoonRelation(nextDate,
                                      dayRange);
end;
