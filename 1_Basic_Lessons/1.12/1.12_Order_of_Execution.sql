
EXPLAIN ANALYZE
SELECT 
    cd.name AS company_name,
    COUNT(jpf.*) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id=cd.company_id
WHERE jpf.job_country='United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;

--Note: Depending on editor, you cannot use column alias in GROUP BY statement
--Alias of join is specified in Step 1 of Order of Execution and would be ready for 
--the subsequent steps