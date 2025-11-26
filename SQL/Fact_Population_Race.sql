

select *
from Dim_Population_Race

select *
from DimStates

-- prejmenovani
EXEC sp_rename 'Dim_Population_Race', 'Fact_Population_Race'

-- vytvoření id -> PK
ALTER TABLE Dim_Population_Race
ADD population_race_id INT IDENTITY(1,1)

ALTER TABLE Dim_Population_Race
ADD CONSTRAINT PK_Dim_Population_Race PRIMARY KEY (population_race_id)

-- odstraneni radku pro cele staty
-- DELETE FROM Fact_PopulationRace
-- WHERE State = 'United States'


