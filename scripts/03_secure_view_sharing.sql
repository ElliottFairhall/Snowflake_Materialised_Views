-- =============================================================================
-- 03_SECURE_VIEW_SHARING
-- =============================================================================
-- Purpose:    Create Secure Materialised Views for governance and sharing
-- =============================================================================

CREATE OR REPLACE SECURE MATERIALIZED VIEW analytics.marts.mv_shared_summary
AS
SELECT
    region,
    product_category,
    SUM(revenue) AS total_revenue
FROM analytics.marts.fct_sales
GROUP BY region, product_category;
