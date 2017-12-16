--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKGMOON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."PKGMOON" IS
  jCentury CONSTANT NUMBER := 36525;
  jEpoch   CONSTANT NUMBER := 2451545.0;
  testDate CONSTANT DATE := TO_DATE('12/04/1992 00:00:00',
                                    'dd/mm/rrrr hh24:mi:ss');

  FUNCTION calc_MoonMeanLongitude RETURN NUMBER;

  FUNCTION calc_MoonMeanElongation RETURN NUMBER;

  FUNCTION calc_SunMeanAnom RETURN NUMBER;

  FUNCTION calc_MoonMeanAnom RETURN NUMBER;

  FUNCTION calc_MoonArgLat RETURN NUMBER;

  FUNCTION calc_JCentury(pDate IN DATE DEFAULT NULL) RETURN NUMBER;

  PROCEDURE calc_DynamicTime(pT1   OUT NUMBER,
                             pT2   OUT NUMBER,
                             pT3   OUT NUMBER,
                             pT4   OUT NUMBER,
                             pDate IN DATE DEFAULT NULL);

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
                             additive3       OUT NUMBER);

  PROCEDURE initialize_additives(sigma_l_additive OUT NUMBER,
                                 sigma_b_additive OUT NUMBER);

  PROCEDURE doCalc(pDate IN DATE DEFAULT NULL);
END;

/
