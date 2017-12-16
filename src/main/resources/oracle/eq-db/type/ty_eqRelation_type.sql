--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type EQRELATION_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "QUAKE"."EQRELATION_TYPE" as object
(
  id            VARCHAR2(20),
  city          VARCHAR2(30 CHAR),
  location      VARCHAR2(30 CHAR),
  country       VARCHAR2(30 CHAR),
  epicenter     VARCHAR2(100 CHAR),
  event_time    DATE,
  longitude     NUMBER,
  latitude      NUMBER,
  DEPTH         NUMBER,
  magnitude     NUMBER,
  moon_distance NUMBER,
  err           VARCHAR2(1000 CHAR)
)

/
