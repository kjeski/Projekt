CREATE OR ALTER VIEW vw_FactVictim
AS
                                                    SELECT PrisonerID, 'Male' AS Victim_Gender, 'White' AS Victim_Race, Number_of_White_Male_Victims AS Number_of_Victims
        FROM Fact_prisoner
        WHERE Number_of_White_Male_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Male', 'Black', Number_of_Black_Male_Victims
        FROM Fact_prisoner
        WHERE Number_of_Black_Male_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Male', 'Latino', Number_of_Latino_Male_Victims
        FROM Fact_prisoner
        WHERE Number_of_Latino_Male_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Male', 'Asian', Number_of_Asian_Male_Victims
        FROM Fact_prisoner
        WHERE Number_of_Asian_Male_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Male', 'Native American', Number_of_Native_American_Male_Victims
        FROM Fact_prisoner
        WHERE Number_of_Native_American_Male_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Male', 'Other', Number_of_Other_Race_Male_Victims
        FROM Fact_prisoner
        WHERE Number_of_Other_Race_Male_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Female', 'White', Number_of_White_Female_Victims
        FROM Fact_prisoner
        WHERE Number_of_White_Female_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Female', 'Black', Number_of_Black_Female_Victims
        FROM Fact_prisoner
        WHERE Number_of_Black_Female_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Female', 'Latino', Number_of_Latino_Female_Victims
        FROM Fact_prisoner
        WHERE Number_of_Latino_Female_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Female', 'Asian', Number_of_Asian_Female_Victims
        FROM Fact_prisoner
        WHERE Number_of_Asian_Female_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Female', 'Native American', American_Indian_or_Alaska_Native_Female_Victims
        FROM Fact_prisoner
        WHERE American_Indian_or_Alaska_Native_Female_Victims > 0

    UNION ALL

        SELECT PrisonerID, 'Female', 'Other', Number_of_Other_Race_Female_Victims
        FROM Fact_prisoner
        WHERE Number_of_Other_Race_Female_Victims > 0;

select *
from vw_FactVictim
where PrisonerID = 144


SELECT *
INTO Fact_Victim
FROM [dbo].[vw_FactVictim]

ALTER TABLE dbo.Fact_Victim
ADD CONSTRAINT FK_Fact_Victim_FactPrisoner
FOREIGN KEY (PrisonerID) REFERENCES dbo.Fact_Prisoner(PrisonerID)

--drop view [dbo].[vw_FactVictim]

-- doplnění sloupce RaceID a jeho naplneni podle Victim_Race
ALTER TABLE dbo.Fact_Victim
ADD RaceID INT

UPDATE fv
SET fv.RaceID = r.RaceKey
FROM dbo.Fact_Victim fv
    INNER JOIN dbo.dimRace r
    ON fv.Victim_Race = r.RaceName