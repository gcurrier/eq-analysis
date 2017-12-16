--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body EQ_RELATION_DATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "QUAKE"."EQ_RELATION_DATA" 
AS
   FUNCTION getData(pLoDateOfEvent   IN DATE,
                    pHiDateOfEvent   IN DATE,
                    pLoMag           IN NUMBER,
                    pHiMag           IN NUMBER,
                    pLocation        IN VARCHAR2 DEFAULT '%',
                    pCountry         IN VARCHAR2 DEFAULT '%')
      RETURN eqRelation_table
      PIPELINED
   IS
      TYPE rc IS REF CURSOR;

      r_type         rc;
      xOut           eqRelation_type;
      xStmt          VARCHAR2(4000 CHAR);
   BEGIN
      xStmt       :=
         q'[select distinct id,
                trim(substr(substr(place, instr(place, 'of') + 3), 1, instr(substr(place, instr(place, 'of') + 3), ',') - 1)) city,
                case
                  when trim(substr(place, instr(place, ',') + 1)) = 'CA' then
                   ''California''
                  else
                   trim(substr(place, instr(place, ',') + 1))
                end location,
                case
                  when trim(substr(place, instr(place, ',') + 1)) in ('Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','District of Columbia','Florida','Georgia','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Pennsylvania','Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming') then
                   'US'
                  else
                   null
                end country,
                place epicenter,
                event_time,
                longitude,
                latitude,
                depth,
                magnitude magnitude,
                round(moon_dist, 2) moon_distance,
								null err
  from eq_event_relation
	where event_time between #pLoDateOfEvent# and #pHiDateOfEvent#
	and mag between #pLoMag# and #pHiMag#
	and location like '#pLocation#'
	and country like '#pCountry#'
 order by event_time desc,
          trim(substr(place, instr(place, ',') + 1))]';

      xStmt       := REPLACE(xStmt, '#pLoDateOfEvent#', pLoDateOfEvent);
      xStmt       := REPLACE(xStmt, '#pHiDateOfEvent#', pHiDateOfEvent);
      xStmt       := REPLACE(xStmt, '#pLoMag#', pLoMag);
      xStmt       := REPLACE(xStmt, '#pHiMag#', pHiMag);
      xStmt       := REPLACE(xStmt, '#pLocation#', pLocation);
      xStmt       := REPLACE(xStmt, '#pCountry#', pCountry);

      OPEN r_type FOR xStmt;

      LOOP
         FETCH r_type
            INTO xOut.id,
                 xOut.city,
                 xOut.location,
                 xOut.country,
                 xOut.epicenter,
                 xOut.event_time,
                 xOut.longitude,
                 xOut.latitude,
                 xOut.DEPTH,
                 xOut.magnitude,
                 xOut.moon_distance,
                 xOut.err;

         EXIT WHEN r_type%NOTFOUND;
         PIPE ROW (xOut);
      END LOOP;

      CLOSE r_type;

      RETURN;
   EXCEPTION
      WHEN OTHERS
      THEN
         xStmt       :=
               SQLERRM
            || CHR(10)
            || DBMS_UTILITY.format_error_backtrace;

         LOOP
            EXIT WHEN LENGTH(xStmt) IS NULL;
            xStmt       := SUBSTR(xStmt, 199);
            PIPE ROW (xOut);
         END LOOP;
   END;
END EQ_RELATION_DATA;

/
