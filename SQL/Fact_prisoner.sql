--drop table Fact_Prisoner_old

SELECT
    ROW_NUMBER() OVER (ORDER BY dp.[Year], dp.[Name]) AS FactID,
    dp.[Name],
    dp.[Gender],
    dp.[Races] as Race_Prisoner,
    dp.[Year] as Year_Sentence,
    dp.[Jurisdiction] as State_Court,
    dp.[State_Abbreviation] as State_Abbreviation_Court,
    dp.[Region] as Region_Court,
    dp.[Current_Case_Status],
    e.[Execution_Date1],
    e.[Age_correct],
    e.[State] as State_Execution,
    e.[Region] as Region_Execution,
    e.[Victim_Races],
    e.[Number_of_Victims1] as Number_of_Victims,
    e.[Number_of_Male_Victims1] as Number_of_Male_Victims,
    e.[Number_of_Female_Victims1] as Number_of_Female_Victims,
    e.[Number_of_White_Male_Victims1] as Number_of_White_Male_Victims,
    e.[Number_of_Black_Male_Victims1] as Number_of_Black_Male_Victims,
    e.[Number_of_Latino_Male_Victims1] as Number_of_Latino_Male_Victims,
    e.[Number_of_Asian_Male_Victims1] as Number_of_Asian_Male_Victims,
    e.[Number_of_Native_American_Male_Victims1] as Number_of_Native_American_Male_Victims,
    e.[Number_of_Other_Race_Male_Victims1] as Number_of_Other_Race_Male_Victims,
    e.[Number_of_White_Female_Victims1] as Number_of_White_Female_Victims,
    e.[Number_of_Black_Female_Victims1] as Number_of_Black_Female_Victims,
    e.[Number_of_Latino_Female_Victims1] as Number_of_Latino_Female_Victims,
    e.[Number_of_Asian_Female_Victims1] as Number_of_Asian_Female_Victims,
    e.[American_Indian_or_Alaska_Native_Female_Victims1] as American_Indian_or_Alaska_Native_Female_Victims,
    e.[Number_of_Other_Race_Female_Victims1] as Number_of_Other_Race_Female_Victims,
    i.[Convicted] as Year_Convicted,
    i.[Exonerated] as Year_Exonerated,
    i.[Years_Between],
    i.[State] as State_Exonerated,
    i.[Exoneration_Procedure],
    i.[DNA]

INTO 
    Fact_Prisoner
FROM
    DP_Sentences_Final dp
    LEFT JOIN Executions_Final e ON dp.name = e.name
    LEFT JOIN Innocense_Final i ON dp.name = i.name

select *
from Fact_Prisoner

-- nový sloupec obsahujici jen rok popravy + naplneni
ALTER TABLE Fact_prisoner
ADD Year_Execution INT;

UPDATE Fact_prisoner
SET Year_Execution = CAST(YEAR(Execution_Date1) AS INT);



EXEC sp_rename 'fact_prisoner_test2.FactID', 'PrisonerID', 'COLUMN'

-- doplnění sloupce pro RaceID kvuli propojeni s dimRace
ALTER TABLE dbo.Fact_Prisoner_test2
ADD RaceID INT

UPDATE fp
SET fp.RaceID = r.RaceKey
FROM dbo.Fact_Prisoner_test2 fp
    INNER JOIN dbo.dimRace r
    ON fp.Race_Prisoner = r.RaceName

-- přejmenování opravené tabulky na novou vli kličum
EXEC sp_rename 'Fact_Prisoner', 'Fact_Prisoner_old'

EXEC sp_rename 'Fact_Prisoner_test2', 'Fact_Prisoner'