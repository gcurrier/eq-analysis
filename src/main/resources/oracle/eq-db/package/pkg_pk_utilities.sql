--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PK_UTILITIES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."PK_UTILITIES" 
IS
   -- General-purpose utilities for various data manipulation of MICA-based data output.
   -- %Author  Glen Currier
   -- %version 2.7 (30-Dec-13)

   -- Determines if given year is a leap year
   -- %param p_year (IN) four digit year
   -- %return TRUE if year is a leap year, FALSE if not
   FUNCTION is_leap_year(p_year IN NUMBER)
      RETURN BOOLEAN;

   -- Convert date-time output format from MICA software to ISO-8601 format and returns a varchar2 datatype
   -- %param p_dateString (IN) character data in MICA output format
   -- %return VARCHAR2 ISO-8601 formatted date.  If NULL is passed in, a dummy value is returned (0000-00-00T00:00:00)
   FUNCTION mica_toISOchar(p_dateString IN VARCHAR2)
      RETURN VARCHAR2;

   -- Convert date-time output format from MICA software to ISO-8601 format and returns a date datatype
   -- %param p_dateString (IN) character data in MICA output format
   -- %return DATE ISO-8601 formatted date.  If NULL is passed in, a dummy value is returned (1800-01-01T00:00:00)
   FUNCTION mica_toISOdate(p_dateString IN VARCHAR2)
      RETURN DATE;

   -- Convert month number (1-12) to varchar2 (for example "1" becomes "01")
   -- %param p_monthNum (IN) number data in MICA output format
   -- %return NUMBER.
   FUNCTION mica_toMonth(p_monthNum IN NUMBER)
      RETURN VARCHAR2;

   -- Convert date-time output format from MICA software to timestamp and extract the day
   -- %param p_dateString (IN) character data in MICA output format
   -- %return VARCHAR2.
   FUNCTION mica_toDay(p_dateString IN VARCHAR2)
      RETURN VARCHAR2;

   -- Convert date-time output format from MICA software to timestamp and extract the hour
   -- %param p_dateString (IN) character data in MICA output format
   -- %return VARCHAR2.
   FUNCTION mica_toHour(p_dateString IN VARCHAR2)
      RETURN VARCHAR2;

   -- Convert date-time output format from MICA software to timestamp and extract the minute
   -- %param p_dateString (IN) character data in MICA output format
   -- %return VARCHAR2.
   FUNCTION mica_toMinute(p_dateString IN VARCHAR2)
      RETURN VARCHAR2;

   -- Convert Julian date-time output format (9999999.9999) from MICA software to ISO-8601 format and returns a
   -- date datatype
   -- %param p_jDate (IN) number data in MICA output format
   -- %return DATE ISO-8601 formatted date.  If NULL is passed in, a dummy value is returned (01-Jan-00T00:00:00)
   FUNCTION mica_jdateToISOdate(p_jDate IN NUMBER DEFAULT NULL)
      RETURN DATE;

   -- Convert Julian date-time output format (999999999.9999) from MICA software to ISO-8601 format and returns a
   -- character datatype
   -- %param p_jDate (IN) number data in MICA output format
   -- %return VARCHAR2 ISO-8601 formatted date.  If NULL is passed in, a dummy value is returned (1800-01-01T00:00:00)
   FUNCTION mica_jdateToISOchar(p_jDate IN NUMBER DEFAULT NULL)
      RETURN VARCHAR2;

   -- Convert Oracle (gregorian) DATE (in VARCHAR2) output format (YYYY/MM/DD h24:mi:ss) and return Oracle Julian date (with decimal)
   -- %param p_jDate (IN) varchar2
   -- %return NUMBER julian date.  Passing NULL returns 1111111.111111
   FUNCTION to_julian(p_date IN VARCHAR2)
      RETURN NUMBER;

   -- Convert Oracle (gregorian) DATE datatype (YYYY/MM/DD h24:mi:ss) and return Oracle Julian date (with decimal)
   -- %param p_jDate (IN) DATE
   -- %return NUMBER julian date.  Passing NULL returns 1111111.111111
   FUNCTION to_julian(p_date IN DATE)
      RETURN NUMBER;

   -- Accepts two input parameters and returns a "Mon-RRRR" formatted varchar2 datatype
   -- %param p_yr (IN) 4-digit (NUMBER) year
   -- %param p_mth (IN) 2-digit (NUMBER) month
   -- %return VARCHAR2 Mon-Year formatted varchar2 datatype (for example: "Jan-1900")
   FUNCTION mica_toMonthYear(p_yr IN NUMBER, p_mth IN NUMBER)
      RETURN VARCHAR2;

   -- Accepts two input parameters and returns a "Mon-RRRR" formatted varchar2 datatype
   -- %param p_dec (IN) VARCHAR2 decimal geo-coordinates
   -- %param p_type (IN) VARCHAR2 "LAT" (for latitude conversion), "LON" for (longitude conversion)
   -- %return VARCHAR2 Formatted geo-coordinates ("999d 99m 99.99s N|S|E|W")
   FUNCTION to_geoCoord(p_dec IN VARCHAR2, p_type IN VARCHAR2)
      RETURN VARCHAR2;

   -- Accepts decimal geographical coordinate and returns coordinate in "+/- dd mm ss" format.
   -- %param p_dec (IN) NUMBER
   -- %return VARCHAR2 formatted in "+/-dd mm ss"
   FUNCTION dec2DMS(p_dec IN NUMBER)
      RETURN VARCHAR2;

   -- Accepts decimal geographical coordinate and outputs a formatted VARCHAR2 datatype coordinate or coordinate part.
   -- %param p_dec (IN) NUMBER
   -- %param p_outType (IN OPTIONAL) NULL, 'D','M','S'
   -- %return VARCHAR2 Output is dependent on what is passed as p_outType: (+/-)dd° mm' ss" (NULL), (+/-)dd° ('D'), mm' ('M'), ss" ('S')
   FUNCTION dec2DMS_Split(p_dec IN NUMBER, p_outType IN VARCHAR2 DEFAULT NULL)
      RETURN VARCHAR2;

   -- Converts Right Ascension in VARCHAR2 datatype and converts to decimal degrees.
   -- %param p_ra (IN) VARCHAR2
   -- return NUMBER
   FUNCTION mica_ra2Deg(p_ra IN VARCHAR2)
      RETURN NUMBER;

   -- Converts Declination in VARCHAR2 datatype and converts to decimal degrees.
   -- %param p_decl (IN) VARCHAR2
   -- return NUMBER
   FUNCTION mica_decl2Deg(p_decl IN VARCHAR2)
      RETURN NUMBER;
END pk_utilities;

/
