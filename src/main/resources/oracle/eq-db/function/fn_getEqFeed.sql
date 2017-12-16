--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function GETEQFEED
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "QUAKE"."GETEQFEED" 
   RETURN CLOB
IS
   vUrl           VARCHAR2(500 CHAR) := 'http://earthquake.usgs.gov/fdsnws/event/1/query?';

   vFormat        VARCHAR2(30 CHAR) := 'format=geojson';

   vFrom          VARCHAR2(30 CHAR)
                     :=    CHR(38)
                        || 'starttime=2015-05-13T00:00:00';
   vTo            VARCHAR2(30 CHAR)
                     :=    CHR(38)
                        || 'endtime=2015-05-13T23:59:59';
   vLength        PLS_INTEGER;
   vText          VARCHAR2(32767);
   vHttpReq       UTL_HTTP.req;
   vHttpResp      UTL_HTTP.resp;
   vDataClob      CLOB;
   vPieces        UTL_HTTP.html_pieces;
BEGIN
   DBMS_LOB.createtemporary(vDataClob, FALSE);
   vUrl        :=
         vUrl
      || vFormat
      || vFrom
      || vTo;
   vPieces     := UTL_HTTP.request_pieces(vUrl);

   vLength     := 0;

   BEGIN
      DBMS_OUTPUT.put_line(   vPieces.COUNT
                           || ' pieces were retrieved.');
      DBMS_OUTPUT.put_line('with total length ');

      FOR i IN 1 .. vPieces.COUNT
      LOOP
         vDataClob   :=
               vDataClob
            || vPieces(i);
         vLength     := vLength + LENGTH(vLength);
      END LOOP;
   END;

   DBMS_OUTPUT.put_line(vLength);
   RETURN vDataClob;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line(   DBMS_UTILITY.format_error_stack
                           || CHR(10)
                           || DBMS_UTILITY.format_error_backtrace);
END;

/
