--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKGUTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "QUAKE"."PKGUTIL" 
IS
   FUNCTION to_time(pdate IN DATE)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN TO_CHAR(pdate, 'hh24:mi:ss');
   END;

   FUNCTION to_time_f(pdate IN DATE)
      RETURN NUMBER
   IS
      vfraction      NUMBER;
   BEGIN
      vfraction   :=
           TO_NUMBER(TO_CHAR(pdate, 'hh24')) / 24
         + TO_NUMBER(TO_CHAR(pdate, 'mi')) / 1440
         + TO_NUMBER(TO_CHAR(pdate, 'ss')) / 86400;
      RETURN ROUND(vfraction, 18);
   END;

   FUNCTION to_julian(pdate IN DATE)
      RETURN NUMBER
   IS
      vTimeFraction  NUMBER;
      yr_a           NUMBER;
      yr_b           NUMBER;
      dy             NUMBER;
      mth            NUMBER;
      yr             NUMBER;
      jd             NUMBER;
   BEGIN
      yr          := EXTRACT(YEAR FROM pdate);
      mth         := EXTRACT(MONTH FROM pdate);
      dy          := EXTRACT(DAY FROM pdate);
      yr_a        := TRUNC(yr / 100);
      yr_b        := 2 - yr_a + TRUNC(yr_a / 4);
      vTimeFraction := to_time_f(pdate);

      -- adjustment for leap years
      IF mth > 2
      THEN
         jd          :=
              TRUNC(365.25 * (yr + 4716))
            + TRUNC(30.6001 * (mth + 1))
            + dy
            + yr_b
            - 1524.5
            + vTimeFraction;
      ELSE
         IF mth IN (1, 2)
         THEN
            yr          := yr - 1;
            mth         := mth + 12;
            jd          :=
                 TRUNC(365.25 * (yr + 4716))
               + TRUNC(30.6001 * (mth + 1))
               + dy
               + yr_b
               - 1524.5
               + vTimeFraction;
         END IF;
      END IF;

      RETURN jd;
   END;

   FUNCTION degReduce(pNum IN NUMBER)
      RETURN NUMBER
   IS
      c              NUMBER;
      deg            NUMBER;
   BEGIN
      IF pNum < 0
      THEN
         c           := ABS(TRUNC(pNum / 360)) + 1;
         deg         := pNum + (c * 360);
      ELSE
         c           := ABS(TRUNC(pNum / 360));
         deg         := pNum - (c * 360);
      END IF;

      RETURN deg;
   END degReduce;

   FUNCTION deg2Rad(p_degree IN NUMBER)
      RETURN NUMBER
   IS
      rad            NUMBER;
   BEGIN
      rad         := p_degree * (pi / 180);
      RETURN rad;
   END deg2rad;

   FUNCTION rad2Deg(p_rad IN NUMBER)
      RETURN NUMBER
   IS
      deg            NUMBER;
   BEGIN
      deg         := p_rad * (180 / pi);
      RETURN deg;
   END;

   FUNCTION dec2dms(p_dec IN NUMBER)
      RETURN VARCHAR2
   IS
      v_deg          NUMBER;
      v_min          NUMBER;
      v_sec          NUMBER;
      v_symbol       VARCHAR2(1 CHAR);
      v_dms          VARCHAR2(50 CHAR);
   BEGIN
      v_deg       := TRUNC(ABS(p_dec));
      v_min       := TRUNC((ABS(p_dec) - v_deg) * 60);
      v_sec       := ROUND(60 / ((((ABS(p_dec) - v_deg) * 60) - v_min) * 100), 2);

      IF p_dec < 0
      THEN
         v_symbol    := '-';
      ELSE
         v_symbol    := NULL;
      END IF;

      v_dms       :=
            v_symbol
         || v_deg
         || ' '
         || v_min
         || ' '
         || v_sec;
      RETURN v_dms;
   END dec2dms;

   -- expected format is DDDdMMmSS.SSSs
   FUNCTION dms2dec(pDMS IN VARCHAR2)
      RETURN NUMBER
   IS
      vDeg           NUMBER;
      vMin           NUMBER;
      vSec           NUMBER;
   BEGIN
      vDeg        := TO_NUMBER(REPLACE(REGEXP_SUBSTR(pDMS, '\D[[:digit:]]{1,3}d'), 'd'));
      vMin        := TO_NUMBER(REPLACE(REGEXP_SUBSTR(pDMS, '[[:digit:]]{1,2}m'), 'm'));
      vSec        := TO_NUMBER(REPLACE(REGEXP_SUBSTR(pDMS, '(\d\d\D[[:digit:]]{1,6})s'), 's'));

      IF vDeg < 0
      THEN
         vDeg        := vDeg - (vMin / 60) - (vSec / 3600);
      ELSE
         vDeg        := vDeg + (vMin / 60) + (vSec / 3600);
      END IF;

      RETURN vDeg;
   END dms2dec;
BEGIN
   NULL;
END;

/
