--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PK_ASTROCALC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."PK_ASTROCALC" IS
  -- Various calculations used to determine astronomical data types and values
  -- %Author  : Glen Currier
  -- %Version : 1.0 (20-Jan-14 15:32:57)

  -- Public type declarations
  -- type <TypeName> is <Datatype>;

  -- Public constant declarations
  -- <ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  -- <VariableName> <Datatype>;

  -- Public function and procedure declarations
  -- function <FunctionName>(<Parameter> <Datatype>) return <Datatype>;

  -- Accepts a DATE (ISO-8166 date format "YYYY-MM-DD HH24:MI:SS") and intializes variables used in
  -- calculating Lunar Distance.
  -- %param p_date (IN) DATE
  PROCEDURE initialize(p_date IN DATE);

  -- Accepts a string representation of time and returns a real number as a fraction of a day (to 10 digits for to-the-second accuracy)
  -- %param p_time (IN) VARCHAR2
  -- %return NUMBER
  FUNCTION to_dayFraction(p_time IN VARCHAR) RETURN NUMBER;

  -- Accepts a DATE parameter and returns a real number as the JULIAN DATE
  -- %param p_date (IN) DATE
  -- %return NUMBER
  FUNCTION to_julian(p_date IN DATE) RETURN NUMBER;

  -- Accepts a NUMBER (Julian Datetime - to the minute) and converts it to "T", a time value measured in centuries from the Epoch J2000.0 (JDE 2451545.0 or 1-Jan-2000 12:00:00 AM)
  -- %param p_date (IN) DATE
  -- %return NUMBER
  FUNCTION getJDE_diff(p_date IN DATE) RETURN NUMBER;

  -- Accepts...
  -- %param
  -- %return
  FUNCTION degReduce(p_num IN NUMBER) RETURN NUMBER;

  -- Accepts a NUMBER (decimal degrees) and converts it to equivalent value in RADIANS
  -- %param p_degree (IN) NUMBER
  -- %return NUMBER
  FUNCTION deg2rad(p_degree IN NUMBER) RETURN NUMBER;

  -- Accepts...
  -- %param
  -- %return
  FUNCTION rad2deg(p_rad IN NUMBER) RETURN NUMBER;

  -- Accepts a VARCHAR2 (right ascension) and converts it to decimal DEGREE
  -- %param p_RA (IN) VARCHAR2
  -- %param p_pos (IN) VARCHAR2 default '+'
  -- %return NUMBER
  FUNCTION r_asc_2deg(p_RA IN VARCHAR2) RETURN NUMBER;

  FUNCTION calc_MoonAdditives(p_addNum IN NUMBER,
                              p_t1     IN NUMBER) RETURN NUMBER;

  FUNCTION calc_MoonLonAdditive(p_t1 IN NUMBER) RETURN NUMBER;

  -- Accepts...
  -- %param
  PROCEDURE meanLong;

  -- Accepts...
  -- %param
  PROCEDURE meanElong;

  -- Accepts...
  -- %param
  PROCEDURE meanAnomSun;

  -- Accepts...
  -- %param
  PROCEDURE meanAnomMoon;

  -- Accepts...
  -- %param
  PROCEDURE argLat;

  -- Accepts...
  -- %param
  PROCEDURE get_e;

  -- Accepts...
  -- %param
  PROCEDURE additive_terms;

  -- Accepts...
  -- %param
  -- %return
  PROCEDURE calcMoonLat;

  -- Accepts...
  -- %param
  -- %return
  PROCEDURE calcMoonLon;

  -- Accepts...
  -- %param
  -- %return
  PROCEDURE calcMoonDist;

  -- Accepts...
  -- %param
  -- %return
  FUNCTION getCalc(p_sum  IN NUMBER,
                   p_term IN VARCHAR2) RETURN NUMBER;

  -- Accepts...
  -- %param
  -- %return
  FUNCTION getLunarValue(p_date IN DATE,
                         p_val  IN VARCHAR2) RETURN NUMBER;
END pk_astroCalc;

/
