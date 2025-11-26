-- Fact - DimStates

ALTER TABLE dbo.DimStates
ADD CONSTRAINT PK_DimStates PRIMARY KEY (State_Code);

ALTER TABLE dbo.Fact_Prisoner
ADD CONSTRAINT FK_FactPrisoner_DimStates
FOREIGN KEY (State_Abbreviation_Court)
REFERENCES dbo.DimStates(State_Code);

-- Fact - DimDate
-- povolení null hodnot ve faktovce
ALTER TABLE dbo.Fact_Prisoner
ALTER COLUMN Year_Sentence INT NULL;

ALTER TABLE dbo.Fact_Prisoner
ALTER COLUMN Year_Execution INT NULL;

--
ALTER TABLE dbo.DimDate
ADD CONSTRAINT UQ_DimDate_Year UNIQUE (Year);
--propojeni
ALTER TABLE dbo.Fact_Prisoner
ADD CONSTRAINT FK_FactPrisoner_DimDate_Sentence
FOREIGN KEY (Year_Sentence)
REFERENCES dbo.DimDate(Year);

ALTER TABLE dbo.Fact_Prisoner
ADD CONSTRAINT FK_FactPrisoner_DimDate_Execution
FOREIGN KEY (Year_Execution)
REFERENCES dbo.DimDate(Year);

select *
from dbo.Fact_Prisoner
-- propojeni dimDate a faktovky mi nejde, navi ho ani nepotrebuju, staci mi roky

-- propojeni dimYear a fact_prisoner
ALTER TABLE dbo.Fact_Prisoner
ADD CONSTRAINT FK_FactPrisoner_DimYear_Sentence
FOREIGN KEY (Year_Sentence)
REFERENCES dbo.DimYear(Year);

ALTER TABLE dbo.Fact_Prisoner
ADD CONSTRAINT FK_FactPrisoner_DimYear_Execution
FOREIGN KEY (Year_Execution)
REFERENCES dbo.DimYear(Year);

--Kontrola propojeni
SELECT
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys AS fk
    INNER JOIN sys.foreign_key_columns AS fkc
    ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.tables AS tp
    ON fkc.parent_object_id = tp.object_id
    INNER JOIN sys.columns AS cp
    ON fkc.parent_object_id = cp.object_id
        AND fkc.parent_column_id = cp.column_id
    INNER JOIN sys.tables AS tr
    ON fkc.referenced_object_id = tr.object_id
    INNER JOIN sys.columns AS cr
    ON fkc.referenced_object_id = cr.object_id
        AND fkc.referenced_column_id = cr.column_id
ORDER BY ParentTable;

-- RACE
select *
from dimRace

select
    distinct Race_Prisoner
from Fact_Prisoner

-- 1️) Vytvoření Bridge tabulky
IF OBJECT_ID('dbo.Bridge_Race', 'U') IS NOT NULL
    DROP TABLE dbo.Bridge_Race;
GO

CREATE TABLE dbo.Bridge_Race
(
    BridgeID INT IDENTITY(1,1) PRIMARY KEY,
    FactID INT NOT NULL,
    RaceKey INT NOT NULL,
    Race_Prisoner NVARCHAR(200) NULL
);
GO

-- 2️) Naplnění daty - rozložení kombinací (White, Black → dva řádky)
;WITH
    SplitRaces
    AS
    (
        SELECT
            f.PrisonerID,
            LTRIM(RTRIM([value])) AS Race_Prisoner
        FROM dbo.Fact_Prisoner AS f
    CROSS APPLY STRING_SPLIT(f.Race_Prisoner, ',')
    )
-- 3️) Mapování hodnot na klíče z DimRace
INSERT INTO dbo.Bridge_Race
    (FactID, RaceKey, Race_Prisoner)
SELECT
    s.PrisonerID,
    d.RaceKey,
    s.Race_Prisoner
