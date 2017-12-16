--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKGUTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."PKGUTIL" 
IS
   pi    CONSTANT NUMBER := 3.1415926535897932384626433832;

   TYPE eq_counter_type IS RECORD
   (
      place          VARCHAR2(150 CHAR),
      event_day      DATE,
      eq_cnt         NUMBER,
      low_mag        NUMBER,
      avg_mag        NUMBER,
      max_mag        NUMBER,
      low_dist       NUMBER,
      avg_dist       NUMBER,
      max_dist       NUMBER
   );

   TYPE eq_counter_tab IS TABLE OF eq_counter_type;

   FUNCTION to_time(pdate IN DATE)
      RETURN VARCHAR2;

   FUNCTION to_time_f(pdate IN DATE)
      RETURN NUMBER;

   FUNCTION to_julian(pdate IN DATE)
      RETURN NUMBER;

   FUNCTION degReduce(pNum IN NUMBER)
      RETURN NUMBER;

   FUNCTION deg2Rad(p_degree IN NUMBER)
      RETURN NUMBER;

   FUNCTION rad2Deg(p_rad IN NUMBER)
      RETURN NUMBER;

   FUNCTION dec2dms(p_dec IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION dms2dec(pDMS IN VARCHAR2)
      RETURN NUMBER;
END;

/
