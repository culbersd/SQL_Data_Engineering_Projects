/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    --COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000,2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim sd 
    ON sjd.skill_id=sd.skill_id
WHERE (job_title_short='Data Engineer') AND (job_work_from_home=TRUE)
AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(sd.skills) >100
ORDER BY optimal_score DESC
LIMIT 25;

/*
│   skills   │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    double     │     double      │    double     │
├────────────┼───────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │             5.3 │          0.97 │
│ python     │      135000.0 │             7.0 │          0.95 │
│ sql        │      130000.0 │             7.0 │          0.91 │
│ aws        │      137320.0 │             6.7 │          0.91 │
│ airflow    │      150000.0 │             6.0 │          0.89 │
│ spark      │      140000.0 │             6.2 │          0.87 │
│ kafka      │      145000.0 │             5.7 │          0.82 │
│ snowflake  │      135500.0 │             6.1 │          0.82 │
│ azure      │      128000.0 │             6.2 │          0.79 │
│ java       │      135000.0 │             5.7 │          0.77 │
│ scala      │      137290.0 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │             5.0 │          0.75 │
│ git        │      140000.0 │             5.3 │          0.75 │
│ databricks │      132750.0 │             5.6 │          0.74 │
│ redshift   │      130000.0 │             5.6 │          0.73 │
│ gcp        │      136000.0 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │             5.3 │          0.71 │
│ nosql      │      134415.0 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │             5.0 │           0.7 │
│ mongodb    │      135750.0 │             4.9 │          0.67 │
│ docker     │      135000.0 │             5.0 │          0.67 │
│ r          │      134775.0 │             4.9 │          0.66 │
│ go         │      140000.0 │             4.7 │          0.66 │
│ bigquery   │      135000.0 │             4.8 │          0.65 │
│ github     │      135000.0 │             4.8 │          0.65 


```python
import pandas as pd

data = [
    ("terraform", 184000.0, 5.3, 0.97),
    ("python", 135000.0, 7.0, 0.95),
    ("sql", 130000.0, 7.0, 0.91),
    ("aws", 137320.0, 6.7, 0.91),
    ("airflow", 150000.0, 6.0, 0.89),
    ("spark", 140000.0, 6.2, 0.87),
    ("kafka", 145000.0, 5.7, 0.82),
    ("snowflake", 135500.0, 6.1, 0.82),
    ("azure", 128000.0, 6.2, 0.79),
    ("java", 135000.0, 5.7, 0.77),
    ("scala", 137290.0, 5.5, 0.76),
    ("kubernetes", 150500.0, 5.0, 0.75),
    ("git", 140000.0, 5.3, 0.75),
    ("databricks", 132750.0, 5.6, 0.74),
    ("redshift", 130000.0, 5.6, 0.73),
    ("gcp", 136000.0, 5.3, 0.72),
    ("hadoop", 135000.0, 5.3, 0.71),
    ("nosql", 134415.0, 5.3, 0.71),
    ("pyspark", 140000.0, 5.0, 0.70),
    ("mongodb", 135750.0, 4.9, 0.67),
    ("docker", 135000.0, 5.0, 0.67),
    ("r", 134775.0, 4.9, 0.66),
    ("go", 140000.0, 4.7, 0.66),
    ("bigquery", 135000.0, 4.8, 0.65),
    ("github", 135000.0, 4.8, 0.65),
]

df = pd.DataFrame(data, columns=["skills", "median_salary", "ln_demand_count", "optimal_score"])

print("Summary Statistics:")
print(df.describe())


```

```text
Summary Statistics:
       median_salary  ln_demand_count  optimal_score
count      25.000000        25.000000      25.000000
mean   138852.000000         5.556000       0.769200
std     10824.733927         0.672111       0.098401
min    128000.000000         4.700000       0.650000
25%    135000.000000         5.000000       0.700000
50%    135500.000000         5.300000       0.750000
75%    140000.000000         6.000000       0.820000
max    184000.000000         7.000000       0.970000


```

This table ranks **25 tech skills** based on three key metrics: median salary, log-transformed demand count (`ln_demand_count`), and a calculated `optimal_score` (sorted in descending order).

### Key Takeaways

* **Top Overall Skills (`optimal_score`):**
* **Terraform** leads with the highest score (**0.97**), driven by an exceptionally high median salary of **$184,000**.
* **Python** and **SQL** follow closely with scores of **0.95** and **0.91**, driven by the highest demand count (**7.0**).
* **AWS** ties SQL at **0.91**, pairing high demand (**6.7**) with a high median salary (**$137,320**).


* **Highest Earning Skills:**
1. **Terraform:** $184,000
2. **Kubernetes:** $150,500
3. **Airflow:** $150,000
4. **Kafka:** $145,000
5. **Spark / Git / PySpark / Go:** $140,000


* **Highest Demand Skills (`ln_demand_count`):**
* **Python** and **SQL** share the peak demand score of **7.0**.
* Cloud platforms dominate total demand, led by **AWS** (6.7), **Azure** (6.2), and **GCP** (5.3).
* Big data frameworks like **Spark** (6.2), **Snowflake** (6.1), and **Airflow** (6.0) also show very strong demand.



### Data Overview

* **Median Salary:** Ranges from **$128,000** (Azure) to **$184,000** (Terraform), with an average across all listed skills of **$138,852** and a median of **$135,500**.
* **Demand Count (`ln_demand`):** Ranges from **4.7** (Go) to **7.0** (Python, SQL), with a median of **5.3**.
* **Optimal Score:** Ranges from **0.65** (BigQuery, GitHub) to **0.97** (Terraform). */