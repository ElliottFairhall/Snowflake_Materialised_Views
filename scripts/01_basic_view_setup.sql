-- =============================================================================
-- 01_BASIC_VIEW_SETUP
-- =============================================================================
-- Purpose:    Create a simple Materialised View for aggregation
-- =============================================================================

-- 1. Create the Materialised View
CREATE OR REPLACE MATERIALIZED VIEW analytics.marts.mv_daily_revenue
AS
SELECT
    order_date,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value
FROM analytics.marts.fct_orders
GROUP BY order_date;

-- 2. Query the Materialised View
SELECT *
FROM analytics.marts.mv_daily_revenue
WHERE order_date >= '2026-01-01'
ORDER BY order_date DESC;
