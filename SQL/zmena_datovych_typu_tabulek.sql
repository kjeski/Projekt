/*
DROP TABLE DP_Sentences_Final
*/

/*
Zmena datoveho typu u tabulky Sentences:
*/

SELECT
    CAST(Year AS INT) as Year,
Name,
Name_sortable,
Gender,
Races,
Jurisdiction,
State_Abbreviation,
Region,
Current_Case_Status
INTO
    DP_Sentences_Final
FROM
    DP_sentences

--Zmena datoveho typu u tabulky Innocense:
select
*
FROM
Innocense


SELECT
    CAST(Years_Between AS INT) as Years_Between, CAST(Convicted AS INT) as Convicted, CAST(Exonerated AS INT) as Exonerated,
Name,
State,
Race,
Exoneration_Procedure,
DNA
INTO
    Innocense_Final
FROM
    Innocense

DROP TABLE Innocense
DROP TABLE DP_sentences


--Zmena datoveho typu u tabulky Population
select
*
FROM
Population_Rase

SELECT
*
INTO
    Population_Rase_Final
FROM
    Population_Rase

DROP TABLE Population_Rase

SELECT
*
FROM
Population_Rase_Final