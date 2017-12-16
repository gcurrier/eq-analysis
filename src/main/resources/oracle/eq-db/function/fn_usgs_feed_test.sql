--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function USGS_FEED_TEST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "QUAKE"."USGS_FEED_TEST" (fromDate in VARCHAR2,
                                          toDate   in VARCHAR2,
                                          resLimit VARCHAR2) RETURN CLOB IS
  vUrl VARCHAR2(500 CHAR) := 'https://earthquake.usgs.gov/fdsnws/event/1/query?limit=' ||
                             resLimit;
  -- format types: geojson,quakeml,text,xml
  vFormat VARCHAR2(30 CHAR) := 'format=geojson';
  -- iso8601 date format
  vFrom     VARCHAR2(30 CHAR) := 'starttime=' || fromDate; --2016-06-20T09:28:25';
  vTo       VARCHAR2(30 CHAR) := 'endtime=' || toDate; --2016-06-21T09:28:25';
  vDataClob CLOB;
  vPieces   UTL_HTTP.html_pieces;
BEGIN
	UTL_HTTP.set_wallet('file:E:\u01\app\oracle\product\12.2.0\dbhome_1\owm','!sT1x_n_St0n3s@');
  vUrl    := vUrl || CHR(38) || vFormat || CHR(38) || vFrom || CHR(38) || vTo;
  vPieces := UTL_HTTP.request_pieces(vUrl);

  FOR i IN 1 .. vPieces.COUNT
  LOOP
    vDataClob := vDataClob || vPieces(i);
  END LOOP;
  RETURN vDataClob;
END;

/
