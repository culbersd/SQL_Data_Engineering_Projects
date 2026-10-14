SELECT table_name, constraint_name, COUNT(column_name) AS constraint_name_count
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs'
GROUP BY table_name, constraint_name
HAVING COUNT(column_name) > 1;
