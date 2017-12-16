--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type MOONPOS_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."MOONPOS_TYPE" 
   UNDER moonDist_ot
   (
      DIST_ID NUMBER(21),
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
      CONSTRUCTOR FUNCTION moonPos_type
         RETURN SELF AS RESULT
   )
   FINAL
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "QUAKE"."MOONPOS_TYPE" 
AS
   CONSTRUCTOR FUNCTION moonPos_type
      RETURN SELF AS RESULT
   IS
   BEGIN
      RETURN;
   END;
END;

/
