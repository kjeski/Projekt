--smazani radku
BEGIN TRAN
DELETE FROM DP_sentences
WHERE Jurisdiction = 'U.S. Military'
COMMIT TRAN

SELECT
*
FROM
DP_sentences
WHERE
 Jurisdiction = 'U.S. Military'


BEGIN TRAN
DELETE FROM DP_sentences
WHERE Jurisdiction = 'Federal'
COMMIT TRAN

SELECT
*
FROM
DP_sentences
WHERE
 Jurisdiction = 'Federal'