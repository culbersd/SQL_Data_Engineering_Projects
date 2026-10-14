# HEADING 1

`This is code`

- Bullet 1  
- Bullet 2

1. Number 1
2. Number 2

[Link Text](https://google.com)

![Project 1 Overview](../Images/1_1_Project1_EDA.png)


```sql
SELECT
    jpf.job_title_short,
    sd.skills,
    COUNT(sd.skills) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim sd 
    ON sjd.skill_id=sd.skill_id
WHERE (job_title_short='Data Engineer') AND (job_work_from_home=TRUE)
GROUP BY jpf.job_title_short, sd.skills
ORDER BY demand_count DESC
LIMIT 10;```