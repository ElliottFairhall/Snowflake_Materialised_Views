-- =============================================================================
-- 05_STORAGE_MONITORING
-- =============================================================================
-- Purpose:    Monitor storage costs for Materialised Views
-- =============================================================================

SELECT
    table_name,
    bytes / POWER(1024, 2) AS size_mb
FROM information_schema.tables
WHERE table_type = 'MATERIALIZED VIEW'
  AND table_schema = 'MARTS';
