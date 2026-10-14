SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS job_count
FROM skills_dim sd
    RIGHT JOIN skills_job_dim sjd  
        ON sd.skill_id=sjd.skill_id
    RIGHT JOIN job_postings_fact jpf
        ON sjd.job_id=jpf.job_id
WHERE jpf.job_title_short LIKE '%Data%'
GROUP BY sd.skill_id,sd.skills
ORDER BY job_count DESC;
