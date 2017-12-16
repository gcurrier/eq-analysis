--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type MOONDIST_TRANSFORM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."MOONDIST_TRANSFORM" 
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
      RIGHT_ASCENSION VARCHAR2(20 BYTE),
      RA_DEG NUMBER,
      RA_MIN NUMBER,
      RA_SEC NUMBER,
      RA_DEG_MINUTE NUMBER,
      RA_DEG_MVMT_PERMINUTE NUMBER,
      DECLINATION VARCHAR2(20 CHAR),
      DECL_DEGREE NUMBER,
      DECL_MINUTE NUMBER,
      DECL_SECOND NUMBER,
      DECL_DEG NUMBER,
      DECL_MVMT VARCHAR2(10 CHAR),
      DIST_TOPO NUMBER,
      DIST_GRP NUMBER,
      DIST_GRP_AVG NUMBER,
      MVMT_DIRECTION VARCHAR2(10 CHAR),
      KM_MINUTE NUMBER,
      KM_HOUR NUMBER,
      CONSTRUCTOR FUNCTION moonDist_transform
         RETURN SELF AS RESULT
   )
   FINAL
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "QUAKE"."MOONDIST_TRANSFORM" 
AS
   CONSTRUCTOR FUNCTION moonDist_transform
      RETURN SELF AS RESULT
   IS
   BEGIN
      RETURN;
   END;
END;

/
