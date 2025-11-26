CREATE TABLE dbo.dimRace
(
    RaceKey INT IDENTITY(1,1) PRIMARY KEY,
    RaceName NVARCHAR(100) NOT NULL,
    RaceGroup NVARCHAR(100) NULL
);

INSERT INTO dbo.dimRace
    (RaceName, RaceGroup)
VALUES
    ('White', 'Caucasian'),
    ('Black', 'African American'),
    ('Latino', 'Hispanic'),
    ('Asian', 'Asian / Pacific Islander'),
    ('Native American', 'Indigenous'),
    ('Other', 'Other / Unknown')
