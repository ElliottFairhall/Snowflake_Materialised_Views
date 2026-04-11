# 🚀 Snowflake Materialised Views Tutorial

## 🎯 Learning Objectives

1. 🧠 Understand the concept of Materialised Views and how they differ from standard views and Dynamic Tables.

2. 🛠️ Master the creation, management, and monitoring of Materialised Views within Snowflake.

3. 🔗 Learn when to use Materialised Views versus other options for pre-computed query results.

## 📚 Table of Contents

- [🚀 Snowflake Materialised Views Tutorial](#-snowflake-materialised-views-tutorial)
  - [🎯 Learning Objectives](#-learning-objectives)
  - [📚 Table of Contents](#-table-of-contents)
    - [🎉 Introduction](#-introduction)
    - [📝 Introduction to Materialised Views](#-introduction-to-materialised-views)
    - [🔄 Materialised Views vs Standard Views vs Dynamic Tables](#-materialised-views-vs-standard-views-vs-dynamic-tables)
    - [🛠️ Creating Materialised Views](#%EF%B8%8F-creating-materialised-views)
    - [📊 Automatic Maintenance](#-automatic-maintenance)
    - [⚙️ Limitations and Considerations](#%EF%B8%8F-limitations-and-considerations)
  - [💡 Tutorial](#-tutorial)
  - [🎈 Conclusion](#-conclusion)
  - [📖 Additional Resources](#-additional-resources)
  - [⚠️ Disclaimer](#%EF%B8%8F-disclaimer)

### 🎉 Introduction

Welcome to this tutorial on Materialised Views within Snowflake! This tutorial is designed to help you understand and
implement Materialised Views to accelerate frequently-run queries. By the end of this tutorial, you'll be able to
confidently create, monitor, and manage Materialised Views in your Snowflake environment. So, let's dive in! 🏊‍♀️

### 📝 Introduction to Materialised Views

A Materialised View is a pre-computed result set that is stored physically and maintained automatically by Snowflake.
When you query a Materialised View, Snowflake reads from the stored result rather than re-executing the underlying query
— resulting in significantly faster query performance for complex aggregations and joins.

Key characteristics:

- **Automatic maintenance**: Snowflake automatically refreshes the Materialised View when the base table changes.
- **Serverless compute**: The maintenance process uses Snowflake-managed compute (no warehouse required).
- **Transparent query optimisation**: The query optimiser can automatically route queries to a Materialised View even
  when the query references the base table directly.
- **Incremental refresh**: Only changed data is re-processed during maintenance, keeping costs low.

### 🔄 Materialised Views vs Standard Views vs Dynamic Tables

| Feature               | Standard View           | Materialised View      | Dynamic Table          |
| --------------------- | ----------------------- | ---------------------- | ---------------------- |
| **Data storage**      | None (query at runtime) | Pre-computed results   | Pre-computed results   |
| **Maintenance**       | None                    | Automatic (serverless) | Automatic (warehouse)  |
| **Query performance** | Same as base query      | Faster (cached result) | Faster (cached result) |
| **Supported queries** | Any valid SQL           | Limited (see below)    | Most SQL patterns      |
| **Multi-table joins** | Yes                     | No (single table only) | Yes                    |
| **Compute model**     | User warehouse          | Serverless             | User warehouse         |
| **Best for**          | Abstraction layers      | Frequent aggregations  | Multi-table pipelines  |

### 🛠️ Creating Materialised Views

```sql
-- Basic Materialised View
CREATE OR REPLACE MATERIALIZED VIEW analytics.marts.mv_daily_revenue
AS
SELECT
    order_date,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value
FROM analytics.marts.fct_orders
GROUP BY order_date;

-- Query the Materialised View
SELECT *
FROM analytics.marts.mv_daily_revenue
WHERE order_date >= '2026-01-01'
ORDER BY order_date DESC;
```

```sql
-- Materialised View with clustering for large tables
CREATE OR REPLACE MATERIALIZED VIEW analytics.marts.mv_customer_segments
CLUSTER BY (customer_segment)
AS
SELECT
    customer_segment,
    region,
    COUNT(*) AS customer_count,
    SUM(lifetime_revenue) AS total_revenue,
    AVG(lifetime_revenue) AS avg_revenue
FROM analytics.marts.dim_customers
GROUP BY customer_segment, region;
```

```sql
-- Secure Materialised View (for data sharing)
CREATE OR REPLACE SECURE MATERIALIZED VIEW analytics.marts.mv_shared_summary
AS
SELECT
    region,
    product_category,
    SUM(revenue) AS total_revenue
FROM analytics.marts.fct_sales
GROUP BY region, product_category;
```

### 📊 Automatic Maintenance

Snowflake automatically detects changes to the base table and refreshes the Materialised View. You can monitor the
maintenance process:

```sql
-- Check refresh history
SELECT *
FROM TABLE(INFORMATION_SCHEMA.MATERIALIZED_VIEW_REFRESH_HISTORY(
    DATE_RANGE_START => DATEADD('day', -7, CURRENT_TIMESTAMP())
))
ORDER BY start_time DESC;

-- Suspend automatic maintenance
ALTER MATERIALIZED VIEW analytics.marts.mv_daily_revenue SUSPEND;

-- Resume automatic maintenance
ALTER MATERIALIZED VIEW analytics.marts.mv_daily_revenue RESUME;
```

### ⚙️ Limitations and Considerations

Materialised Views have several important limitations to be aware of:

- **Single table only**: Cannot include joins (use Dynamic Tables for multi-table queries).
- **Limited functions**: Some window functions and non-deterministic functions are not supported.
- **No HAVING clause**: Filter results using a standard view on top of the Materialised View.
- **Storage costs**: The pre-computed results require storage.
- **Maintenance costs**: Automatic refresh consumes serverless compute credits.
- **Enterprise Edition required**: Materialised Views are available on Enterprise Edition and above.

```sql
-- Monitor Materialised View storage
SELECT
    table_name,
    bytes / POWER(1024, 2) AS size_mb
FROM INFORMATION_SCHEMA.TABLES
WHERE table_type = 'MATERIALIZED VIEW'
  AND table_schema = 'MARTS';
```

## 💡 Tutorial

In this tutorial, we'll be exploring how to create Materialised Views to accelerate common analytical queries. We'll
build pre-computed aggregations for daily revenue and customer segments, monitor the automatic maintenance process, and
compare query performance against standard views.

By the end of this tutorial, you'll have gained a comprehensive understanding of when and how to use Materialised Views
to improve query performance whilst managing storage and compute costs effectively.

## 🎈 Conclusion

In conclusion, Materialised Views are a powerful performance optimisation feature in Snowflake that can dramatically
reduce query times for frequently-run aggregations. Their automatic, serverless maintenance model means you benefit from
pre-computed results without managing refresh schedules or warehouse resources. However, their single-table limitation
means they are best suited for aggregations on large base tables, with Dynamic Tables being the preferred choice for
multi-table transformation pipelines.

## 📖 Additional Resources

- [Materialised Views Documentation](https://docs.snowflake.com/en/user-guide/views-materialized)
- [Working with Materialised Views](https://docs.snowflake.com/en/user-guide/views-materialized#working-with-materialized-views)
- [Dynamic Tables vs Materialised Views](https://medium.com/snowflake/snowflake-dynamic-tables-vs-streams-tasks-vs-materialized-views-c8e8a6a93b67)

## ⚠️ Disclaimer

Please note that whilst we strive to keep this tutorial up-to-date, Snowflake's features and capabilities may change
over time. Always refer to the [official Snowflake documentation](https://docs.snowflake.com/) for the most accurate and
current information.
