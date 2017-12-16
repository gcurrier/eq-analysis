--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function EQ_COUNTER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "QUAKE"."EQ_COUNTER" (xPlace IN VARCHAR2, xYear IN NUMBER)
   RETURN pkgutil.eq_counter_tab
   PIPELINED
IS
   xOut           pkgutil.eq_counter_type;

   CURSOR c1(cPlace IN VARCHAR2, cYear IN NUMBER)
   IS
      WITH q1
           AS (  SELECT TRIM(SUBSTR(place, INSTR(place, ',', -1) + 1)) place,
                        event_time,
                        longitude,
                        latitude,
                        DEPTH,
                        magnitude,
                        ROUND(moon_dist, 2) moon_dist
                   FROM eq_event_relation
               ORDER BY event_time DESC)
        SELECT place,
               TRUNC(event_time) event_day,
               COUNT(*) eq_cnt,
               MIN(magnitude) low_mag,
               ROUND(AVG(magnitude), 2) avg_mag,
               MAX(magnitude) max_mag,
               MIN(moon_dist) low_dist,
               ROUND(AVG(moon_dist), 2) avg_dist,
               MAX(moon_dist) max_dist
          FROM q1
         WHERE     EXTRACT(YEAR FROM event_time) >= cYear
               AND magnitude IS NOT NULL
               AND place LIKE cPlace
      GROUP BY place, TRUNC(event_time)
      ORDER BY TRUNC(event_time);

BEGIN
   OPEN c1(xPlace, xYear);

   LOOP
      FETCH c1 INTO xOut;

      EXIT WHEN c1%NOTFOUND;
      PIPE ROW (xOut);
   END LOOP;

   RETURN;
END;

/
