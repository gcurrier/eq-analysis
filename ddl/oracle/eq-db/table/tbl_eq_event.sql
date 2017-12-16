--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EQ_EVENT
--------------------------------------------------------

  CREATE TABLE "QUAKE"."EQ_EVENT" 
   (	"EQ_EVENT_ID" NUMBER(*,0), 
	"EVENT_DATA_ID" VARCHAR2(100 CHAR), 
	"ID" VARCHAR2(50 CHAR), 
	"MAGNITUDE" NUMBER, 
	"PLACE" VARCHAR2(500 CHAR), 
	"EVENT_TIME" DATE, 
	"UPDATED" DATE, 
	"EVENT_TZ" NUMBER, 
	"FELT" NUMBER, 
	"CDI" NUMBER, 
	"MMI" NUMBER, 
	"ALERT" VARCHAR2(100 CHAR), 
	"TSUNAMI" NUMBER, 
	"SIG" NUMBER, 
	"NET" VARCHAR2(100 CHAR), 
	"CODE" VARCHAR2(100 CHAR), 
	"IDS" VARCHAR2(100 CHAR), 
	"SOURCES" VARCHAR2(100 CHAR), 
	"EVENT_TYPES" VARCHAR2(200 CHAR), 
	"NST" NUMBER, 
	"DMIN" NUMBER, 
	"RMS" NUMBER, 
	"GAP" NUMBER, 
	"MAGTYPE" VARCHAR2(100 CHAR), 
	"EVENT_TYPE" VARCHAR2(100 CHAR), 
	"LONGITUDE" VARCHAR2(100 CHAR), 
	"LATITUDE" VARCHAR2(100 CHAR), 
	"DEPTH" NUMBER, 
	"EVENT_URL" VARCHAR2(500 CHAR), 
	"EVENT_DETAIL" VARCHAR2(500 CHAR), 
	"EVENT_STATUS" VARCHAR2(100 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EQ_DATA" ;

   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EQ_EVENT_ID" IS 'EQ_EVENT_ID: Primary Key';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_DATA_ID" IS 'EVENT_DATA_ID: Foreign Key to EVENT_DATA table';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."ID" IS 'ID: A unique identifier for the event. This is the current preferred id for the event, and may change over time. ';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."MAGNITUDE" IS 'MAGNITUDE (MAG): The magnitude for the event. Learn more about magnitudes. (http://earthquake.usgs.gov/learn/glossary/?term=magnitude)';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."PLACE" IS 'PLACE: Textual description of named geographic region near to the event. This may be a city name, or a Flinn-Engdahl Region (http://earthquake.usgs.gov/learn/topics/flinn_engdahl.php) name.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_TIME" IS 'EVENT_TIME (TIME): Time when the event occurred. Times are reported in milliseconds since the epoch ( 1970              -01    -01T00:00:00.000Z), and do not include leap seconds. In certain output formats, the date is formatted for readability.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."UPDATED" IS 'UPDATED: Time when the event was most recently updated. Times are reported in milliseconds since the epoch. In certain output formats, the date is formatted for readability.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_TZ" IS 'EVENT_TZ (TZ): Timezone offset from UTC in minutes at the event epicenter.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."FELT" IS 'FELT: The total number of felt reports submitted to the DYFI? (http://earthquake.usgs.gov/research/dyfi/) system.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."CDI" IS 'CDI: The maximum reported intensity (http://earthquake.usgs.gov/learn/glossary/?term=intensity) for the event. Computed by DYFI (http://earthquake.usgs.gov/research/dyfi/). While typically reported as a roman numeral, for the purposes of this API, intensity is expected as the decimal equivalent of the roman numeral. Learn more about magnitude vs. intensity (http://earthquake.usgs.gov/learn/topics/mag_vs_int.php).';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."MMI" IS 'MMI: The maximum estimated instrumental intensity (http://earthquake.usgs.gov/learn/glossary/?term=intensity) for the event. Computed by ShakeMap (http://earthquake.usgs.gov/research/shakemap/). While typically reported as a roman numeral, for the purposes of this API, intensity is expected as the decimal equivalent of the roman numeral. Learn more about magnitude vs. intensity (http://earthquake.usgs.gov/learn/topics/mag_vs_int.php).';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."ALERT" IS 'ALERT: The alert level from the PAGER earthquake impact scale (http://earthquake.usgs.gov/research/pager/).    ';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."TSUNAMI" IS 'TSUNAMI: flag value (0: non-oceanic event, 1: event occurrence in oceanic region)';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."SIG" IS 'SIG: A number describing how significant the event is. Larger numbers indicate a more significant event. This value is determined on a number of factors, including: magnitude, maximum MMI, felt reports, and estimated impact.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."NET" IS 'NET: The ID of a data contributor. Identifies the network considered to be the preferred source of information for this event.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."CODE" IS 'CODE: identifying code assigned by event source';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."IDS" IS 'IDS: A comma-separated list of event ids that are associated to an event.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."SOURCES" IS 'SOURCES: comma separated list of network contributors';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_TYPES" IS 'TYPES: csv list of products associated with the event';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."NST" IS 'NST: The total number of Number of seismic stations which reported P- and S-arrival times for this earthquake.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."DMIN" IS 'DMIN: horizontal distance from epicenter to nearest sensor station (in degrees) ~111.2 km per degree (the smaller this number, the more accurate the depth value)';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."RMS" IS 'RMS: The root-mean-square (RMS) travel time residual, in sec, using all weights. This parameter provides a measure of the fit of the observed arrival times to the predicted arrival times for this location. Smaller numbers reflect a better fit of the data. The value is dependent on the accuracy of the velocity model used to compute the earthquake location, the quality weights assigned to the arrival time data, and the procedure used to locate the earthquake.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."GAP" IS 'GAP: The largest azimuthal gap between azimuthally adjacent stations (in degrees). In general, the smaller this number, the more reliable is the calculated horizontal position of the earthquake.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."MAGTYPE" IS 'MAGTYPE: The method or algorithm used to calculate the preferred magnitude for the event. Learn more about magnitude types (http://earthquake.usgs.gov/earthquakes/map/doc_aboutdata.php#magnitudes).';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_TYPE" IS 'EVENT_TYPE (TYPE): type of seismic event (EARTHQUAKE, QUARRY)';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."LONGITUDE" IS 'LONGITUDE: decimal degrees (negative values are western hemisphere)';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."LATITUDE" IS 'LATITUDE: decimal degrees (negative values are southern hemisphere)';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."DEPTH" IS 'DEPTH: depth in kilometers';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_URL" IS 'EVENT_URL (URL): Link to USGS Event Page for event.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_DETAIL" IS 'EVENT_DETAIL (DETAIL): Link to GeoJSON detail feed (http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson_detail.php) from a GeoJSON summary feed (http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php). NOTE: When searching and using geojson with callback, no callback is included in the detail url.';
   COMMENT ON COLUMN "QUAKE"."EQ_EVENT"."EVENT_STATUS" IS 'EVENT_STATUS (STATUS): indicates whether event has been reviewed by a human (AUTOMATIC,PUBLISHED,REVIEWED)';
   COMMENT ON TABLE "QUAKE"."EQ_EVENT"  IS 'EQ_EVENT: Stores row data of earthquake events (http://earthquake.usgs.gov)';
--------------------------------------------------------
--  DDL for Index EQ_EVENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "QUAKE"."EQ_EVENT_PK" ON "QUAKE"."EQ_EVENT" ("EQ_EVENT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EQ_IX" ;
--------------------------------------------------------
--  DDL for Index EQ_EVENT_IX1
--------------------------------------------------------

  CREATE INDEX "QUAKE"."EQ_EVENT_IX1" ON "QUAKE"."EQ_EVENT" ("MAGNITUDE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EQ_IX" ;
--------------------------------------------------------
--  DDL for Index EQ_EVENT_IX2
--------------------------------------------------------

  CREATE INDEX "QUAKE"."EQ_EVENT_IX2" ON "QUAKE"."EQ_EVENT" ("EVENT_TIME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EQ_IX" ;
--------------------------------------------------------
--  Constraints for Table EQ_EVENT
--------------------------------------------------------

  ALTER TABLE "QUAKE"."EQ_EVENT" MODIFY ("EQ_EVENT_ID" NOT NULL ENABLE);
  ALTER TABLE "QUAKE"."EQ_EVENT" MODIFY ("EVENT_DATA_ID" NOT NULL ENABLE);
  ALTER TABLE "QUAKE"."EQ_EVENT" ADD CONSTRAINT "EQ_EVENT_PK" PRIMARY KEY ("EQ_EVENT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EQ_IX"  ENABLE;
