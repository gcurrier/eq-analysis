--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View V_EVENTS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "QUAKE"."V_EVENTS" ("PLACE", "MAGNITUDE", "DEPTH", "LATITUDE", "LONGITUDE", "EVENT_TIME", "MTH", "WK_NUM", "MONTH_NUM", "YEAR_NUM") AS 
  SELECT TRIM(SUBSTR(place, INSTR(place, ',') + 1)) place,
            magnitude,
            DEPTH,
            latitude,
            longitude,
            event_time,
            TO_CHAR(event_time, 'Month') mth,
            TO_CHAR(event_time, 'W') wk_num,
            EXTRACT(MONTH FROM event_time) month_num,
            EXTRACT(YEAR FROM event_time) year_num
       FROM eq_event
   ORDER BY event_time DESC

;
