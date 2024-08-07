CREATE OR REPLACE PROCEDURE GET_QUERY_COUNTRY_LIST
(
	PAGE_NUMBER INTEGER,
	PAGE_SIZE INTEGER,
	SEARCH VARCHAR2,
	ORDER_COLUM VARCHAR2,
	ORDER_CRITERIA VARCHAR2
)
AS
	RESULTS SYS_REFCURSOR;
BEGIN
	OPEN RESULTS FOR
        WITH CTE (ID, NICE_NAME, ISO_CODE, PHONE_CODE) as (
            --- consulta ---
            SELECT ID, NICE_NAME, ISO_CODE, PHONE_CODE
            FROM DEMO.COUNTRY
            --- filtros por cada columna ---
            WHERE SEARCH IS NULL OR
                  (NICE_NAME LIKE SEARCH) OR
                  (ISO_CODE LIKE SEARCH) OR
                  (NICE_NAME LIKE SEARCH)
        )
        SELECT * 
        FROM CTE
        ORDER BY
        --- ordenamiento por cada columna y por cada criterio (ASC o DESC) ---
        CASE WHEN ORDER_COLUM = 'NICE_NAME' AND ORDER_CRITERIA = 'ASC' THEN NICE_NAME END ASC,
        CASE WHEN ORDER_COLUM = 'NICE_NAME' AND ORDER_CRITERIA = 'DESC' THEN NICE_NAME END DESC,
        CASE WHEN ORDER_COLUM = 'ISO_CODE' AND ORDER_CRITERIA = 'ASC' THEN ISO_CODE END ASC,
        CASE WHEN ORDER_COLUM = 'ISO_CODE' AND ORDER_CRITERIA = 'DESC' THEN ISO_CODE END DESC,
        CASE WHEN ORDER_COLUM = 'PHONE_CODE' AND ORDER_CRITERIA = 'ASC' THEN PHONE_CODE END ASC,
        CASE WHEN ORDER_COLUM = 'PHONE_CODE' AND ORDER_CRITERIA = 'DESC' THEN PHONE_CODE END DESC,
        --- ordenamiento defecto ---
        NICE_NAME ASC
        --- paginación ---
        OFFSET PAGE_SIZE * (PAGE_NUMBER - 1) ROWS FETCH NEXT PAGE_SIZE ROWS ONLY;
	
	DBMS_SQL.RETURN_RESULT(RESULTS);
END;
/

CALL GET_QUERY_COUNTRY_LIST(1, 10, 'C%', 'PHONE_CODE', 'ASC');
/