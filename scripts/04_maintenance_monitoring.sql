-- =============================================================================
-- 04_MAINTENANCE_MONITORING
-- =============================================================================
-- Purpose:    Track refresh history and manage maintenance state
-- =============================================================================

-- 1. Check refresh history
SELECT *  -- noqa: AM04
FROM TABLE(INFORMATION_SCHEMA.MATERIALIZED_VIEW_REFRESH_HISTORY(
    DATE_RANGE_START => DATEADD('day', -7, CURRENT_TIMESTAMP())
))
ORDER BY start_time DESC;

-- 2. Suspend automatic maintenance
-- ALTER MATERIALIZED VIEW mviews_analytics.marts.mv_daily_revenue SUSPEND;

-- 3. Resume automatic maintenance
-- ALTER MATERIALIZED VIEW mviews_analytics.marts.mv_daily_revenue RESUME;
