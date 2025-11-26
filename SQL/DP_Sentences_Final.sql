--drop table DP_Sentences_Final



SELECT
    CAST(Year AS INT) as Year,
    Name,
    Name_sortable,
    Gender,
    Races,
    Jurisdiction,
    State_Abbreviation,
    Region,
    Current_Case_Status
INTO
    DP_Sentences_Final
FROM
    DP_sentences

select *
from DP_Sentences_Final

select *
from DimStates