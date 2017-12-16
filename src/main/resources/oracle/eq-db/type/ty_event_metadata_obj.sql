--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type EVENT_METADATA_OBJ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."EVENT_METADATA_OBJ" AS OBJECT
(
   gen_date DATE,
   meta_url VARCHAR2(500 CHAR),
   title VARCHAR2(500 CHAR),
   fetch_status VARCHAR2(100 CHAR),
   api VARCHAR2(50 CHAR),
   eq_count NUMBER
)

/
