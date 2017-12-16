--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function PREPFEEDDATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "QUAKE"."PREPFEEDDATA" 

insert into event_data(event_data_id ,
fetch_time    ,
time_from   ,
time_to     ,
gen_date    ,
feed_url    ,
title     ,
fetch_status  ,
api       ,
eq_count    ,
event_datatype  ,
event_clob
)
select *
    from (select null,null,to_char(to_date('1900-01-01T00:00:00','rrrr-mm-dd"T"hh24:mi:ss'),'rrrr-mm-dd"T"hh24:mi:ss') time_from,
                 to_char(to_date('1950-01-01T00:00:00','rrrr-mm-dd"T"hh24:mi:ss'),'rrrr-mm-dd"T"hh24:mi:ss') time_to,
                 null,
                 null,
                 null,
                 null,
                 null,
                 null
                 null,
                 pk_quakeData.getUSGS_EqFeed(pFormat => 'geojson',
                                             pFrom   => to_date('1900-01-01','yyyy-mm-dd'),
                                             pTo     => to_date('1950-01-01','yyyy-mm-dd')) );

/
