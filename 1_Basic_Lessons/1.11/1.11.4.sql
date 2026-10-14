SELECT
    jpf.job_title_short,
    sd.skill_id,
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM job_postings_fact jpf
LEFT JOIN skills_job_dim sjd
    ON jpf.job_id=sjd.job_id
LEFT JOIN skills_dim sd 
    ON sjd.skill_id=sd.skill_id
WHERE jpf.job_title_short LIKE '%Data%'
GROUP BY jpf.job_title_short, sd.skill_id, sd.skills
ORDER BY job_count DESC;

