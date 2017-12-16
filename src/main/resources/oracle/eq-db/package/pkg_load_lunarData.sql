--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package LOAD_LUNARDATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "QUAKE"."LOAD_LUNARDATA" IS
  FUNCTION data_transform(p_source IN SYS_REFCURSOR) RETURN moondist_ntt
    PIPELINED
    PARALLEL_ENABLE(PARTITION p_source BY ANY);

  PROCEDURE load_data;
END load_lunardata;

/
