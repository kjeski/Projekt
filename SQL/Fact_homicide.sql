-- Fact_Homicide
-- přidělení id -> vytvoření PK
ALTER TABLE Homicide
ADD homicide_id INT IDENTITY(1,1)

ALTER TABLE Homicide
ADD CONSTRAINT PK_Homicide PRIMARY KEY (homicide_id)

-- napojení Dim State
-- nutno vytvořit sloupec State_Code v tabulce Homicide a naplnit ho podle dim state
ALTER TABLE Homicide
ADD State_Code NVARCHAR(50)

UPDATE Homicide
SET Homicide.State_Code = s.State_Code
FROM Homicide h
    JOIN DimStates s
    ON h.State = s.State

-- přejmenovani
EXEC sp_rename 'Homicide', 'Fact_Homicide'