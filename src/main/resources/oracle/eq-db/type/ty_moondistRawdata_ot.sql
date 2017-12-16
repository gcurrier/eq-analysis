--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type MOONDISTRAWDATA_OT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."MOONDISTRAWDATA_OT" 
   UNDER moonDist_ot
   (
      DIST_ID NUMBER(21),
      MOON_DATE VARCHAR2(30 CHAR),
      MOON_RA VARCHAR2(20 CHAR),
      MOON_DECL VARCHAR2(20 CHAR),
      MOON_TOPO_DIST VARCHAR2(20 CHAR),
      MOON_YEAR NUMBER(4),
      MOON_MONTH NUMBER(2),
      CONSTRUCTOR FUNCTION moonDistRawData_ot
         RETURN SELF AS RESULT
   )
   FINAL
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "QUAKE"."MOONDISTRAWDATA_OT" 
AS
   CONSTRUCTOR FUNCTION moonDistRawData_ot
      RETURN SELF AS RESULT
   IS
   BEGIN
      RETURN;
   END;
END;

/
