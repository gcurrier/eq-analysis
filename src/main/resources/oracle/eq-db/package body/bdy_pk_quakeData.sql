--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PK_QUAKEDATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."PK_QUAKEDATA" IS

  type evMoonRel_tab is table of event_moon_relation%rowtype;
  evMoonRel evMoonRel_tab;
  type eqEvent_tab is table of eq_event%rowtype;
  eqEvent eqEvent_tab;

  /* Returns the gFormat (feed format) global variable.*/
  FUNCTION get_gformat RETURN VARCHAR2;

  /* Returns the gTo variable, a string representation of the "to" date limit. */
  FUNCTION get_todate RETURN VARCHAR2;
  /* Returns the gFrom variable, a string representation of the "to" date limit */
  FUNCTION get_fromdate RETURN VARCHAR2;
  /* Returns the gFeed variable, the REST feed to use */
  FUNCTION get_feed RETURN VARCHAR2;
  /* Returns the gEventDataID variable, a sys_guid() object. Used as a manual primary key generator. */
  FUNCTION get_eventdataid RETURN VARCHAR2;
  /* Returns the gNumDays variable, containing the difference in days between gFrom and gTo */
  FUNCTION get_numdays RETURN VARCHAR2;
  /* Sets the gTo variable by adding the gNumDays to the gFrom date, and sets the rest of the global variables accordingly. Called from the loadFeedAuto procedure. */
  PROCEDURE getnextdates;
  /* Set variables and call USGS feed using defaults (past 30 days starting from the last event_time recorded). */
  PROCEDURE loadfeedauto(numdays NUMBER);
  /* Load the a table, depending on the feed, starting from specified dates using specific return data format and URL. */
  PROCEDURE loadfeed(pformat IN VARCHAR2,
                     pfrom   IN VARCHAR2,
                     pto     IN VARCHAR2,
                     pfeed   IN VARCHAR2);
  /* The USGS event feed method (returns earthquake data).  */
  FUNCTION getusgs_eventfeed RETURN CLOB;
  /* Load the EQ_Events table. Data Transformation from EVENT_DATA.EVENT_CLOB (geojson) data. */
  PROCEDURE loadusgs_eqevents(peventdataid IN VARCHAR2 DEFAULT NULL);
  /* Loads the EVENT_DATA table. Called while returning USGS feed data. */
  PROCEDURE loadusgs_eventdata;
END pk_quakedata;

/
