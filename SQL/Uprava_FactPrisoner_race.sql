--smazani vic sloupcu najednou
BEGIN TRAN
ALTER TABLE Fact_Prisoner
DROP COLUMN [Victim_Races],
[DNA],
[Years_Between]
COMMIT TRAN

--nastaveni hodnoty do sloupce na zaklade vice podminek)

BEGIN TRAN
UPDATE Fact_Prisoner
SET Race_Prisoner = 'Other'
WHERE 
Race_Prisoner IN ('White, Black', 'Black, Latino/a', 'Latino/a, American Indian or Alaska Native', 'American Indian or Alaska Native', 'Black, American Indian or Alaska Native','Other Race', 'Unknown Race')
COMMIT TRAN

SELECT
DISTINCT Race_Prisoner
FROM
Fact_Prisoner

BEGIN TRAN
UPDATE Fact_Prisoner
SET Race_Prisoner = 'Latino'
WHERE 
Race_Prisoner = N'Latino/a'

SELECT
*
FROM
Fact_Prisoner
WHERe
Race_Prisoner IS NULL


BEGIN TRAN
UPDATE Fact_Prisoner
SET Race_Prisoner = 'Black'
WHERE 
Name LIKE N'John G. Fitzgerald Hanson'