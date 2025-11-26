BEGIN TRAN
DELETE FROM DP_Sentences_Final
WHERE 
Name = 'Paul Lewis Browning' AND Year = '1994'
COMMIT TRAN

SELECT
*
FROM
DP_Sentences
WHERE
Name = 'Curtis E. McCarty'


BEGIN TRAN
DELETE FROM DP_sentences
WHERE 
Name = 'Curtis E. McCarty' AND  sentence = 11892
ROLLBACK TRAN
COMMIT TRAN




SELECT *
FROM DP_sentences
WHERE defendant IN (
    SELECT defendant
    FROM DP_sentences
    GROUP BY defendant
    HAVING COUNT(*) > 1
) AND
Current_Case_Status = 'Exonerated'