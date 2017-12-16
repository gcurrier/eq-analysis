--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type MOONDIST_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."MOONDIST_TYPE" 
   UNDER moonDist_ot
   (
      DIST_ID NUMBER(21),
      DIST_TOPO NUMBER,
      DIST_GRP NUMBER,
      DIST_GRP_AVG NUMBER,
      MVMT_DIRECTION VARCHAR2(10 CHAR),
      KM_MINUTE NUMBER,
      KM_HOUR NUMBER,
      CONSTRUCTOR FUNCTION moonDist_type
         RETURN SELF AS RESULT
   )
   FINAL
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "QUAKE"."MOONDIST_TYPE" 
AS
   CONSTRUCTOR FUNCTION moonDist_type
      RETURN SELF AS RESULT
   IS
   BEGIN
      RETURN;
   END;
END;

/