FROM SplitRaces s
    LEFT JOIN dbo.DimRace d
    ON
        -- mapování názvů mezi faktovou a dimenzí
        (
            (s.Race_Prisoner IN ('White') AND d.RaceName = 'White')
        OR (s.Race_Prisoner IN ('Black') AND d.RaceName = 'Black')
        OR (s.Race_Prisoner IN ('Latino/a', 'Latino') AND d.RaceName = 'Latino')
        OR (s.Race_Prisoner IN ('Asian') AND d.RaceName = 'Asian')
        OR (s.Race_Prisoner LIKE '%American Indian%' AND d.RaceName = 'Native American')
        OR (s.Race_Prisoner IN ('Other Race', 'Unknown Race', 'NULL') AND d.RaceName = 'Other')
        );
GO


-- 4️) Cizí klíče 
ALTER TABLE dbo.Bridge_Race
ADD CONSTRAINT FK_BridgeRace_Fact
    FOREIGN KEY (FactID) REFERENCES dbo.Fact_Prisoner(FactID);

ALTER TABLE dbo.Bridge_Race
ADD CONSTRAINT FK_BridgeRace_Dim
    FOREIGN KEY (RaceKey) REFERENCES dbo.DimRace(RaceKey);
GO

-- 5️) Kontrola – kolik záznamů se úspěšně napojilo
SELECT COUNT(*) AS TotalRows,
    SUM(CASE WHEN RaceKey IS NULL THEN 1 ELSE 0 END) AS UnmappedRows
FROM dbo.Bridge_Race;
GO


-- Fact_Homicide
-- propojeni s dimStates 
ALTER TABLE Fact_Homicide
ADD CONSTRAINT FK_Homicide_DimStates
FOREIGN KEY (State_Code)
REFERENCES DimStates(State_Code)
-- propojeni s DimYear
ALTER TABLE Fact_Homicide
ADD CONSTRAINT FK_Homicide_DimYear
FOREIGN KEY (Year)
REFERENCES DimYear(Year)

-- Dim_Population_Rase
---- propojeni s dimStates 
ALTER TABLE Dim_Population_Race
ADD CONSTRAINT FK_Dim_Population_Race_DimStates
FOREIGN KEY (StateCode)
REFERENCES DimStates(State_Code)


-- propojeni s DimYear
ALTER TABLE Dim_Population_Race
ADD CONSTRAINT FK_Dim_Population_Race_DimYear
FOREIGN KEY (Year)
REFERENCES DimYear(Year)
-- propojeni s DimRace
--vytvoření RaceKey v dim_Population_Race pro propojeni
ALTER TABLE Dim_Population_Race
ADD RaceKey INT

UPDATE p
SET p.RaceKey = r.RaceKey
FROM Dim_Population_Race p
    JOIN DimRace r ON p.Race = r.RaceName

SELECT *
FROM Dim_Population_Race
WHERE RaceKey IS NULL

ALTER TABLE Dim_Population_Race
ADD CONSTRAINT FK_Dim_Population_Race_DimRace
FOREIGN KEY (RaceKey)
REFERENCES DimRace(RaceKey)

-- Fact_victim
-- propojeni s DimRace
ALTER TABLE dbo.Fact_Victim
ADD CONSTRAINT FK_Fact_Victim_dimRace
FOREIGN KEY (RaceID) REFERENCES dbo.dimRace(RaceKey)

-- Fact_state_status
-- propojeni s dimStates 
ALTER TABLE Fact_State_status
ADD CONSTRAINT FK_Fact_state_status_DimStates
FOREIGN KEY (StateCode)
REFERENCES DimStates(State_Code)
-- propojeni s DimYear
ALTER TABLE Fact_state_status
ADD CONSTRAINT FK_Fact_state_status_DimYear
FOREIGN KEY (Year)
REFERENCES DimYear(Year)

--  Fact_Population
-- propojeni s dimStates 
ALTER TABLE Fact_Population
ADD CONSTRAINT FK_Fact_Population_DimStates
FOREIGN KEY (StateCode)
REFERENCES DimStates(State_Code)
-- propojeni s DimYear
ALTER TABLE Fact_Population
ADD CONSTRAINT FK_Fact_Population_DimYear
FOREIGN KEY (Year)
REFERENCES DimYear(Year)