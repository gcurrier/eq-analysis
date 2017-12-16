--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKGMOON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "QUAKE"."PKGMOON" IS
  vl        NUMBER := 0;
  vd        NUMBER := 0;
  vm1       NUMBER := 0;
  vm2       NUMBER := 0;
  vf        NUMBER := 0;
  ve        NUMBER := 0;
  ve2       NUMBER := 0;
  va1       NUMBER := 0;
  va2       NUMBER := 0;
  va3       NUMBER := 0;
  sig_l_add NUMBER := 0;
  sig_b_add NUMBER := 0;

  -- time values
  t1 NUMBER := 0;
  t2 NUMBER := 0;
  t3 NUMBER := 0;
  t4 NUMBER := 0;

  FUNCTION calc_MoonMeanLongitude RETURN NUMBER IS
    vOut NUMBER;
  BEGIN
    -- Meeus, Astronomical Algorithms, 2nd Ed. (47.1)
    vOut := 218.3164477 + (481267.88123421 * t1) - (0.0015786 * t2) +
            (t3 / 538841) - (t4 / 65194000);
    RETURN vOut;
  END;

  FUNCTION calc_MoonMeanElongation RETURN NUMBER IS
    vOut NUMBER;
  BEGIN
    -- Meeus, Astronomical Algorithms, 2nd Ed. (47.2)
    vOut := 297.8501921 + (445267.1114034 * t1) - (0.0018819 * t2) +
            (t3 / 545868) - (t4 / 113065000);
    RETURN vOut;
  END;

  FUNCTION calc_SunMeanAnom RETURN NUMBER IS
    vOut NUMBER;
  BEGIN
    -- Meeus, Astronomical Algorithms, 2nd Ed. (47.3)
    vOut := 357.52910918 + (35999.05029094 * t1) - (0.00015361 * t2) +
            (t3 / 24490000);
    RETURN vOut;
  END;

  FUNCTION calc_MoonMeanAnom RETURN NUMBER IS
    vOut NUMBER;
    -- moon mean anomaly values
    m2a NUMBER := 134.9633964;
    m2b NUMBER := 477198.8675055 * t1;
    m2c NUMBER := 0.0087414 * t2;
    m2d NUMBER := t3 / 69699;
    m2e NUMBER := t4 / 14712000;
  BEGIN
    -- Meeus, Astronomical Algorithms, 2nd Ed. (47.4)
    vOut := m2a + m2b + m2c + m2d - m2e;
    RETURN vOut;
  END;

  FUNCTION calc_MoonArgLat RETURN NUMBER IS
    vOut NUMBER;
    -- moon argument of latitude values
    fa NUMBER := 93.2720950;
    fb NUMBER := 483202.0175233 * t1;
    fc NUMBER := 0.0036539 * t2;
    fd NUMBER := t3 / 3526000;
    fe NUMBER := t4 / 863310000;
  BEGIN
    -- Meeus, Astronomical Algorithms, 2nd Ed. (47.5)
    vOut := fa + fb - fc - fd + fe;
    RETURN vOut;
  END;

  FUNCTION calc_JCentury(pDate IN DATE DEFAULT NULL) RETURN NUMBER IS
    vOut NUMBER;
  BEGIN
    vOut := (pkgUtil.to_julian(pDate) - jEpoch) / jCentury;
    RETURN vOut;
  END;

  PROCEDURE calc_DynamicTime(pT1   OUT NUMBER,
                             pT2   OUT NUMBER,
                             pT3   OUT NUMBER,
                             pT4   OUT NUMBER,
                             pDate IN DATE DEFAULT NULL) IS
  BEGIN
    -- the null pDate value will allow a test date to be entered.
    -- The test date follows the example found in Chapter 47 in "Astronomical Algorithms", 2nd Ed. (Meeus,2009)
    IF pDate IS NULL THEN
      pT1 := calc_JCentury(testDate);
    ELSE
      pT1 := calc_JCentury(pDate);
    END IF;
  
    pT2 := TO_NUMBER(POWER(pT1, 2));
    pT3 := TO_NUMBER(POWER(pT2, 3));
    pT4 := TO_NUMBER(POWER(pT3, 4));
  END;

  PROCEDURE initialize_terms(pDate           IN DATE,
                             mean_longitude  OUT NUMBER,
                             mean_elong_moon OUT NUMBER,
                             sun_mean_anom   OUT NUMBER,
                             moon_mean_anom  OUT NUMBER,
                             moon_arg_lat    OUT NUMBER,
                             eccentricity    OUT NUMBER,
                             eccentricity2   OUT NUMBER,
                             additive1       OUT NUMBER,
                             additive2       OUT NUMBER,
                             additive3       OUT NUMBER) IS
    a1a NUMBER;
    a1b NUMBER;
    a2a NUMBER;
    a2b NUMBER;
    a3a NUMBER;
    a3b NUMBER;
  BEGIN
    -- calculate dynamic time
    calc_DynamicTime(pDate => pDate,
                     pT1   => t1,
                     pT2   => t2,
                     pT3   => t3,
                     pT4   => t4);
  
    -- mean arguments (outputs are in degrees - should be reduced)
    mean_longitude  := pkgUtil.degReduce(calc_MoonMeanLongitude);
    mean_elong_moon := pkgUtil.degReduce(calc_MoonMeanElongation);
    sun_mean_anom   := pkgUtil.degReduce(calc_SunMeanAnom);
    moon_mean_anom  := pkgUtil.degReduce(calc_MoonMeanAnom);
    moon_arg_lat    := pkgUtil.degReduce(calc_MoonArgLat);
  
    -- Meeus, Astronomical Algorithms, 2nd Ed. (47.6)
    eccentricity  := 1 - (0.002516 * t1) - (0.0000074 * t2);
    eccentricity2 := POWER(eccentricity, 2);
  
    -- additive values (degrees)
    a1a := 119.75;
    a1b := (131.849 * t1);
    a2a := 53.09;
    a2b := (479264.290 * t1);
    a3a := 313.45;
    a3b := (481266.484 * t1);
    -- additives to the mean arguments (use degrees for calculations)
    additive1 := a1a + a1b;
    additive2 := a2a + a2b;
    additive3 := a3a + a3b;
  END;

  PROCEDURE initialize_additives(sigma_l_additive OUT NUMBER,
                                 sigma_b_additive OUT NUMBER) IS
    l_add1 NUMBER := 3958 * SIN(va1);
    l_add2 NUMBER := 1962 * SIN(vl - vf);
    l_add3 NUMBER := 318 * SIN(va2);
    b_add1 NUMBER := -2235 * SIN(vl);
    b_add2 NUMBER := 382 * SIN(va3);
    b_add3 NUMBER := 175 * SIN(va1 - vf);
    b_add4 NUMBER := 175 * SIN(va1 + vf);
    b_add5 NUMBER := 127 * SIN(vl - vm1);
    b_add6 NUMBER := 115 * SIN(vl + vm1);
  BEGIN
    -- output is in Radians
    sigma_l_additive := l_add1 + l_add2 + l_add3;
    sigma_b_additive := b_add1 + b_add2 + b_add3 + b_add4 + b_add5 + b_add6;
  END;

  PROCEDURE doCalc(pDate IN DATE DEFAULT NULL) IS
    sigma_l    NUMBER;
    sigma_b    NUMBER;
    sigma_r    NUMBER;
    longitude  NUMBER;
    latitude   NUMBER;
    distance   NUMBER;
    right_asc  NUMBER;
    declin     NUMBER;
    sig_l_calc NUMBER;
    sig_r_calc NUMBER;
    ecc        NUMBER;
  
    CURSOR c1 IS
      SELECT * FROM lunar_coeff_a ORDER BY ABS(sine_coeff) DESC;
  
  BEGIN
    initialize_terms(pDate           => pDate,
                     mean_longitude  => vl,
                     mean_elong_moon => vd,
                     sun_mean_anom   => vm1,
                     moon_mean_anom  => vm2,
                     moon_arg_lat    => vf,
                     eccentricity    => ve,
                     eccentricity2   => ve2,
                     additive1       => va1,
                     additive2       => va2,
                     additive3       => va3);
  
    initialize_additives(sigma_l_additive => sig_l_add,
                         sigma_b_additive => sig_b_add);
    sigma_l := 0;
  
    FOR i IN c1 LOOP
      -- output data is in radians
      CASE ABS(i.m1)
        WHEN 0 THEN
          CASE i.sine_coeff
            WHEN 0 THEN
              sig_l_calc := SIN((i.d * vd) + (i.m1 * vm1) + (i.m2 * vm2) +
                                (i.f * vf));
            ELSE
              sig_l_calc := i.sine_coeff *
                            SIN((i.d * vd) + (i.m1 * vm1) + (i.m2 * vm2) +
                                (i.f * vf));
          END CASE;
        WHEN 1 THEN
          CASE i.sine_coeff
            WHEN 0 THEN
              sig_l_calc := SIN((i.d * vd) + (i.m1 * vm1) + (i.m2 * vm2) +
                                (i.f * vf));
            ELSE
              ecc        := TO_NUMBER(ve);
              sig_l_calc := i.sine_coeff * ecc *
                            SIN((i.d * vd) + (i.m1 * vm1) + (i.m2 * vm2) +
                                (i.f * vf));
          END CASE;
        WHEN 2 THEN
          CASE i.sine_coeff
            WHEN 0 THEN
              sig_l_calc := SIN((i.d * vd) + (i.m1 * vm1) + (i.m2 * vm2) +
                                (i.f * vf));
            ELSE
              ecc        := TO_NUMBER(ve2);
              sig_l_calc := i.sine_coeff * ecc *
                            SIN((i.d * vd) + (i.m1 * vm1) + (i.m2 * vm2) +
                                (i.f * vf));
          END CASE;
      END CASE;
    
      DBMS_OUTPUT.put_line('(' || sigma_l || ' + ' || sig_l_calc || ' + ' ||
                           sig_l_add || ') +');
      sigma_l    := sigma_l + sig_l_calc + sig_l_add;
      sig_l_calc := 0;
    END LOOP;
  
    DBMS_OUTPUT.put_line(CHR(10) || '-- Raw Position Values --');
    DBMS_OUTPUT.put_line('L'' raw          :' || vl);
    DBMS_OUTPUT.put_line('D raw           :' || vd);
    DBMS_OUTPUT.put_line('M1 raw          :' || vm1);
    DBMS_OUTPUT.put_line('M2 raw          :' || vm2);
    DBMS_OUTPUT.put_line('F raw           :' || vf);
    DBMS_OUTPUT.put_line('E raw           :' || ve);
    DBMS_OUTPUT.put_line('E squared raw   :' || ve2);
    DBMS_OUTPUT.put_line(CHR(10) || '-- Time Values --');
  
    IF pDate IS NULL THEN
      DBMS_OUTPUT.put_line('Julian Date  :' || pkgUtil.to_julian(testDate));
    ELSE
      DBMS_OUTPUT.put_line('Julian Date  :' || pkgUtil.to_julian(pDate));
    END IF;
  
    DBMS_OUTPUT.put_line('t1           :' || t1);
    DBMS_OUTPUT.put_line('t2           :' || t2);
    DBMS_OUTPUT.put_line('t3           :' || t3);
    DBMS_OUTPUT.put_line('t4           :' || t4);
  
    DBMS_OUTPUT.put_line(CHR(10) || '-- Position Values --');
    DBMS_OUTPUT.put_line('T            :' || ROUND(t1, 12));
    DBMS_OUTPUT.put_line('L''           :' || ROUND(vl, 6));
    DBMS_OUTPUT.put_line('D            :' || ROUND(vd, 6));
    DBMS_OUTPUT.put_line('M1           :' || ROUND(vm1, 6));
    DBMS_OUTPUT.put_line('M2           :' || ROUND(vm2, 6));
    DBMS_OUTPUT.put_line('F            :' || ROUND(vf, 6));
  
    DBMS_OUTPUT.put_line(CHR(10) || '-- Additive Values --');
    DBMS_OUTPUT.put_line('A1           :' ||
                         ROUND(pkgUtil.rad2Deg(va1), 2));
    DBMS_OUTPUT.put_line('A2           :' ||
                         ROUND(pkgUtil.rad2Deg(va2), 2));
    DBMS_OUTPUT.put_line('A3           :' ||
                         ROUND(pkgUtil.rad2Deg(va3), 2));
  
    DBMS_OUTPUT.put_line(CHR(10) || '-- Eccentricity Values --');
    DBMS_OUTPUT.put_line('E            :' || ROUND(ve, 6));
    DBMS_OUTPUT.put_line('E squared    :' || ROUND(ve2, 6));
  
    DBMS_OUTPUT.put_line(CHR(10) || '-- Debug Values --');
    DBMS_OUTPUT.put_line('L'' Additive  :' || sig_l_add);
    DBMS_OUTPUT.put_line('sigma_l      :' || sigma_l);
    /*dbms_output.put_line('sigma_r      :' || round(sigma_r));
    dbms_output.put_line('sigma_b      :' || round(sigma_b));
    dbms_output.put_line('sig_l_add    :' || sig_l_add);
    dbms_output.put_line('sigma_b      :' || sigma_b);
    dbms_output.put_line('sig_b_add    :' || sig_b_add);
    dbms_output.put_line('sigma_r      :' || sigma_r);
    dbms_output.put_line('longitude    :' || longitude);
    dbms_output.put_line('latitude     :' || latitude);
    dbms_output.put_line('distance     :' || distance);
    dbms_output.put_line('right_asc    :' || right_asc);
    dbms_output.put_line('declin       :' || declin);
    dbms_output.put_line(chr(10));*/
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack || CHR(10) ||
                           DBMS_UTILITY.format_error_backtrace);
      RAISE;
  END;
BEGIN
  NULL;
END;

/
