SELECT 
    t1.Name,
    t1.Convicted AS year_convicted_innocense,
    t2.Year AS year_sentences
FROM
    Innocense_final AS t1
    JOIN DP_sentences AS t2 ON t1.Name = t2.Name
WHERE 
t1.Convicted <> t2.Year