SELECT
*
FROM
DP_sentences
WHERE
Current_Case_Status = 'Exonerated'

SELECT 
defendant, 
COUNT(*) AS pocet
FROM
DP_sentences
WHERE
Current_Case_Status = 'Exonerated'
GROUP BY 
defendant
HAVING 
COUNT(*) > 1

--vyselektovani defendantu kteri tam jsou vic nez jednou
SELECT *
FROM DP_sentences
WHERE defendant IN (
    SELECT defendant
    FROM DP_sentences
    GROUP BY defendant
    HAVING COUNT(*) > 1
) AND
Current_Case_Status = 'Exonerated'



SELECT *
FROM DP_sentences
WHERE 
Name = 'Charles Fain'

