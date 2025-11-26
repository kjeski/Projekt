
'''
select *
from DP_Sentences_Final
--where name like N'
%Graves'

select *
from Innocense_Final
where name like N'%Patterson'

SELECT distinct *
FROM Innocense_Final i
    LEFT JOIN Fact_Prisoner fp
    ON i.name = fp.name
WHERE fp.name IS NULL

select
    i.name as nameI,
    d.name
FROM
    Innocense_Final i,
    DP_Sentences_Final d

select * from Fact_Prisoner

fp.name - i.name
fp.Year_Sentence - i.Convicted
fp.Year_Exonerated - i.Exonerated
fp.state_court / State_Exonerated - i.state
fp.race_prisoner - i.race
fp.Exoneration_Procedure - i.Exoneration_Procedure
'''

BEGIN TRAN

INSERT INTO Fact_Prisoner
    (
    PrisonerID,
    name,
    Year_Sentence,
    Year_Exonerated,
    '''??? state_court / State_Exonerated ???''',
    race_prisoner,
    Exoneration_Procedure
    )
SELECT
    (SELECT MAX(PrisonerID)
    FROM Fact_Prisoner) + ROW_NUMBER() OVER (ORDER BY i.Convicted) as new_id,
    i.name,
    i.Convicted,
    i.Exonerated,
    i.state,
    i.race,
    i.Exoneration_Procedure
FROM Innocense_Final i
    LEFT JOIN Fact_Prisoner fp
    ON i.name = fp.name
WHERE fp.name IS NULL;


-- fact prisoner pred pridanim nesparovanych innocense - 9738
-- nesparovanych innocense - 181
-- po pridani by melo byt ve fact_prisoner celkem 9919

select *
from fact_prisoner