-- vytvořeni dimYear
CREATE TABLE dbo.DimYear
(
    Year INT PRIMARY KEY
);
INSERT INTO dbo.DimYear
    (Year)
SELECT DISTINCT Year
FROM dbo.DimDate;

INSERT INTO DimYear
    (Year)
SELECT DISTINCT Year
FROM Fact_state_status
WHERE Year NOT IN (SELECT Year
FROM DimYear)