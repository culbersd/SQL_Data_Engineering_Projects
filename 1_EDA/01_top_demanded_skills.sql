--What are the most in-demand skills for data engineers?
--Identify the top 10 in-demand skills for data engineers
--Focus on remote job postings
--Why? Retrieves the top 10 skills with the highest demand in the remote job market, 
--providing insight into the most valuable skills for data engineers seeking remote work

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
LIMIT 10;

job_title_short │   skills   │ demand_count │
│     varchar     │  varchar   │    int64     │
├─────────────────┼────────────┼──────────────┤
│ Data Engineer   │ sql        │        29221 │
│ Data Engineer   │ python     │        28776 │
│ Data Engineer   │ aws        │        17823 │
│ Data Engineer   │ azure      │        14143 │
│ Data Engineer   │ spark      │        12799 │
│ Data Engineer   │ airflow    │         9996 │
│ Data Engineer   │ snowflake  │         8639 │
│ Data Engineer   │ databricks │         8183 │
│ Data Engineer   │ java       │         7267 │
│ Data Engineer   │ gcp        │         6446 │
└─────────────────┴────────────┴─

/*The table shows that SQL and Python lead skill demand for Data Engineer roles, 
followed by cloud platforms and tools for distributed processing, pipeline orchestration, 
and data warehousing.
SQL appears in 29,221 postings and Python in 28,776—a difference of just 445, or 
about 1.5%. Their nearly equal demand suggests that querying and transforming data,
 alongside programming and automation, are central capabilities for these roles.
Cloud expertise is another major requirement. AWS leads with 17,823 mentions, 
followed by Azure at 14,143 and GCP at 6,446. 
AWS demand is approximately 26% higher than Azure’s and 2.8 times GCP’s. 
Within this dataset, AWS offers the broadest exposure to cloud-related opportunities, 
although Azure also has substantial demand.

For someone preparing for Data Engineer roles, the strongest starting point is SQL,
 Python, and one cloud platform, followed by practical experience building pipelines. 
 Spark and Airflow would be useful next steps; Snowflake or Databricks could then be selected based on the roles being targeted.*/