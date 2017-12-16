--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type MOONDATE_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."MOONDATE_TYPE" 
   UNDER moonDist_ot
   (
      DIST_ID NUMBER(21),
      YR_GRP NUMBER,
      MOON_J_DATE_DEC NUMBER,
      MOON_JDATE VARCHAR2(10 CHAR),
      MOON_DATE DATE,
      MTH_YR VARCHAR2(35 CHAR),
      YR NUMBER(4),
      MTH VARCHAR2(25 CHAR),
      DY VARCHAR2(25 CHAR),
      HR VARCHAR2(2 CHAR),
      MN VARCHAR2(2 CHAR),
      TME VARCHAR2(10 CHAR),
      CONSTRUCTOR FUNCTION moonDate_type
         RETURN SELF AS RESULT
   )
   FINAL
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "QUAKE"."MOONDATE_TYPE" 
AS
   CONSTRUCTOR FUNCTION moonDate_type
      RETURN SELF AS RESULT
   IS
   BEGIN
      RETURN;
   END;
END;

/
