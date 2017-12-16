--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function GETCOUNTRY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "QUAKE"."GETCOUNTRY" (xName IN VARCHAR2)
   RETURN VARCHAR2
IS
   xCntry         VARCHAR2(20);
BEGIN
   SELECT DISTINCT country
     INTO xCntry
     FROM states
    WHERE EXISTS
             (SELECT 'X'
                FROM states
               WHERE state_name = xName);

   RETURN xCntry;
END;

/
