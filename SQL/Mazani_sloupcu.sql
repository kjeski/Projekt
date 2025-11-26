--smazani sloupcu
BEGIN TRAN
ALTER TABLE DP_sentences
DROP COLUMN defendant;
COMMIT TRAN

--smazani vic sloupcu najednou
BEGIN TRAN
ALTER TABLE DP_sentences
DROP COLUMN sentence, Aliases, Sub_Jurisdiction, County_and_State, Multi_sentence_identifier, Outcome_of_Sentence;
COMMIT TRAN

SELECT
*
FROM
DP_sentences