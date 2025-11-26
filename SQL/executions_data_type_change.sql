SELECT
    Name,
    First_Name,
    Last_Name,
    Middle_Name_s,
    Race,
    Sex,
    CAST(left(Age, 2) AS int) as Age_correct,
    Region,
    State,
    Victim_Races,
    CAST(Execution_Date as date) as Execution_Date1,
    CAST(Number_of_Victims as int) as Number_of_Victims1,
    cast(Number_of_Male_Victims as int) as Number_of_Male_Victims1,
    CAST(Number_of_Female_Victims as int) as Number_of_Female_Victims1,
    cast(Number_of_White_Male_Victims as int) as Number_of_White_Male_Victims1,
    cast(Number_of_Black_Male_Victims as int) as Number_of_Black_Male_Victims1,
    cast(Number_of_Latino_Male_Victims as int) as Number_of_Latino_Male_Victims1,
    cast(Number_of_Asian_Male_Victims as int) as Number_of_Asian_Male_Victims1,
    cast(Number_of_Native_American_Male_Victims as int) as Number_of_Native_American_Male_Victims1,
    cast(Number_of_Other_Race_Male_Victims as int) as Number_of_Other_Race_Male_Victims1,
    cast(Number_of_White_Female_Victims as int) as Number_of_White_Female_Victims1,
    cast(Number_of_Black_Female_Victims as int) as Number_of_Black_Female_Victims1,
    cast(Number_of_Latino_Female_Victims as int) as Number_of_Latino_Female_Victims1,
    cast(Number_of_Asian_Female_Victims as int) as Number_of_Asian_Female_Victims1,
    cast(Number_of_American_Indian_or_Alaska_Native_Female_Victims as int) as American_Indian_or_Alaska_Native_Female_Victims1,
    cast(Number_of_Other_Race_Female_Victims as int) as Number_of_Other_Race_Female_Victims1


INTO
Executions_Final
FROM
    Executions

drop table Executions