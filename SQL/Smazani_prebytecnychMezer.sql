BEGIN TRAN
UPDATE Executions_Final
SET Name = LTRIM(RTRIM(
    REPLACE(
        REPLACE(
            REPLACE(Name, '  ', ' '), 
        '  ', ' '),
    '  ', ' ')
));
COMMIT TRAN
SELECT
*
FROM
Executions_Final
