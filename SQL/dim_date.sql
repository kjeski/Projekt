-- Vytvoření tabulky
CREATE TABLE dbo.DimDate
(
    DataKey INT PRIMARY KEY,
    -- např. 20251020
    DateValue DATE NOT NULL,
    -- skutečné datum
    Year INT NOT NULL,
    Month INT NOT NULL,
    Day INT NOT NULL,
    MonthName NVARCHAR(20),
    DayOfWeek INT,
    DayName NVARCHAR(20),
    Quarter INT
);

-- Naplnění tabulky
DECLARE @StartDate DATE = '1900-01-01';
DECLARE @EndDate DATE = '2030-12-31';

WITH
    DateSequence
    AS
    (
                    SELECT @StartDate AS DateValue
        UNION ALL
            SELECT DATEADD(DAY, 1, DateValue)
            FROM DateSequence
            WHERE DateValue < @EndDate
    )
INSERT INTO dbo.DimDate
SELECT
    CONVERT(INT, FORMAT(DateValue, 'ddMMyyyy')) AS DateKey,
    DateValue,
    YEAR(DateValue) AS Year,
    MONTH(DateValue) AS Month,
    DAY(DateValue) AS Day,
    DATENAME(MONTH, DateValue) AS MonthName,
    DATEPART(WEEKDAY, DateValue) AS DayOfWeek,
    DATENAME(WEEKDAY, DateValue) AS DayName,
    DATEPART(QUARTER, DateValue) AS Quarter
FROM DateSequence
OPTION
(MAXRECURSION
0);


select *
from DimDate