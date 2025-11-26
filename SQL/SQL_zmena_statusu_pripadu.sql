
BEGIN TRAN

ALTER TABLE Fact_Prisoner
ADD case_status_updated NVARCHAR(255);
COMMIT;
GO

BEGIN TRAN

UPDATE Fact_Prisoner
SET case_status_updated =
    CASE 
        WHEN current_case_status IN (
            'Resentenced to Life or Less',
            'Sentence Commuted',
            'Grant of Relief (Retrial/Resentencing Pending)',
            'Sentence Commuted (Administrative)',
            'Grant of Relief (Never Retried)',
            'Grant of Relief (Subject to Appeal)',
            'Resentenced to Time Served',
            'Sentence was Commuted to life without parole',
            'Conviction Voided, Convicted and Sentenced to Life or Less',
            'Sentence was Commuted to time served'
        )
        THEN 'Resentenced to Life or Less'

        WHEN current_case_status IN (
            'Active Death Sentence',
            'Retrial Barred',
            'Acquitted, Convicted and Sentenced to Death in Another Jurisdiction'
        ) THEN 'Active'

        when current_case_status IN (
            'Executed',
            'Executed for a Different Crime',
            'Executed by a Different State',
            'Executed for a Different Crime Pending Retrial or Resentencing'
        ) THEN 'Executed'

        when current_case_status IN (
            'Exonerated',
            'Not Guilty by Reason of Insanity'
        ) THEN 'Exonerated'

        when current_case_status IN (
            'Died on Death Row',
            'Died Pending Retrial or Resentencing'
        ) then 'Died on Death Row'

         
         when current_case_status IN ( 
            'No Longer on Death Row (Reason Undetermined)' ) 
         then 'No Longer on Death Row (Reason Undetermined)'

         when current_case_status IS NULL
         then 'Exonerated'
    END;

COMMIT


BEGIN TRAN

UPDATE Fact_Prisoner
SET case_status_updated =
    CASE
         when current_case_status IS NULL
         then 'Exonerated'
    END;
ROLLBACK

BEGIN TRAN

UPDATE Fact_Prisoner
SET  case_status_updated = 
    CASE 
        WHEN Current_Case_Status IS NULL THEN 'Exonerated'
        ELSE case_status_updated
    END


SELECT
*
FROM
Fact_Prisoner
where Current_Case_Status IS NULL

COMMIT TRAN
