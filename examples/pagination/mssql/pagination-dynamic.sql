/*
CREATE TABLE demo.Query (
  Code VARCHAR(100) NOT NULL,
  Query VARCHAR(MAX) NOT NULL,
  Columns VARCHAR(1000) NOT NULL
);
*/

/*
INSERT INTO demo.Query (Code, Query, Columns) VALUES 
(
    'COUNTRY_LIST', 
    'SELECT Id, NiceName, IsoCode, PhoneCode
    FROM demo.Country', 
    'Id, NiceName, IsoCode, PhoneCode'
);
*/

CREATE OR ALTER PROCEDURE BuildQuery
	@Code VARCHAR(100),
	@TSQL NVARCHAR(MAX) OUT
AS
BEGIN
	-- consulta par�metros por @Code en tabla demo.Query
    -- SELECT * FROM demo.Query WHERE CODE = @Code
    -- construye el SQL de la consulta
    -- ...
    -- retorna el SQL para la ejecuci�n din�mica
	SET @TSQL = 
	N'
	WITH cte AS (
		--- consulta ---
		SELECT Id, NiceName, IsoCode, PhoneCode
		FROM demo.Country
		--- filtros por cada columna ---
		WHERE	@Search IS NULL OR
				(NiceName LIKE @Search) OR
				(IsoCode LIKE @Search) OR
				(PhoneCode LIKE @Search)
	) 
	SELECT *
	FROM cte
	ORDER BY
		--- ordenamiento por cada columna y por cada criterio (ASC o DESC) ---
		CASE WHEN @OrderColumn = ''NiceName'' AND @OrderCriteria = ''ASC'' THEN NiceName END ASC,
		CASE WHEN @OrderColumn = ''NiceName'' AND @OrderCriteria = ''DESC'' THEN NiceName END DESC,
		CASE WHEN @OrderColumn = ''IsoCode'' AND @OrderCriteria = ''ASC'' THEN IsoCode END ASC,
		CASE WHEN @OrderColumn = ''IsoCode'' AND @OrderCriteria = ''DESC'' THEN IsoCode END DESC,
		CASE WHEN @OrderColumn = ''PhoneCode'' AND @OrderCriteria = ''ASC'' THEN PhoneCode END ASC,
		CASE WHEN @OrderColumn = ''PhoneCode'' AND @OrderCriteria = ''DESC'' THEN PhoneCode END DESC,
		--- ordenamiento defecto ---
		NiceName ASC
	--- paginación ---
	OFFSET @PageSize * (@PageNumber-1) ROWS FETCH NEXT @PageSize ROWS ONLY;
	';
END
GO

CREATE OR ALTER PROCEDURE GetQuery
	@Code VARCHAR(100),
	@PageNumber INT,
	@PageSize INT,
	@Search VARCHAR(255),
	@OrderColumn VARCHAR(255),
	@OrderCriteria VARCHAR(255)
AS
BEGIN
	DECLARE @TSQL NVARCHAR(MAX);

	EXEC BuildQuery @Code, @TSQL OUT;

	EXEC sp_executesql @TSQL, 
		N'@PageNumber INT,@PageSize INT,@Search VARCHAR(255),@OrderColumn VARCHAR(255),@OrderCriteria VARCHAR(255)',
        @PageNumber=@PageNumber, @PageSize=@PageSize, @Search=@Search, @OrderColumn=@OrderColumn, @OrderCriteria=@OrderCriteria;
END
GO

EXEC GetQuery 'COUNTRY_LIST', 1, 10, 'C%', 'PhoneCode', 'ASC';
