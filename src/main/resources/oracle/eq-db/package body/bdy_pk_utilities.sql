--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PK_UTILITIES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "QUAKE"."PK_UTILITIES" 
IS
   /*
       --  <CODE><PRE CLASS="DECL_TEXT">
       --  </PRE></CODE>
       --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
       function <functionName>(<parameters>) return <datatype>
       is
       begin
       end;

       --  <CODE><PRE CLASS="DECL_TEXT">
       --  </PRE></CODE>
       --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
       procedure <procedureName>(<parameters>)
       is
       begin
       end;
   */
   --  <CODE><PRE CLASS="DECL_TEXT">
   --  FUNCTION is_leap_year(p_year IN NUMBER) RETURN BOOLEAN IS
   --    v_mod1 NUMBER(5, 2);
   --
   --    v_mod2 NUMBER(5, 2);
   --    v_mod3   NUMBER(5, 2);
   --    v_answer BOOLEAN;
   --  BEGIN
   --    v_mod1 := MOD(p_year, 4);
   --    v_mod2 := MOD(p_year, 100);
   --    v_mod3 := MOD(p_year, 400);
   --
   --    IF ((v_mod1 = 0 AND v_mod2 <> 0) OR v_mod3 = 0) THEN
   --      v_answer := TRUE;
   --    ELSE
   --      v_answer := FALSE;
   --    END IF;
   --
   --    RETURN v_answer;
   --  END is_leap_year;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function determines whether or not the passed year is a leap year.
   --  Determining a leap year is answered thusly:
   --    When a year is divisible by 4 and NOT by 100 OR the year is divisible by 400, then year is a leap year and the
   --  function returns TRUE.  Else, it returns FALSE. </I></PRE>
   FUNCTION is_leap_year(p_year IN NUMBER)
      RETURN BOOLEAN
   IS
      v_mod1         NUMBER(5, 2);
      v_mod2         NUMBER(5, 2);
      v_mod3         NUMBER(5, 2);
      v_answer       BOOLEAN;
   BEGIN
      v_mod1      := MOD(p_year, 4);
      v_mod2      := MOD(p_year, 100);
      v_mod3      := MOD(p_year, 400);

      IF (   (    v_mod1 = 0
              AND v_mod2 <> 0)
          OR v_mod3 = 0)
      THEN
         v_answer    := TRUE;
      ELSE
         v_answer    := FALSE;
      END IF;

      RETURN v_answer;
   END is_leap_year;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toISOchar(p_dateString in varchar2) return varchar2 is
   --    v_isoDate varchar2(19);
   --  begin
   --    if p_dateString is NULL
   --    then
   --      v_isoDate := '0000-01-01T00:00:00';
   --    else
   --      v_isoDate := to_char(to_date(substr(p_dateString, 1, 4) || '-' ||
   --                                   substr(p_dateString, 5, 4) || '-' ||
   --                                   substr(p_dateString, 9, 3) || ' ' ||
   --                                   substr(p_dateString, 13, 2) || ':' ||
   --                                   substr(p_dateString, 16, 2) || ':' ||
   --                                   substr(p_dateString, 19, 2)
   --                                  ,'yyyy-Mon-dd hh24:mi:ss')
   --                          ,'YYYY-MM-DD"T"hh24:mi:ss');
   --    end if;
   --    return v_isoDate;
   --  end mica_toISOchar;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a specific varchar2 input date (yyyy mon dd hh24:mi:ss.s) and returns an
   --  ISO-8601 formatted date in VARCHAR2 datatype.</I></PRE>
   FUNCTION mica_toISOchar(p_dateString IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_isoDate      VARCHAR2(19);
   BEGIN
      IF p_dateString IS NULL
      THEN
         v_isoDate   := '0000-01-01T00:00:00';
      ELSE
         v_isoDate   :=
            TO_CHAR(TO_DATE(   SUBSTR(p_dateString, 1, 4)
                            || '-'
                            || SUBSTR(p_dateString, 5, 4)
                            || '-'
                            || SUBSTR(p_dateString, 9, 3)
                            || ' '
                            || SUBSTR(p_dateString, 13, 2)
                            || ':'
                            || SUBSTR(p_dateString, 16, 2)
                            || ':'
                            || SUBSTR(p_dateString, 19, 2),
                            'yyyy-Mon-dd hh24:mi:ss'),
                    'YYYY-MM-DD"T"hh24:mi:ss');
      END IF;

      RETURN v_isoDate;
   END mica_toISOchar;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toISOdate(p_dateString in varchar2) return date is
   --    v_isoDate date;
   --  begin
   --    if p_dateString is NULL
   --    then
   --      v_isoDate := to_date('1800-01-01T00:00:00', 'RRRR-MM-DD HH24:MI:SS');
   --    else
   --      v_isoDate := to_date(substr(p_dateString, 1, 4) || '-' ||
   --                           substr(p_dateString, 5, 4) || '-' ||
   --                           substr(p_dateString, 9, 3) || ' ' ||
   --                           substr(p_dateString, 13, 2) || ':' ||
   --                           substr(p_dateString, 16, 2) || ':' ||
   --                           substr(p_dateString, 19, 2)
   --                          ,'RRRR-MM-DD HH24:MI:SS');
   --    end if;
   --    return v_isoDate;
   --  end mica_toISOdate;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a specific varchar2 input date (yyyy mon dd hh24:mi:ss.s) and returns an
   --  ISO-8601 formatted date in DATE datatype.</I></PRE>
   FUNCTION mica_toISOdate(p_dateString IN VARCHAR2)
      RETURN DATE
   IS
      v_isoDate      DATE;
   BEGIN
      IF p_dateString IS NULL
      THEN
         v_isoDate   := TO_DATE('1800-01-01T00:00:00', 'RRRR-MM-DD HH24:MI:SS');
      ELSE
         v_isoDate   :=
            TO_DATE(   SUBSTR(p_dateString, 1, 4)
                    || '-'
                    || SUBSTR(p_dateString, 5, 4)
                    || '-'
                    || SUBSTR(p_dateString, 9, 3)
                    || ' '
                    || SUBSTR(p_dateString, 13, 2)
                    || ':'
                    || SUBSTR(p_dateString, 16, 2)
                    || ':'
                    || SUBSTR(p_dateString, 19, 2),
                    'RRRR-MM-DD HH24:MI:SS');
      END IF;

      RETURN v_isoDate;
   END mica_toISOdate;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toMonth(p_monthNum in number) return varchar2 is
   --    v_mnChar varchar2(2);
   --  begin
   --    if p_monthNum between 1 and 9
   --    then
   --      v_mnChar := '0' || to_char(p_monthNum);
   --    else
   --      v_mnChar := to_char(p_monthNum);
   --    end if;
   --    return v_mnChar;
   --  end;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a number representation of the month and outputs a character represetnation
   --  of the same.</I></PRE>
   FUNCTION mica_toMonth(p_monthNum IN NUMBER)
      RETURN VARCHAR2
   IS
      v_mnChar       VARCHAR2(2);
   BEGIN
      IF p_monthNum BETWEEN 1 AND 9
      THEN
         v_mnChar    :=
               '0'
            || TO_CHAR(p_monthNum);
      ELSE
         v_mnChar    := TO_CHAR(p_monthNum);
      END IF;

      RETURN v_mnChar;
   END;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toDay(p_dateString in varchar2) return varchar2 is
   --    v_day    number;
   --    v_dyChar varchar2(2);
   --  begin
   --    v_day := extract(day from to_date(substr(p_dateString, 1, 4) || '-' ||
   --                             substr(p_dateString, 5, 4) || '-' ||
   --                             substr(p_dateString, 9, 3) || ' ' ||
   --                             substr(p_dateString, 13, 2) || ':' ||
   --                             substr(p_dateString, 16, 2) || ':' ||
   --                             substr(p_dateString, 19, 2)
   --                            ,'RRRR-MM-DD HH24:MI:SS'));
   --    if v_day between 1 and 9
   --    then
   --      v_dyChar := '0' || to_char(v_day);
   --    else
   --      v_dyChar := to_char(v_day);
   --    end if;
   --    return v_dyChar;
   --  end mica_toDay;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts a character representation of a DATE (MICA output format) and returns the day number
   -- in VARCHAR2.</I></PRE>
   FUNCTION mica_toDay(p_dateString IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_day          NUMBER;
      v_dyChar       VARCHAR2(2);
   BEGIN
      v_day       :=
         EXTRACT(DAY FROM TO_DATE(   SUBSTR(p_dateString, 1, 4)
                                  || '-'
                                  || SUBSTR(p_dateString, 5, 4)
                                  || '-'
                                  || SUBSTR(p_dateString, 9, 3)
                                  || ' '
                                  || SUBSTR(p_dateString, 13, 2)
                                  || ':'
                                  || SUBSTR(p_dateString, 16, 2)
                                  || ':'
                                  || SUBSTR(p_dateString, 19, 2),
                                  'RRRR-MM-DD HH24:MI:SS'));

      IF v_day BETWEEN 1 AND 9
      THEN
         v_dyChar    :=
               '0'
            || TO_CHAR(v_day);
      ELSE
         v_dyChar    := TO_CHAR(v_day);
      END IF;

      RETURN v_dyChar;
   END mica_toDay;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toHour(p_dateString in varchar2) return varchar2 is
   --    v_hour   number;
   --    v_hrChar varchar2(2);
   --  begin
   --    v_hour := extract(hour from to_timestamp(p_dateString
   --                                  ,'YYYY Mon DD hh24:mi:ssxff3'));
   --    if v_hour between 0 and 9
   --    then
   --      v_hrChar := '0' || to_char(v_hour);
   --    else
   --      v_hrChar := to_char(v_hour);
   --    end if;
   --    return v_hrChar;
   --  end mica_toHour;
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts a character representation of a DATE (MICA output format) and returns the month
   --  number in VARCHAR2.</I></PRE>
   FUNCTION mica_toHour(p_dateString IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_hour         NUMBER;
      v_hrChar       VARCHAR2(2);
   BEGIN
      v_hour      := EXTRACT(HOUR FROM TO_TIMESTAMP(p_dateString, 'YYYY Mon DD hh24:mi:ssxff3'));

      IF v_hour BETWEEN 0 AND 9
      THEN
         v_hrChar    :=
               '0'
            || TO_CHAR(v_hour);
      ELSE
         v_hrChar    := TO_CHAR(v_hour);
      END IF;

      RETURN v_hrChar;
   END mica_toHour;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toMinute(p_dateString in varchar2) return varchar2 is
   --    v_minute number;
   --    v_mnChar varchar2(2);
   --  begin
   --    v_minute := extract(minute from
   --                        to_timestamp(p_dateString
   --                                    ,'YYYY Mon DD hh24:mi:ssxff3'));
   --    if v_minute between 0 and 9
   --    then
   --      v_mnChar := '0' || to_char(v_minute);
   --    else
   --      v_mnChar := to_char(v_minute);
   --    end if;
   --    return v_mnChar;
   --  end mica_toMinute;
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts a character representation of a DATE (MICA output format) and returns the minute
   --  number in VARCHAR2.</I></PRE>
   FUNCTION mica_toMinute(p_dateString IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_minute       NUMBER;
      v_mnChar       VARCHAR2(2);
   BEGIN
      v_minute    := EXTRACT(MINUTE FROM TO_TIMESTAMP(p_dateString, 'YYYY Mon DD hh24:mi:ssxff3'));

      IF v_minute BETWEEN 0 AND 9
      THEN
         v_mnChar    :=
               '0'
            || TO_CHAR(v_minute);
      ELSE
         v_mnChar    := TO_CHAR(v_minute);
      END IF;

      RETURN v_mnChar;
   END mica_toMinute;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_jdateToISOdate(p_jDate in number default null) return date is
   --    v_trunc_jdate number;
   --    v_jdate       date;
   --  begin
   --    v_trunc_jdate := trunc(p_jdate);
   --
   --    if length(trim(translate(p_jdate, '*-.0123456789', ' '))) is not null
   --       or p_jdate is null
   --    then
   --      v_jdate := to_date('1800-01-01T00:00', 'YYYY-MM-DD"T"hh24:mi');
   --    else
   --      if p_jdate is not null
   --      then
   --        v_jdate := to_date(to_char(to_date(v_trunc_jdate, 'J') +
   --                                   numtodsinterval(p_jdate - v_trunc_jdate + .5
   --                                                  ,'DAY')
   --                                  ,'YYYY-MM-DD"T"hh24:mi:ss')
   --                          ,'YYYY-MM-DD"T"hh24:mi:ss');
   --      end if;
   --    end if;
   --    return v_jdate;
   --  end mica_jdateToISOdate;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I></I></PRE>
   FUNCTION mica_jdateToISOdate(p_jDate IN NUMBER DEFAULT NULL)
      RETURN DATE
   IS
      v_trunc_jdate  NUMBER;
      v_jdate        DATE;
   BEGIN
      v_trunc_jdate := TRUNC(p_jdate);

      IF    LENGTH(TRIM(TRANSLATE(p_jdate, '*-.0123456789', ' '))) IS NOT NULL
         OR p_jdate IS NULL
      THEN
         v_jdate     := TO_DATE('1800-01-01T00:00', 'YYYY-MM-DD"T"hh24:mi');
      ELSE
         IF p_jdate IS NOT NULL
         THEN
            v_jdate     :=
               TO_DATE(
                  TO_CHAR(
                       TO_DATE(v_trunc_jdate, 'J')
                     + NUMTODSINTERVAL(p_jdate - v_trunc_jdate + .5, 'DAY'),
                     'YYYY-MM-DD"T"hh24:mi:ss'),
                  'YYYY-MM-DD"T"hh24:mi:ss');
         END IF;
      END IF;

      RETURN v_jdate;
   END mica_jdateToISOdate;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_jdateToISOchar(p_jDate in number default null)
   --    return varchar2 is
   --    v_trunc_jdate number;
   --    v_jdate       varchar2(20);
   --  begin
   --    v_trunc_jdate := trunc(p_jdate);
   --
   --    if length(trim(translate(p_jdate, '*-.0123456789', ' '))) is not null
   --       or p_jdate is null
   --    then
   --      v_jdate := '1800-01-01T00:00';
   --    else
   --      if p_jdate is not null
   --      then
   --        v_jdate := to_char(to_date(v_trunc_jdate, 'J') +
   --                           numtodsinterval((p_jdate - v_trunc_jdate) + .5
   --                                          ,'DAY')
   --                          ,'YYYY-MM-DD"T"hh24:mi');
   --      end if;
   --    end if;
   --    return v_jdate;
   --  end mica_jdateToISOchar;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts number input (Julian decimal date) and splits it into two parts: a truncated
   --  number and the remaining decimal value.  The truncated number is converted to a date and the remaining
   --  decimal converted to an INTERVAL DAY TO SECOND.  The two values are then "added" together to return a
   --  a date in VARCHAR2 datatype.</I></PRE>
   FUNCTION mica_jdateToISOchar(p_jDate IN NUMBER DEFAULT NULL)
      RETURN VARCHAR2
   IS
      v_trunc_jdate  NUMBER;
      v_jdate        VARCHAR2(20);
   BEGIN
      v_trunc_jdate := TRUNC(p_jdate);

      IF    LENGTH(TRIM(TRANSLATE(p_jdate, '*-.0123456789', ' '))) IS NOT NULL
         OR p_jdate IS NULL
      THEN
         v_jdate     := '1800-01-01T00:00';
      ELSE
         IF p_jdate IS NOT NULL
         THEN
            v_jdate     :=
               TO_CHAR(
                    TO_DATE(v_trunc_jdate, 'J')
                  + NUMTODSINTERVAL((p_jdate - v_trunc_jdate) + .5, 'DAY'),
                  'YYYY-MM-DD"T"hh24:mi');
         END IF;
      END IF;

      RETURN v_jdate;
   END mica_jdateToISOchar;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  FUNCTION to_julian(p_date IN VARCHAR2) RETURN NUMBER IS
   --    v_hour      NUMBER;
   --    v_minute    NUMBER;
   --    v_jday      VARCHAR2(15);
   --    v_jfraction NUMBER;
   --    v_jdate     NUMBER;
   --  BEGIN
   --    v_jday      := TO_CHAR(TO_DATE(p_date, 'YYYY/MM/DD hh24:mi:ss'), 'J');
   --    v_hour      := TO_NUMBER(SUBSTR(TO_CHAR(TO_DATE(p_date,'YYYY/MM/DD hh24:mi:ss'),'hh24:mi'),1,2));
   --    v_minute    := TO_NUMBER(SUBSTR(TO_CHAR(TO_DATE(p_date,'YYYY/MM/DD hh24:mi:ss'),'hh24:mi'),4,2));
   --    v_jfraction := (v_hour / 24) + ((v_minute / 60) / 24);
   --    v_jdate     := TO_NUMBER(v_jday) + ROUND(v_jfraction, 6);
   --    RETURN v_jdate;
   --  END to_julian;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a date in VARCHAR2 datatype and converts it to a Julian date with decimal
   --  fraction.</I></PRE>
   FUNCTION to_julian(p_date IN VARCHAR2)
      RETURN NUMBER
   IS
      v_hour         NUMBER;
      v_minute       NUMBER;
      v_jday         VARCHAR2(15);
      v_jfraction    NUMBER;
      v_jdate        NUMBER;
   BEGIN
      v_jday      := TO_CHAR(TO_DATE(p_date, 'YYYY/MM/DD hh24:mi:ss'), 'J');
      v_hour      :=
         TO_NUMBER(SUBSTR(TO_CHAR(TO_DATE(p_date, 'YYYY/MM/DD hh24:mi:ss'), 'hh24:mi'), 1, 2));
      v_minute    :=
         TO_NUMBER(SUBSTR(TO_CHAR(TO_DATE(p_date, 'YYYY/MM/DD hh24:mi:ss'), 'hh24:mi'), 4, 2));
      v_jfraction := (v_hour / 24) + ((v_minute / 60) / 24);
      v_jdate     := TO_NUMBER(v_jday) + ROUND(v_jfraction, 6);
      RETURN v_jdate;
   END to_julian;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  FUNCTION to_julian(p_date IN DATE) RETURN NUMBER IS
   --    v_hour      NUMBER;
   --    v_minute    NUMBER;
   --    v_jday      VARCHAR2(15);
   --    v_jfraction NUMBER;
   --    v_jdate     NUMBER;
   --  BEGIN
   --    v_jday      := TO_CHAR(p_date, 'J');
   --    v_hour      := SUBSTR(TO_CHAR(p_date, 'hh24:mi'), 1, 2);
   --    v_minute    := SUBSTR(TO_CHAR(p_date, 'hh24:mi'), 4, 2);
   --    v_jfraction := (v_hour / 24) + ((v_minute / 60) / 24);
   --    v_jdate     := TO_NUMBER(v_jday) + ROUND(v_jfraction, 6);
   --    RETURN v_jdate;
   --  END to_julian;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a date in VARCHAR2 datatype and converts it to a Julian date with decimal
   --  fraction.</I></PRE>
   FUNCTION to_julian(p_date IN DATE)
      RETURN NUMBER
   IS
      v_hour         NUMBER;
      v_minute       NUMBER;
      v_jday         VARCHAR2(15);
      v_jfraction    NUMBER;
      v_jdate        NUMBER;
   BEGIN
      v_jday      := TO_CHAR(p_date, 'J');
      v_hour      := SUBSTR(TO_CHAR(p_date, 'hh24:mi'), 1, 2);
      v_minute    := SUBSTR(TO_CHAR(p_date, 'hh24:mi'), 4, 2);
      v_jfraction := (v_hour / 24) + ((v_minute / 60) / 24);
      v_jdate     := TO_NUMBER(v_jday) + ROUND(v_jfraction, 6);
      RETURN v_jdate;
   END to_julian;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_toMonthYear(p_yr in number, p_mth in number) return varchar2 is
   --    v_isoDate varchar2(15);
   --    v_month   varchar2(2);
   --  begin
   --    if p_mth between 1 and 9
   --    then
   --      v_month := '0' || to_char(trim(p_mth));
   --    else
   --      v_month := to_char(trim(p_mth));
   --    end if;
   --    v_isoDate := replace(to_char(to_date(v_month || '-' || p_yr, 'MM-RRRR')
   --                                ,'Mon-RRRR')
   --                        ,' ');
   --    return v_isoDate;
   --  end mica_toMonthYear;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts two input parameters, a 4 digit year NUMBER type, and a 1 or 2-digit
   --  month number (for example: "11" or "1").  It returns a Month-Year format ("Jan-1900")</I></PRE>
   FUNCTION mica_toMonthYear(p_yr IN NUMBER, p_mth IN NUMBER)
      RETURN VARCHAR2
   IS
      v_isoDate      VARCHAR2(15);
      v_month        VARCHAR2(2);
   BEGIN
      IF p_mth BETWEEN 1 AND 9
      THEN
         v_month     :=
               '0'
            || TO_CHAR(TRIM(p_mth));
      ELSE
         v_month     := TO_CHAR(TRIM(p_mth));
      END IF;

      v_isoDate   :=
         REPLACE(TO_CHAR(TO_DATE(   v_month
                                 || '-'
                                 || p_yr,
                                 'MM-RRRR'),
                         'Mon-RRRR'),
                 ' ');
      RETURN v_isoDate;
   END mica_toMonthYear;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  FUNCTION to_geoCoord(p_dec IN VARCHAR2, p_type IN VARCHAR2) RETURN VARCHAR2 IS
   --    v_deg_abs      number;
   --    v_deg_trunc    number;
   --    v_minute_dec   NUMBER;
   --    v_minute_trunc NUMBER;
   --    v_sec          NUMBER;
   --    v_symbol       VARCHAR2(1);
   --    v_dms          VARCHAR2(50);
   --
   --    /* Check and convert input to specifified latitude output */
   --    FUNCTION latitude(p_deg IN NUMBER, p_coord IN VARCHAR2) RETURN VARCHAR2 IS
   --      v_out VARCHAR2(20);
   --    BEGIN
   --      if p_deg BETWEEN 0 AND 90
   --      THEN
   --        v_out := TRIM(LTRIM(p_coord, '+')) || ' N';
   --      ELSE
   --        IF p_deg >= (-90)
   --           and p_deg < 0
   --        THEN
   --          v_out := TRIM(LTRIM(p_coord, '-')) || ' S';
   --        else
   --          if p_deg < -90
   --             or p_deg > 90
   --          then
   --            raise_application_error(-20101
   --                                   ,'Latitude not within (+/- 90) range limit.');
   --          END IF;
   --        end if;
   --      end if;
   --
   --      RETURN v_out;
   --    END;
   --
   --    /* Check and convert input to specifified longitude output */
   --    FUNCTION longitude(p_deg IN NUMBER, p_coord IN VARCHAR2) RETURN VARCHAR2 IS
   --      v_out VARCHAR2(20);
   --    BEGIN
   --      IF p_deg BETWEEN 0 AND 180
   --      THEN
   --        v_out := TRIM(LTRIM(p_coord, '+')) || ' E';
   --      ELSE
   --        IF p_deg BETWEEN (-180) AND (-1)
   --        THEN
   --          v_out := TRIM(LTRIM(p_coord, '-')) || ' W';
   --        else
   --          if p_deg < -180
   --             or p_deg > 180
   --          then
   --            raise_application_error(-20101
   --                                   ,'Longitude not within (+/- 180) range limit.');
   --          END IF;
   --        END IF;
   --      END IF;
   --
   --      RETURN v_out;
   --    END;
   --
   --  BEGIN
   --    v_deg_abs      := abs(p_dec);
   --    v_deg_trunc    := trunc(abs(p_dec));
   --    v_minute_dec   := (v_deg_abs - v_deg_trunc) * 60;
   --    v_minute_trunc := trunc(v_minute_dec);
   --    v_sec          := round((v_minute_dec - v_minute_trunc) * 60,2);
   --
   --    IF p_type = 'LON'
   --    THEN
   --      v_dms := longitude(p_deg   => to_number(p_dec)
   --                        ,p_coord => v_symbol || v_deg_trunc || chr(176) || ' ' || v_minute_trunc || chr(39) || ' ' ||
   --                                    v_sec || chr(34));
   --    ELSE
   --      if p_type = 'LAT'
   --      then
   --        v_dms := latitude(p_deg   => to_number(p_dec)
   --                         ,p_coord => v_symbol || v_deg_trunc || chr(176) || ' ' || v_minute_trunc || chr(39) || ' ' ||
   --                                    v_sec || chr(34));
   --      else
   --        if p_type not in ('LAT', 'LON')
   --        then
   --          raise_application_error(-20101
   --                                 ,'Function "to_geoCoord" requires a type input of either "LAT" or "LON".');
   --        END IF;
   --      END IF;
   --    end if;
   --
   --    RETURN v_dms;
   --  END;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  This function accepts a geo-coordinate in varchar2 datatype and returns a  "d m s" type format.
   --  Error Handling consists of checking the numbers for proper limitiations (e.g. latitude not greater
   --  or less than +/- 90 degrees and longitude not greater or less than +/- 180 degrees).  It contains
   --  two private functions to handle either latitude or longitude conversion based on the  passed value
   --  of the p_type parameter: 'LAT' or 'LON'. any thing else will return ORA-20101 custom-defined errors.</I></PRE>
   FUNCTION to_geoCoord(p_dec IN VARCHAR2, p_type IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_deg_abs      NUMBER;
      v_deg_trunc    NUMBER;
      v_minute_dec   NUMBER;
      v_minute_trunc NUMBER;
      v_sec          NUMBER;
      v_symbol       VARCHAR2(1);
      v_dms          VARCHAR2(50);

      /* Check and convert input to specifified latitude output */
      FUNCTION latitude(p_deg IN NUMBER, p_coord IN VARCHAR2)
         RETURN VARCHAR2
      IS
         v_out          VARCHAR2(20);
      BEGIN
         IF p_deg BETWEEN 0 AND 90
         THEN
            v_out       :=
                  TRIM(LTRIM(p_coord, '+'))
               || ' N';
         ELSE
            IF     p_deg >= (-90)
               AND p_deg < 0
            THEN
               v_out       :=
                     TRIM(LTRIM(p_coord, '-'))
                  || ' S';
            ELSE
               IF    p_deg < -90
                  OR p_deg > 90
               THEN
                  raise_application_error(-20101, 'Latitude not within (+/- 90) range limit.');
               END IF;
            END IF;
         END IF;

         RETURN v_out;
      END;

      /* Check and convert input to specifified longitude output */
      FUNCTION longitude(p_deg IN NUMBER, p_coord IN VARCHAR2)
         RETURN VARCHAR2
      IS
         v_out          VARCHAR2(20);
      BEGIN
         IF p_deg BETWEEN 0 AND 180
         THEN
            v_out       :=
                  TRIM(LTRIM(p_coord, '+'))
               || ' E';
         ELSE
            IF p_deg BETWEEN (-180) AND (-1)
            THEN
               v_out       :=
                     TRIM(LTRIM(p_coord, '-'))
                  || ' W';
            ELSE
               IF    p_deg < -180
                  OR p_deg > 180
               THEN
                  raise_application_error(-20101, 'Longitude not within (+/- 180) range limit.');
               END IF;
            END IF;
         END IF;

         RETURN v_out;
      END;

   BEGIN
      v_deg_abs   := ABS(p_dec);
      v_deg_trunc := TRUNC(ABS(p_dec));
      v_minute_dec := (v_deg_abs - v_deg_trunc) * 60;
      v_minute_trunc := TRUNC(v_minute_dec);
      v_sec       := ROUND((v_minute_dec - v_minute_trunc) * 60, 2);

      IF p_type = 'LON'
      THEN
         v_dms       :=
            longitude(p_deg       => TO_NUMBER(p_dec),
                      p_coord     =>   v_symbol
                                    || v_deg_trunc
                                    || CHR(176)
                                    || ' '
                                    || v_minute_trunc
                                    || CHR(39)
                                    || ' '
                                    || v_sec
                                    || CHR(34));
      ELSE
         IF p_type = 'LAT'
         THEN
            v_dms       :=
               latitude(p_deg       => TO_NUMBER(p_dec),
                        p_coord     =>   v_symbol
                                      || v_deg_trunc
                                      || CHR(176)
                                      || ' '
                                      || v_minute_trunc
                                      || CHR(39)
                                      || ' '
                                      || v_sec
                                      || CHR(34));
         ELSE
            IF p_type NOT IN ('LAT', 'LON')
            THEN
               raise_application_error(
                  -20101,
                  'Function "to_geoCoord" requires a type input of either "LAT" or "LON".');
            END IF;
         END IF;
      END IF;

      RETURN v_dms;
   END;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function dec2DMS(p_dec in number) return varchar2 is
   --    v_deg    number;
   --    v_min    number;
   --    v_sec    number;
   --    v_symbol varchar2(1);
   --    v_dms    varchar2(50);
   --  begin
   --    v_deg := trunc(abs(p_dec));
   --    v_min := trunc((abs(p_dec) - v_deg) * 60);
   --    v_sec := round(60 / ((((abs(p_dec) - v_deg) * 60) - v_min) * 100), 2);
   --    if p_dec < 0
   --    then
   --      v_symbol := '-';
   --    else
   --      v_symbol := '+';
   --    end if;
   --    v_dms := v_symbol || v_deg || ' ' || v_min || ' ' || v_sec;
   --    return v_dms;
   --  end dec2DMS;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts decimal number (coordinate) and returns coordinate in "+/- dd mm ss" format.  This function
   --  is ignorant of North/South or East/West conventions and does not consider polar coordinate limitations (for example, 3-digit
   --  for degree number). </I></PRE>
   FUNCTION dec2DMS(p_dec IN NUMBER)
      RETURN VARCHAR2
   IS
      v_deg          NUMBER;
      v_min          NUMBER;
      v_sec          NUMBER;
      v_symbol       VARCHAR2(1);
      v_dms          VARCHAR2(50);
   BEGIN
      v_deg       := TRUNC(ABS(p_dec));
      v_min       := TRUNC((ABS(p_dec) - v_deg) * 60);
      v_sec       := ROUND(60 / ((((ABS(p_dec) - v_deg) * 60) - v_min) * 100), 2);

      IF p_dec < 0
      THEN
         v_symbol    := '-';
      ELSE
         v_symbol    := '+';
      END IF;

      v_dms       :=
            v_symbol
         || v_deg
         || ' '
         || v_min
         || ' '
         || v_sec;
      RETURN v_dms;
   END dec2DMS;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  FUNCTION dec2DMS_Split(p_dec IN NUMBER, p_outType IN VARCHAR2 DEFAULT NULL)
   --    RETURN VARCHAR2 IS
   --    v_deg VARCHAR2(50);
   --    v_out VARCHAR2(50);
   --  BEGIN
   --    v_deg := pk_utilities.dec2DMS(p_dec);
   --
   --    IF p_outType IS NULL
   --    THEN
   --      v_out := TRIM(SUBSTR(v_deg, 1, INSTR(v_deg, ' ', 1))) || CHR(176) || ' ' ||
   --               TRIM(SUBSTR(v_deg
   --                          ,INSTR(v_deg, ' ', 1)
   --                          ,INSTR(v_deg, ' ', 1) - 1)) || '''' || ' ' ||
   --               TRIM(SUBSTR(v_deg, INSTR(v_deg, ' ', 1, 2))) || '"';
   --    ELSE
   --      IF UPPER(p_outType) = 'D'
   --      THEN
   --        v_out := TRIM(SUBSTR(v_deg, 1, INSTR(v_deg, ' ', 1))) || CHR(176);
   --      ELSE
   --        IF UPPER(p_outType) = 'M'
   --        THEN
   --          v_out := TRIM(SUBSTR(v_deg
   --                              ,INSTR(v_deg, ' ', 1)
   --                              ,INSTR(v_deg, ' ', 1) - 1)) || '''';
   --        ELSE
   --          IF UPPER(p_outType) = 'S'
   --          THEN
   --            v_out := TRIM(SUBSTR(v_deg, INSTR(v_deg, ' ', 1, 2))) || '"';
   --          END IF;
   --        END IF;
   --      END IF;
   --    END IF;
   --
   --    RETURN v_out;
   --  END dec2DMS_Split;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts decimal coordinate input and outputs a formatted character string.  NOTE: This function is
   --  dumb in terms of Cardinal direction (for example +/-, N/S, E/W, respectively).</I></PRE>
   FUNCTION dec2DMS_Split(p_dec IN NUMBER, p_outType IN VARCHAR2 DEFAULT NULL)
      RETURN VARCHAR2
   IS
      v_deg          VARCHAR2(50);
      v_out          VARCHAR2(50);
   BEGIN
      v_deg       := pk_utilities.dec2DMS(p_dec);

      IF p_outType IS NULL
      THEN
         v_out       :=
               TRIM(SUBSTR(v_deg, 1, INSTR(v_deg, ' ', 1)))
            || CHR(176)
            || ' '
            || TRIM(SUBSTR(v_deg, INSTR(v_deg, ' ', 1), INSTR(v_deg, ' ', 1) - 1))
            || ''''
            || ' '
            || TRIM(SUBSTR(v_deg,
                           INSTR(v_deg,
                                 ' ',
                                 1,
                                 2)))
            || '"';
      ELSE
         IF UPPER(p_outType) = 'D'
         THEN
            v_out       :=
                  TRIM(SUBSTR(v_deg, 1, INSTR(v_deg, ' ', 1)))
               || CHR(176);
         ELSE
            IF UPPER(p_outType) = 'M'
            THEN
               v_out       :=
                     TRIM(SUBSTR(v_deg, INSTR(v_deg, ' ', 1), INSTR(v_deg, ' ', 1) - 1))
                  || '''';
            ELSE
               IF UPPER(p_outType) = 'S'
               THEN
                  v_out       :=
                        TRIM(SUBSTR(v_deg,
                                    INSTR(v_deg,
                                          ' ',
                                          1,
                                          2)))
                     || '"';
               END IF;
            END IF;
         END IF;
      END IF;

      RETURN v_out;
   END dec2DMS_Split;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_ra2Deg(p_ra in varchar2) return number is
   --    v_out number;
   --  begin
   --    v_out := round((to_number(trim(substr(p_ra, 1, instr(p_ra, ' ', 1, 1)))) * 15) +
   --                   ((to_number(trim(substr(p_ra
   --                                          ,instr(p_ra, ' ', 1, 1) + 1
   --                                          ,2))) / 4) +
   --                   (to_number(trim(substr(p_ra, instr(p_ra, ' ', 1, 2) + 1))) / 240))
   --                  ,6);
   --    return v_out;
   --  end mica_ra2Deg;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts aright ascension value (sexagesimal "hh mi ss.ss") and returns a decimal degree NUMBER.</I></PRE>
   FUNCTION mica_ra2Deg(p_ra IN VARCHAR2)
      RETURN NUMBER
   IS
      v_out          NUMBER;
   BEGIN
      v_out       :=
         ROUND(  (  TO_NUMBER(TRIM(SUBSTR(p_ra,
                                          1,
                                          INSTR(p_ra,
                                                ' ',
                                                1,
                                                1))))
                  * 15)
               + (  (  TO_NUMBER(TRIM(SUBSTR(p_ra,
                                               INSTR(p_ra,
                                                     ' ',
                                                     1,
                                                     1)
                                             + 1,
                                             2)))
                     / 4)
                  + (  TO_NUMBER(TRIM(SUBSTR(p_ra,
                                               INSTR(p_ra,
                                                     ' ',
                                                     1,
                                                     2)
                                             + 1)))
                     / 240)),
               6);
      RETURN v_out;
   END mica_ra2Deg;

   --  <CODE><PRE CLASS="DECL_TEXT">
   --  function mica_decl2Deg(p_decl in varchar2) return number is
   --    v_out  number;
   --    v_deg  number;
   --    v_min  number;
   --    v_sec  number;
   --    v_sign varchar2(1);
   --  begin
   --    v_sign := trim(substr(p_decl, 1, 1));
   --    v_deg  := to_number(trim(substr(p_decl
   --                                   ,instr(p_decl, ' ', -1, 3) + 1
   --                                   ,2)));
   --    v_min  := (to_number(trim(substr(p_decl
   --                                    ,instr(p_decl, ' ', -1, 2) + 1
   --                                    ,2))) / 60);
   --    v_sec  := (to_number(trim(substr(p_decl, instr(p_decl, ' ', -1, 1) + 1))) / 3600);
   --    if v_sign = '+'
   --    then
   --      v_out := v_deg + v_min + v_sec;
   --    else
   --      if v_sign = '-'
   --      then
   --        v_out := ((v_deg + v_min + v_sec) * -1);
   --      end if;
   --    end if;
   --    return round(v_out, 6);
   --  end mica_decl2Deg;
   --  </PRE></CODE>
   --  <PRE CLASS="DESC_TEXT"><I>  Accepts a degree coordinate ("+/-  DD MI SS") and returns a decimal degree (NUMBER).</I></PRE>
   FUNCTION mica_decl2Deg(p_decl IN VARCHAR2)
      RETURN NUMBER
   IS
      v_out          NUMBER;
      v_deg          NUMBER;
      v_min          NUMBER;
      v_sec          NUMBER;
      v_sign         VARCHAR2(1);
   BEGIN
      v_sign      := TRIM(SUBSTR(p_decl, 1, 1));
      v_deg       :=
         TO_NUMBER(TRIM(SUBSTR(p_decl,
                                 INSTR(p_decl,
                                       ' ',
                                       -1,
                                       3)
                               + 1,
                               2)));
      v_min       :=
         (  TO_NUMBER(TRIM(SUBSTR(p_decl,
                                    INSTR(p_decl,
                                          ' ',
                                          -1,
                                          2)
                                  + 1,
                                  2)))
          / 60);
      v_sec       :=
         (  TO_NUMBER(TRIM(SUBSTR(p_decl,
                                    INSTR(p_decl,
                                          ' ',
                                          -1,
                                          1)
                                  + 1)))
          / 3600);

      IF v_sign = '+'
      THEN
         v_out       := v_deg + v_min + v_sec;
      ELSE
         IF v_sign = '-'
         THEN
            v_out       := ((v_deg + v_min + v_sec) * -1);
         END IF;
      END IF;

      RETURN ROUND(v_out, 6);
   END mica_decl2Deg;
END pk_utilities;

/
