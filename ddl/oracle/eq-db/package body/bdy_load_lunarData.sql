--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body LOAD_LUNARDATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "QUAKE"."LOAD_LUNARDATA" IS
  /* input record types */
  TYPE sourcedata_type IS TABLE OF moondist_transform%ROWTYPE INDEX BY PLS_INTEGER;

  sourcedata         sourcedata_type;
  moondist_trans_row moondist_trans%ROWTYPE;

  /* output record types */
  dist_rec moondist_type := moondist_type();
  pos_rec  moonpos_type := moonpos_type();
  date_rec moondate_type := moondate_type();

  FUNCTION data_transform(p_source IN SYS_REFCURSOR) RETURN moondist_ntt
    PIPELINED
    PARALLEL_ENABLE(PARTITION p_source BY ANY) IS
  BEGIN
    LOOP
      FETCH p_source BULK COLLECT
        INTO sourcedata LIMIT 100;
    
      FOR i IN 1 .. sourcedata.COUNT LOOP
        /* feed a single row */
        moondist_trans_row := sourcedata(i);
        /* reset variables */
        dist_rec := moondist_type();
        pos_rec  := moonpos_type();
        date_rec := moondate_type();
      
        /* Pipe distance record */
        dist_rec.transaction_id := moondist_seq.NEXTVAL;
        dist_rec.dist_id        := moondist_trans_row.dist_id;
        dist_rec.dist_topo      := moondist_trans_row.dist_topo;
        dist_rec.dist_grp       := moondist_trans_row.dist_grp;
        dist_rec.dist_grp_avg   := moondist_trans_row.dist_grp_avg;
        dist_rec.mvmt_direction := moondist_trans_row.mvmt_direction;
        dist_rec.km_minute      := moondist_trans_row.km_minute;
        dist_rec.km_hour        := moondist_trans_row.km_hour;
      
        PIPE ROW(dist_rec);
      
        /* Pipe position record */
        pos_rec.transaction_id        := moonpos_seq.NEXTVAL;
        pos_rec.dist_id               := moondist_trans_row.dist_id;
        pos_rec.right_ascension       := moondist_trans_row.right_ascension;
        pos_rec.ra_deg                := moondist_trans_row.ra_deg;
        pos_rec.ra_min                := moondist_trans_row.ra_min;
        pos_rec.ra_sec                := moondist_trans_row.ra_sec;
        pos_rec.ra_deg_minute         := moondist_trans_row.ra_deg_minute;
        pos_rec.ra_deg_mvmt_perminute := moondist_trans_row.ra_deg_mvmt_perminute;
        pos_rec.declination           := moondist_trans_row.declination;
        pos_rec.decl_degree           := moondist_trans_row.decl_degree;
        pos_rec.decl_minute           := moondist_trans_row.decl_minute;
        pos_rec.decl_second           := moondist_trans_row.decl_second;
        pos_rec.decl_deg              := moondist_trans_row.decl_deg;
        pos_rec.decl_mvmt             := moondist_trans_row.decl_mvmt;
      
        PIPE ROW(pos_rec);
      
        /* pipe date records */
        date_rec.transaction_id  := moondate_seq.NEXTVAL;
        date_rec.dist_id         := moondist_trans_row.dist_id;
        date_rec.yr_grp          := moondist_trans_row.yr_grp;
        date_rec.moon_j_date_dec := moondist_trans_row.moon_j_date_dec;
        date_rec.moon_jdate      := moondist_trans_row.moon_jdate;
        date_rec.moon_date       := moondist_trans_row.moon_date;
        date_rec.mth_yr          := moondist_trans_row.mth_yr;
        date_rec.yr              := moondist_trans_row.yr;
        date_rec.mth             := moondist_trans_row.mth;
        date_rec.dy              := moondist_trans_row.dy;
        date_rec.hr              := moondist_trans_row.hr;
        date_rec.mn              := moondist_trans_row.mn;
        date_rec.tme             := moondist_trans_row.tme;
      
        PIPE ROW(date_rec);
      END LOOP;
    
      EXIT WHEN p_source%NOTFOUND;
    END LOOP;
  
    CLOSE p_source;
  
    RETURN;
  END data_transform;

  PROCEDURE load_data IS
  BEGIN
    NULL;
  END load_data;
END load_lunardata;

/
