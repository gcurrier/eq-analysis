--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View V_LUNAR_RELATION
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "QUAKE"."V_LUNAR_RELATION" ("EQ_EVENT_ID", "EVENT_DATA_ID", "ID", "EVENT_TIME", "PLACE", "EVENT_TYPE", "MAGNITUDE", "DEPTH", "LONGITUDE", "LATITUDE", "MOON_DIST", "MOON_DECL", "MOON_RA", "EVENT_URL", "EVENT_DETAIL") AS 
  WITH a AS (
  SELECT eq_event_id,
         event_data_id,
         id,
         event_time,
         place,
         event_type,
         magnitude,
         depth,
         longitude,
         latitude,
         event_url,
         event_detail
  FROM eq_event
),b AS (
  SELECT eq_event_id,
         eq_event_time,
         usgs_id,
         moon_dist,
         moon_decl,
         moon_ra
  FROM event_moon_relation
) SELECT a.eq_event_id,
         a.event_data_id,
         a.id,
         a.event_time,
         a.place,
         a.event_type,
         a.magnitude,
         a.depth,
         a.longitude,
         a.latitude,
         b.moon_dist,
         b.moon_decl,
         b.moon_ra,
         a.event_url,
         a.event_detail
  FROM a
JOIN b ON a.id            = b.usgs_id
          AND a.eq_event_id   = b.eq_event_id
          and a.event_time = b.eq_event_time
ORDER BY 4 DESC
;
