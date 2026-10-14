SELECT 
    jpf.job_id,
    jpf.job_title,
    cd.name as company_name,
    jpf.job_location,
    jpf.job_posted_date
FROM job_postings_fact jpf
LEFT JOIN company_dim cd
    ON jpf.company_id=cd.company_id
WHERE job_title_short='Data Engineer'
ORDER BY job_posted_date DESC;






SELECT  * 
FROM job_postings_fact
LIMIT 5;

SELECT *
FROM company_dim
LIMIT 5;