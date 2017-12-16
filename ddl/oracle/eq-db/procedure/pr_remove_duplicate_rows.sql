--------------------------------------------------------
--  File created - Saturday-December-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure REMOVE_DUPLICATE_ROWS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "QUAKE"."REMOVE_DUPLICATE_ROWS" (
  tabName     IN VARCHAR2,
  tabpk       IN VARCHAR2,
  tabunqcol   IN VARCHAR2
) AS
  xstmt   VARCHAR2(1000 CHAR);
BEGIN
  xstmt   := 
  'DELETE FROM #tabName#
  WHERE #tabPK# IN (
    SELECT #tabPK#
    FROM (
      SELECT 
        RANK() OVER(PARTITION BY #tabUnqCol# ORDER BY #tabPK# DESC) row_rank,
        #tabPK#,
        #tabUnqCol#
      FROM #tabName#
      WHERE ( #tabPK#, #tabUnqCol# ) IN (
        SELECT 
          #tabPK#,
          #tabUnqCol#
        FROM #tabName#
        WHERE #tabUnqCol# IN (
          SELECT 
            #tabUnqCol#
          FROM #tabName#
          GROUP BY #tabUnqCol# 
          HAVING COUNT(#tabUnqCol#) > 1)
      )
    )
    WHERE row_rank > 1)';
  xStmt := replace(xStmt,'#tabName#',tabName);
  xStmt := replace(xStmt,'#tabUnqCol#',tabUnqCol);
  xStmt := replace(xStmt,'#tabPK#',tabPK);
--  dbms_output.put_line(xStmt);
  EXECUTE IMMEDIATE xstmt;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    logger.log_error('ERROR: remove_duplicate_rows'
    || chr(10)
    || sqlerrm);
    ROLLBACK;
END remove_Duplicate_Rows;

/
