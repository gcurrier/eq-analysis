--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table LUNAR_COEFF_C
--------------------------------------------------------

  CREATE TABLE "QUAKE"."LUNAR_COEFF_C" 
   (	"D" NUMBER(*,0), 
	"M1" NUMBER(*,0), 
	"M2" NUMBER(*,0), 
	"F" NUMBER(*,0), 
	"O" NUMBER(*,0), 
	"SINE_COEFF" NUMBER(*,0), 
	"SINE_TIME" NUMBER, 
	"COSINE_COEFF" NUMBER(*,0), 
	"COSINE_TIME" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EQ_DATA" ;
