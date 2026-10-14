/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/


SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(sd.skills) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim sd 
    ON sjd.skill_id=sd.skill_id
WHERE (job_title_short='Data Engineer') AND (job_work_from_home=TRUE)
GROUP BY sd.skills
HAVING COUNT(sd.skills) >100
ORDER BY median_salary DESC
LIMIT 25;

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ terraform  │      184000.0 │         3248 │
│ golang     │      184000.0 │          912 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ css        │      150000.0 │          262 │
│ node       │      150000.0 │          179 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │

/* The data shows that the highest-paying skills are not necessarily the most in demand. 
Rust has the highest median salary at $210,000, but appears in only 232 postings. 
By comparison, Airflow has the greatest demand, appearing in 9,996 postings, with a median salary of $150,000. 
This suggests that specialized skills can be associated with higher compensation, while more widely requested skills offer a larger pool of potential opportunities.

Terraform stands out for its combination of compensation and demand. 
Its median salary of $184,000 is approximately 23% higher than Airflow’s, and it appears in 3,248 postings. 
Golang has the same median salary but only 912 postings, meaning Terraform’s demand is roughly 3.6 times greater. 
Kubernetes also shows substantial demand, with 4,202 postings and a median salary of $150,500, making it the second-most-requested skill in the table.

Several higher-paying skills—including Spring, Neo4j, and GraphQL—have relatively low demand counts. 
Meanwhile, skills with identical salaries can have substantially different demand: Airflow, Ruby, CSS, and Node all have median salaries of $150,000, 
but their posting counts range from 179 to 9,996. Salary should therefore be evaluated alongside demand when assessing potential career opportunities.

Within this dataset, Airflow offers the broadest opportunity, 
Terraform provides a strong balance of salary and demand, and Rust 
represents a smaller, highly compensated niche. 
However, these figures reflect salaries associated with job postings mentioning 
each skill, rather than the independent value of the skill itself. 
Seniority, location, role type, and overlapping requirements may influence the results. 
Because the table is sorted by salary, it also cannot establish which skills are most in demand across the overall job market.