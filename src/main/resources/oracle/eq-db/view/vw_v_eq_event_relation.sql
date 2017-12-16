--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View V_EQ_EVENT_RELATION
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "QUAKE"."V_EQ_EVENT_RELATION" ("ID", "PLACE", "EVENT_TIME", "LON", "LAT", "DPT", "MAG", "DIST") AS 
  SELECT DISTINCT id,
                     place,
                     event_time,
                     longitude lon,
                     latitude lat,
                     DEPTH dpt,
                     magnitude mag,
                     ROUND(moon_dist, 2) dist
       FROM eq_event_relation
   ORDER BY event_time DESC, TRIM(SUBSTR(place, INSTR(place, ',') + 1))

;
