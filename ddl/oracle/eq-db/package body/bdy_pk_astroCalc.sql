--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PK_ASTROCALC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "QUAKE"."PK_ASTROCALC" IS
  /*   Desparately needs refactoring - the package is called once per required date ()essentially once per event/row...what
   if there are millions of dates? The current method is not efficient.  It should be refactored...somehow...to make this
  easier (and faster).
    Admittedly, this package is not intended for "table-at-a-time" processing.  It is intended to be called during new
  data insertion...generally after (or as a part of) each run of the "RUN_USGS_FEED" job. */
  --  <PRE CLASS="DESC_TEXT"><I>  Calculated value of pi ( &#928; )</I></PRE>
  pi CONSTANT NUMBER := ROUND(ASIN(1) * 2,
                              15);
  --  <PRE CLASS="DESC_TEXT"><I>  Days in a Julian Century</I></PRE>
  jCentury CONSTANT NUMBER := 36525;
  --  <PRE CLASS="DESC_TEXT"><I>  Julian Date for Epoch J2000.0 (1 January 2000 12:00:00)</I></PRE>
  jEpoch CONSTANT NUMBER := 2451545.0;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing t value.</I></PRE>
  t1 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing t&sup2; value.</I></PRE>
  t2 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing t&sup3; value.</I></PRE>
  t3 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing t&#8308; value.</I></PRE>
  t4 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing eccentricity of orbit value.</I></PRE>
  e NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing square of eccentricity of orbit value.</I></PRE>
  /* why define this here when the calculation is done in the "get_e" procedure as well as during "initialize"? */
  e2 NUMBER; --:= POWER(e, 2);
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing Moon's mean longitude value in radians.</I></PRE>
  vl NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing mean elongation of the Moon value in radians.</I></PRE>
  vd NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing Sun's mean anomaly value in radians.</I></PRE>
  vm NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing Moon's mean anomaly value in radians.</I></PRE>
  vm1 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing Moon's argument of latitude in radians.</I></PRE>
  vf NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  vsin NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  vcos NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_l1 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_l2 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_l3 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_b1 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_b2 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_b3 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_b4 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_b5 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  add_b6 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  a1 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  a2 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  a3 NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Sigma Lambda additive values total.</I></PRE>
  additive_lon NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Sigma Beta additive values total.</I></PRE>
  additive_lat NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing sum of periodic latitude.</I></PRE>
  sum_b NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  b_ecc NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  b_calc NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing final latitude calculation in decimal degrees.</I></PRE>
  lat NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing sum of periodic longitude series.</I></PRE>
  sum_l NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  l_ecc NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  l_calc NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing final longitude calculation in decimal degrees.</I></PRE>
  lon NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing sum of periodic distance series.</I></PRE>
  sum_r NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  r_ecc NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  r_calc NUMBER;
  --  <PRE CLASS="DESC_TEXT"><I>  Variable for storing final distance calculation in km.</I></PRE>
  dis NUMBER;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  procedure initialize(p_date in date) is
  --  begin
  --    t1 := getJDE_diff(p_date);
  --    t2 := power(t1, 2);
  --    t3 := power(t1, 3);
  --    t4 := power(t1, 4);
  --    l  := meanLong;
  --    d  := meanElong;
  --    m  := meanAnomSun;
  --    m1 := meanAnomMoon;
  --    f  := argLat;
  --    e  := get_e;
  --    a1 := add1;
  --    a2 := add2;
  --    a3 := add3;
  --  exception
  --    when others then
  --      null;
  --  end initialize
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Procedure used for initializing private package variables.  This
  --  procedure requires only the date (formatted with Oracle's to_date() function as input).  The
  --  main effort is to first, calculate the time values, then the eccentricity of orbit value (e).</I></PRE>
  PROCEDURE initialize(p_date IN DATE) IS
  BEGIN
    -- DBMS_OUTPUT.enable(10000);
    t1 := getJDE_diff(p_date);
    t2 := POWER(t1,
                2);
    t3 := POWER(t1,
                3);
    t4 := POWER(t1,
                4);
    get_e;
    --e2    := POWER(e, 2);
    sum_b := 0;
    sum_l := 0;
    sum_r := 0;
    meanLong;
    meanElong;
    meanAnomSun;
    meanAnomMoon;
    argLat;
    additive_terms;
    calcMoonLat;
    calcMoonLon;
    calcMoonDist;
    --dbms_output.put_line('JDE         : ' || jde);
    /*    dbms_output.put_line('t1          : ' || t1);
    dbms_output.put_line('t2          : ' || t2);
    dbms_output.put_line('t3          : ' || t3);
    dbms_output.put_line('t4          : ' || t4);
    dbms_output.put_line('e           : ' || e);
    dbms_output.put_line('e2          : ' || e2);
    dbms_output.put_line('l           : ' || vl);
    dbms_output.put_line('d           : ' || vd);
    dbms_output.put_line('m           : ' || vm);
    dbms_output.put_line('m1          : ' || pk_AstroCalc.rad2deg(vm1));
    dbms_output.put_line('f           : ' || vf);
    dbms_output.put_line('a1          : ' || a1);
    dbms_output.put_line('a2          : ' || a2);
    dbms_output.put_line('a3          : ' || a3);
    dbms_output.put_line('additive_lon: ' || additive_lon);
    dbms_output.put_line('additive_lat: ' || additive_lat);
    dbms_output.put_line('b_ecc       : ' || b_ecc);
    dbms_output.put_line('b_calc      : ' || b_calc);
    dbms_output.put_line('sum_b       : ' || sum_b);
    dbms_output.put_line('lat         : ' || lat);
    dbms_output.put_line('l_ecc       : ' || l_ecc);
    dbms_output.put_line('l_calc      : ' || l_calc);
    dbms_output.put_line('sum_l       : ' || sum_l);
    dbms_output.put_line('lon         : ' || lon);
    dbms_output.put_line('r_ecc       : ' || r_ecc);
    dbms_output.put_line('r_calc      : ' || r_calc);
    dbms_output.put_line('sum_r       : ' || sum_r);
    dbms_output.put_line('distance    : ' || dis);*/
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END initialize;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Format of time should be in HH24:MI:SS ONLY and passed in as VARCHAR2</I></PRE>
  FUNCTION to_dayFraction(p_time IN VARCHAR) RETURN NUMBER IS
    hh         NUMBER;
    mi         NUMBER;
    ss         NUMBER;
    v_fraction NUMBER;
  BEGIN
    hh         := TO_NUMBER(SUBSTR(p_time,
                                   1,
                                   2));
    mi         := TO_NUMBER(SUBSTR(p_time,
                                   3,
                                   2));
    ss         := TO_NUMBER(SUBSTR(p_time,
                                   5,
                                   2));
    v_fraction := (hh / 24) + (mi / 1440) + (ss / 86400);
    RETURN ROUND(v_fraction,
                 15);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  This function calculates a julian date (to the minute) from a calendar date-time.</I></PRE>
  FUNCTION to_julian(p_date IN DATE) RETURN NUMBER IS
    v_time VARCHAR2(6);
    yr_a   NUMBER;
    yr_b   NUMBER;
    dy     NUMBER;
    mth    NUMBER;
    mth1   NUMBER;
    yr     NUMBER;
    yr1    NUMBER;
    jd     NUMBER;
  BEGIN
    yr     := EXTRACT(YEAR FROM p_date);
    mth    := EXTRACT(MONTH FROM p_date);
    dy     := EXTRACT(DAY FROM p_date);
    yr_a   := TRUNC(yr / 100);
    yr_b   := 2 - yr_a + TRUNC(yr_a / 4);
    v_time := TO_CHAR(p_date,
                      'hh24miss');
  
    IF mth > 2
    THEN
      jd := TRUNC(365.25 * (yr + 4716)) + TRUNC(30.6001 * (mth + 1)) + dy + yr_b -
            1524.5 + pk_astroCalc.to_dayFraction(v_time);
    ELSE
      IF mth = 1 OR mth = 2
      THEN
        yr1  := yr - 1;
        mth1 := mth + 12;
        jd   := TRUNC(365.25 * (yr1 + 4716)) + TRUNC(30.6001 * (mth1 + 1)) + dy + yr_b -
                1524.5 + pk_astroCalc.to_dayFraction(v_time);
      END IF;
    END IF;
  
    RETURN jd;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  FUNCTION getJDE_diff(p_date IN DATE) RETURN NUMBER IS
    t  NUMBER;
    jd NUMBER;
  BEGIN
    jd := pk_astroCalc.to_julian(p_date);
    t  := (jd - jEpoch) / jCentury;
    RETURN t;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END getJDE_diff;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  FUNCTION degReduce(p_num IN NUMBER) RETURN NUMBER IS
    c   NUMBER := ABS(TRUNC(p_num / 360)) + 1;
    deg NUMBER;
  BEGIN
    deg := p_num + c * 360;
    RETURN deg;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END degReduce;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  function deg2rad(p_degree in number) return number is
  --    rad number;
  --  begin
  --    rad := round(p_degree * (pi/180),10);
  --    return rad;
  --  exception
  --    when others then
  --      null;
  --  end deg2rad;
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a decimal degree and converts it to RADIANS.
  --  This function is used as part of the conversion from &#945; (right ascension) decimal degrees.</I></PRE>
  FUNCTION deg2rad(p_degree IN NUMBER) RETURN NUMBER IS
    rad NUMBER;
  BEGIN
    rad := p_degree * (pi / 180);
    RETURN rad;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END deg2rad;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  FUNCTION rad2Deg(p_rad IN NUMBER) RETURN NUMBER IS
    deg NUMBER;
  BEGIN
    deg := p_rad * (180 / pi);
    RETURN deg;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  function r_asc_2deg(p_RA in varchar2, p_pos in varchar2 default '+')
  --    return number is
  --    hh  number;
  --    mi  number;
  --    ss  number;
  --    deg number;
  --    INVALID_RA  EXCEPTION;
  --    INVALID_NUM EXCEPTION;
  --  begin
  --    if p_pos = '+'
  --    then
  --      hh := to_number(substr(p_ra, 1, 2));
  --      mi := to_number(substr(p_ra, 3, 2));
  --      ss := to_number(substr(p_ra, 5));
  --    else
  --      if not p_pos = '+'
  --      then
  --        hh := to_number(substr(p_ra, 1, 3));
  --        mi := to_number(substr(p_ra, 4, 2)) * (-1);
  --        ss := to_number(substr(p_ra, 6)) * (-1);
  --      end if;
  --    end if;
  --    -- test that numbers are whole numbers
  --    if (hh - trunc(hh) <> 0)
  --       or (mi - trunc(mi) <> 0)
  --    then
  --      raise invalid_num;
  --    else
  --      if (hh not between - 24 and 24)
  --         or (mi not between - 59 and 59)
  --         or (ss not between - 59 and 59)
  --      then
  --        raise invalid_ra;
  --      else
  --        deg := (hh + (mi / 60) + (ss / 3600)) * 15;
  --      end if;
  --    end if;
  --    return deg;
  --  exception
  --    when INVALID_NUM then
  --      null;
  --    when INVALID_RA then
  --      null;
  --    when others then
  --      dbms_output.put_line(sqlerrm);
  --      dbms_output.put_line(dbms_utility.format_error_backtrace);
  --  end rad2deg;
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Using this function, one should remember to remove all symbology used in right ascension
  --  notation.  For example 9h14m55.8s should be converted to 091455.8.  If the RA ( &#945; ) is
  --  negative, a value of '-' MUST be passed as the p_pos parameter so that the function knows
  --  the value is negative.  Positive values do not require the p_pos parameter (there
  --  should be no "+" symbol passed).  The purpose of this is to be sure the
  --  decimal degree is calculated correctly as described in "Astronomical Algorithms" (Meeus,1998).
  --  </I></PRE>
  FUNCTION r_asc_2deg(p_RA IN VARCHAR2) RETURN NUMBER IS
    hh  NUMBER;
    mi  NUMBER;
    ss  NUMBER;
    deg NUMBER;
    INVALID_RA  EXCEPTION;
    INVALID_NUM EXCEPTION;
  BEGIN
    hh := TO_NUMBER(SUBSTR(p_ra,
                           1,
                           2));
    mi := TO_NUMBER(SUBSTR(p_ra,
                           3,
                           2));
    ss := TO_NUMBER(SUBSTR(p_ra,
                           6));
  
    -- test that numbers are whole numbers
    IF (hh - TRUNC(hh) <> 0) OR (mi - TRUNC(mi) <> 0)
    THEN
      RAISE invalid_num;
    ELSE
      IF (hh NOT BETWEEN - 24 AND 24) OR (mi NOT BETWEEN - 59 AND 59) OR
         (ss NOT BETWEEN - 59 AND 59)
      THEN
        RAISE invalid_ra;
      ELSE
        deg := (hh + (mi / 60) + (ss / 3600)) * 15;
      END IF;
    END IF;
  
    RETURN deg;
    /*  EXCEPTION
    WHEN INVALID_NUM THEN
      deg := 999999;
    WHEN INVALID_RA THEN
      deg := 888888;
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);*/
  END r_asc_2deg;

  -- Calculate Moon additive arguments. Output in radians.
  FUNCTION calc_MoonAdditives(p_addNum IN NUMBER,
                              p_t1     IN NUMBER) RETURN NUMBER IS
    v NUMBER;
  BEGIN
    CASE p_addNum
      WHEN 1 THEN
        -- v := pk_astroCalc.deg2rad(119.75 + (131.849 * p_t1));
        v := 119.75 + (131.849 * p_t1);
      WHEN 2 THEN
        v := degReduce(53.09 + (479264.290 * p_t1));
      WHEN 3 THEN
        v := degReduce(313.45 + (481266.484 * p_t1));
      ELSE
        NULL;
    END CASE;
  
    RETURN v;
  END calc_MoonAdditives;

  -- Calculate Moon's mean longitude based on the datetime value. Output in Radians.
  FUNCTION calc_MoonMeanLon RETURN NUMBER IS
    moonMeanLon NUMBER;
    va          NUMBER := 218.3164477;
    vb          NUMBER := 481267.88123421 * t1;
    vc          NUMBER := 0.0015786 * t2;
    vd          NUMBER := t3 / 538841;
    ve          NUMBER := t4 / 65194000;
  BEGIN
    moonMeanLon := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(va + vb - vc + vd - ve));
    RETURN moonMeanLon;
  END calc_MoonMeanLon;

  -- Calculate Moon's mean elongation of orbit based on the datetime value. Output in Radians.
  FUNCTION calc_MoonMeanElon RETURN NUMBER IS
    moonMeanElon NUMBER;
    va           NUMBER := 297.8501921;
    vb           NUMBER := 445267.1114034 * t1;
    vc           NUMBER := 0.0018819 * t2;
    vd           NUMBER := t3 / 545868;
    ve           NUMBER := t4 / 113065000;
  BEGIN
    moonMeanElon := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(va + vb - vc + vd - ve));
    RETURN moonMeanElon;
  END calc_MoonMeanElon;

  -- Calculate Moon's mean anomaly based on the datetime value. Output in Radians.
  FUNCTION calc_MoonMeanAnom RETURN NUMBER IS
    moonMeanAnom NUMBER;
    va           NUMBER := 134.9633964;
    vb           NUMBER := 477198.8675055 * t1;
    vc           NUMBER := 0.0087414 * t2;
    vd           NUMBER := t3 / 69699;
    ve           NUMBER := t4 / 14712000;
  BEGIN
    moonMeanAnom := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(va + vb + vc + vd - ve));
    RETURN moonMeanAnom;
  END calc_MoonMeanAnom;

  -- Calculate Moon's argument of latitude based on the datetime value. Output in Radians.
  FUNCTION calc_MoonArgLat RETURN NUMBER IS
    moonArgLat NUMBER;
    va         NUMBER := 93.2720950;
    vb         NUMBER := 483202.0175233 * t1;
    vc         NUMBER := 0.0036539 * t2;
    vd         NUMBER := t3 / 3526000;
    ve         NUMBER := t4 / 863310000;
  BEGIN
    moonArgLat := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(va + vb - vc - vd + ve));
    RETURN moonArgLat;
  END calc_MoonArgLat;

  -- Calculate the additive value to the Moon's mean Longitude.
  FUNCTION calc_MoonLonAdditive(p_t1 IN NUMBER) RETURN NUMBER IS
    x  NUMBER;
    xa NUMBER := 0;
    xb NUMBER := 0;
    xc NUMBER := 0;
  BEGIN
    xa := 3958 * SIN(pk_astroCalc.deg2rad(calc_MoonAdditives(1,
                                                             p_t1)));
    xb := 1962 *
          SIN(pk_astroCalc.deg2rad(calc_MoonMeanLon - calc_MoonArgLat));
    xc := 318 * SIN(pk_astroCalc.deg2rad(calc_MoonAdditives(2,
                                                            p_t1)));
    x  := xa + xb + xc;
    RETURN x;
  END calc_MoonLonAdditive;

  PROCEDURE meanLong IS
  BEGIN
    vl := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(218.3164477 +
                                                      (481267.88123421 * t1) -
                                                      (0.0015786 * t2) +
                                                      (t3 / 538841) -
                                                      (t4 / 65194000)));
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END meanLong;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Calculate mean elongation of Moon.</I></PRE>
  PROCEDURE meanElong IS
    da NUMBER := 297.8501921;
    db NUMBER := 445267.1114034 * t1;
    dc NUMBER := 0.0018819 * t2;
    dd NUMBER := t3 / 545868;
    de NUMBER := t4 / 113065000;
  BEGIN
    vd := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(da + db - dc + dd - de));
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END meanElong;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Calculate Sun's mean anomaly.</I></PRE>
  PROCEDURE meanAnomSun IS
    ma NUMBER := 357.5291092;
    mb NUMBER := 35999.0502909 * t1;
    mc NUMBER := -0.0001536 * t2;
    md NUMBER := t3 / 24490000;
  BEGIN
    vm := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(ma + mb - mc + md));
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END meanAnomSun;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Calculate Moon's mean anomaly.</I></PRE>
  PROCEDURE meanAnomMoon IS
    m1a NUMBER := 134.9633964;
    m1b NUMBER := 477198.8675055 * t1;
    m1c NUMBER := 0.0087414 * t2;
    m1d NUMBER := t3 / 69699;
    m1e NUMBER := t4 / 14712000;
  BEGIN
    vm1 := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(m1a + m1b + m1c + m1d - m1e));
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END meanAnomMoon;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Calculate Moon's argument of latitude.</I></PRE>
  PROCEDURE argLat IS
    fa NUMBER := 93.2720950;
    fb NUMBER := 483202.0175233 * t1;
    fc NUMBER := 0.0036539 * t2;
    fd NUMBER := t3 / 3526000;
    fe NUMBER := t4 / 863310000;
  BEGIN
    vf := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(fa + fb - fc - fd + fe));
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END argLat;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Calculation for Earth's orbital eccentricity around the Sun.</I></PRE>
  PROCEDURE get_e IS
  BEGIN
    e  := 1 - (0.002516 * t1) - (0.0000074 * t2);
    e2 := POWER(e,
                2);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END get_e;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I>  Additive "1" value for summation calculations.</I></PRE>
  PROCEDURE additive_terms IS
  BEGIN
    a1     := pk_astroCalc.deg2rad(119.75 + (131.849 * t1));
    a2     := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(53.09 +
                                                          (479264.290 * t1)));
    a3     := pk_astroCalc.deg2rad(pk_astroCalc.degReduce(313.45 +
                                                          (481266.484 * t1)));
    add_l1 := 3958 * SIN(pk_astroCalc.deg2rad(a1));
    add_l2 := 1962 * SIN(vl - vf);
    add_l3 := 318 * SIN(pk_astroCalc.deg2rad(pk_astroCalc.degReduce(a2)));
    add_b1 := -2235 * SIN(vl);
    add_b2 := 382 * SIN(pk_astroCalc.deg2rad(pk_astroCalc.degReduce(a3)));
    add_b3 := 175 *
              SIN(pk_astroCalc.deg2rad(pk_astroCalc.degReduce(a1)) -
                  pk_astroCalc.deg2rad(pk_astroCalc.degReduce(vf)));
    add_b4 := 175 *
              SIN(pk_astroCalc.deg2rad(pk_astroCalc.degReduce(a1)) +
                  pk_astroCalc.deg2rad(pk_astroCalc.degReduce(vf)));
    add_b5 := 127 *
              SIN(pk_astroCalc.deg2rad(vl) -
                  pk_astroCalc.deg2rad(pk_astroCalc.degReduce(vm1)));
    add_b6 := -115 *
              SIN(pk_astroCalc.deg2rad(vl) +
                  pk_astroCalc.deg2rad(pk_astroCalc.degReduce(vm1)));
  
    additive_lon := add_l1 + add_l2 + add_l3;
    additive_lat := add_b1 + add_b2 + add_b3 + add_b4 + add_b5 + add_b6;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END additive_terms;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  PROCEDURE calcMoonVars(p_CalcType IN VARCHAR2) IS
    CURSOR c1 IS
      SELECT d, m1, m2, f, sine_coeff, cosine_coeff FROM lunar_coeff_a;
  
    CURSOR c2 IS
      SELECT d, m1, m2, f, sine_coeff FROM lunar_coeff_b;
  
  BEGIN
    IF p_CalcType = 'LAT'
    THEN
      FOR i IN c2
      LOOP
        vsin := SIN((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
      
        CASE
          WHEN ABS(i.m1) = 2 THEN
            b_ecc  := i.sine_coeff * e2;
            b_calc := b_ecc * vsin;
          WHEN ABS(i.m1) = 1 THEN
            b_ecc  := i.sine_coeff * e;
            b_calc := b_ecc * vsin;
          WHEN ABS(i.m1) = 0 THEN
            b_calc := i.sine_coeff * vsin;
        END CASE;
      
        sum_b := sum_b + b_calc;
      END LOOP;
    
      lat := getCalc(sum_b,
                     'b');
    ELSIF p_CalcType = 'LON'
    THEN
      FOR i IN c1
      LOOP
        vsin := SIN((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
      
        CASE
          WHEN ABS(i.m1) = 2 THEN
            l_ecc  := i.sine_coeff * e2;
            l_calc := l_ecc * vsin;
          WHEN ABS(i.m1) = 1 THEN
            l_ecc  := i.sine_coeff * e;
            l_calc := l_ecc * vsin;
          WHEN ABS(i.m1) = 0 THEN
            l_calc := i.sine_coeff * vsin;
        END CASE;
      
        sum_l := sum_l + l_calc;
      END LOOP;
    
      lon := getCalc(sum_l,
                     'l');
    ELSIF p_CalcType = 'DIS'
    THEN
      FOR i IN c1
      LOOP
        vcos := COS((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
      
        CASE
          WHEN ABS(i.m1) = 2 THEN
            r_ecc  := i.cosine_coeff * e2;
            r_calc := r_ecc * vcos;
          WHEN ABS(i.m1) = 1 THEN
            r_ecc  := i.cosine_coeff * e2;
            r_calc := r_ecc * vcos;
          WHEN ABS(i.m1) = 0 THEN
            r_calc := i.cosine_coeff * vcos;
        END CASE;
      
        sum_r := sum_r + r_calc;
      END LOOP;
    
      dis := getCalc(sum_r,
                     'r');
    END IF;
  END;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  PROCEDURE calcMoonLat IS
  BEGIN
    FOR i IN (SELECT d, m1, m2, f, sine_coeff FROM lunar_coeff_b)
    LOOP
      vsin := SIN((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
      vcos := COS((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
    
      CASE
        WHEN ABS(i.m1) = 2 THEN
          b_ecc  := i.sine_coeff * e2;
          b_calc := b_ecc * vsin;
        WHEN ABS(i.m1) = 1 THEN
          b_ecc  := i.sine_coeff * e;
          b_calc := b_ecc * vsin;
        WHEN ABS(i.m1) = 0 THEN
          b_calc := i.sine_coeff * vsin;
      END CASE;
    
      sum_b := sum_b + b_calc;
    END LOOP;
  
    lat := getCalc(sum_b,
                   'b');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END calcMoonLat;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  PROCEDURE calcMoonLon IS
  BEGIN
    FOR i IN (SELECT d, m1, m2, f, sine_coeff FROM lunar_coeff_a)
    LOOP
      vsin := SIN((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
    
      -- vcos        := COS((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
    
      CASE
        WHEN ABS(i.m1) = 2 THEN
          l_ecc  := i.sine_coeff * e2;
          l_calc := l_ecc * vsin;
        WHEN ABS(i.m1) = 1 THEN
          l_ecc  := i.sine_coeff * e;
          l_calc := l_ecc * vsin;
        WHEN ABS(i.m1) = 0 THEN
          l_calc := i.sine_coeff * vsin;
      END CASE;
    
      sum_l := sum_l + l_calc;
    END LOOP;
  
    lon := getCalc(sum_l,
                   'l');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END calcMoonLon;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  PROCEDURE calcMoonDist IS
  BEGIN
    FOR i IN (SELECT d, m1, m2, f, cosine_coeff FROM lunar_coeff_a)
    LOOP
      vsin := SIN((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
      vcos := COS((i.d * vd) + (i.m1 * vm) + (i.m2 * vm1) + (i.f * vf));
      CASE
        WHEN ABS(i.m1) = 2 THEN
          r_ecc  := i.cosine_coeff * e2;
          r_calc := r_ecc * vcos;
        WHEN ABS(i.m1) = 1 THEN
          r_ecc  := i.cosine_coeff * e2;
          r_calc := r_ecc * vcos;
        WHEN ABS(i.m1) = 0 THEN
          r_calc := i.cosine_coeff * vcos;
      END CASE;
      sum_r := sum_r + r_calc;
    END LOOP;
    dis := getCalc(sum_r,
                   'r');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END calcMoonDist;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  FUNCTION getCalc(p_sum  IN NUMBER,
                   p_term IN VARCHAR2) RETURN NUMBER IS
    invalid_value EXCEPTION;
    a NUMBER;
  BEGIN
    IF p_term = 'b'
    THEN
      IF ABS(p_sum) IS NULL
      THEN
        RAISE invalid_value;
      ELSE
        a := ((p_sum + additive_lat) / 1000000);
      END IF;
    ELSE
      IF p_term = 'l'
      THEN
        IF ABS(p_sum) IS NULL
        THEN
          RAISE invalid_value;
        ELSE
          a := pk_astrocalc.rad2deg(vl) +
               ((p_sum + additive_lon) / 1000000);
        END IF;
      ELSE
        IF p_term = 'r'
        THEN
          IF ABS(p_sum) IS NULL
          THEN
            RAISE invalid_value;
          ELSE
            a := 385000.56 + (p_sum / 1000);
          END IF;
        ELSE
          RAISE invalid_value;
        END IF;
      END IF;
    END IF;
  
    RETURN a;
    /*  EXCEPTION
    WHEN invalid_value THEN
      a := 999999;
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);*/
  END;

  --  <CODE><PRE CLASS="DECL_TEXT">
  --  </PRE></CODE>
  --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
  FUNCTION getLunarValue(p_date IN DATE,
                         p_val  IN VARCHAR2) RETURN NUMBER IS
    a NUMBER;
  BEGIN
    pk_astroCalc.initialize(p_date);
  
    IF UPPER(p_val) = 'DIST'
    THEN
      a := dis;
    ELSE
      IF UPPER(p_val) = 'LAT'
      THEN
        a := lat;
      ELSE
        IF UPPER(p_val) = 'LON'
        THEN
          /* Remember that the number returned here needs to be reformatted to Right Ascension notation (xxHrs xxMin xxSecs. For example 091455.8 should be converted to 9h14m55.8s*/
          /*if lon > 90 or lon < -90
          then
            a := pk_astroCalc.degReduce(lon);
          else*/
          a := lon;
          /* end if;*/
        END IF;
      END IF;
    END IF;
  
    RETURN a;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLERRM);
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
  END;
END pk_astroCalc;

/
