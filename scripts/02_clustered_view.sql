-- =============================================================================
-- 02_CLUSTERED_VIEW
-- =============================================================================
-- Purpose:    Optimize large Materialised Views using clustering keys
-- =============================================================================

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
