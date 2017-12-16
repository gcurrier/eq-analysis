--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package EQ_RELATION_DATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."EQ_RELATION_DATA" AS
/*  TYPE eqRelationRow IS RECORD(
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
    err           VARCHAR2(1000 CHAR));

  TYPE eqRelationTab IS TABLE OF eqRelationRow INDEX BY binary_INTEGER;*/

  FUNCTION getData(pLoDateOfEvent IN DATE,
                   pHiDateOfEvent IN DATE,
                   pLoMag         IN NUMBER,
                   pHiMag         IN NUMBER,
                   pLocation      IN VARCHAR2 DEFAULT '%',
                   pCountry       IN VARCHAR2 DEFAULT '%')
    RETURN eqRelation_table
    PIPELINED;
END EQ_RELATION_DATA;

/
