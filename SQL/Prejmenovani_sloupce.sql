BEGIN TRAN
EXEC sp_rename N'dbo.DP_Sentences_Final.Jurisdiction', N'State', N'COLUMN';
COMMIT TRAN

