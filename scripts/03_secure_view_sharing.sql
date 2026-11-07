-- =============================================================================
-- 03_SECURE_VIEW_SHARING
-- =============================================================================
-- Purpose:    Create Secure Materialised Views for governance and sharing
-- =============================================================================

CREATE OR REPLACE SECURE MATERIALIZED VIEW mviews_analytics.marts.mv_shared_summary
AS
SELECT
    region,
    product_category,
    SUM(revenue) AS total_revenue
FROM mviews_analytics.marts.fct_sales
GROUP BY region, product_category;
