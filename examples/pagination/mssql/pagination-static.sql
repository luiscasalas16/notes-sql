CREATE OR ALTER PROCEDURE GetQueryCountryList
	@PageNumber INT,
	@PageSize INT,
	@Search VARCHAR(255),
	@OrderColumn VARCHAR(255),
	@OrderCriteria VARCHAR(255)
AS
BEGIN
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
		CASE WHEN @OrderColumn = 'NiceName' AND @OrderCriteria = 'ASC' THEN NiceName END ASC,
		CASE WHEN @OrderColumn = 'NiceName' AND @OrderCriteria = 'DESC' THEN NiceName END DESC,
		CASE WHEN @OrderColumn = 'IsoCode' AND @OrderCriteria = 'ASC' THEN IsoCode END ASC,
		CASE WHEN @OrderColumn = 'IsoCode' AND @OrderCriteria = 'DESC' THEN IsoCode END DESC,
		CASE WHEN @OrderColumn = 'PhoneCode' AND @OrderCriteria = 'ASC' THEN PhoneCode END ASC,
		CASE WHEN @OrderColumn = 'PhoneCode' AND @OrderCriteria = 'DESC' THEN PhoneCode END DESC,
		--- ordenamiento defecto ---
		NiceName ASC
	--- paginación ---
	OFFSET @PageSize * (@PageNumber-1) ROWS FETCH NEXT @PageSize ROWS ONLY;
END
GO

EXEC GetQueryCountryList 1, 10, 'C%', 'PhoneCode', 'ASC';
