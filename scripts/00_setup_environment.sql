-- =============================================================================
-- 00_SETUP_ENVIRONMENT
-- =============================================================================
-- Purpose:    Provision the necessary databases, schemas, and sample data
--             to serve as the foundation for the Materialised Views tutorial.
-- =============================================================================

USE ROLE SYSADMIN;

-- 1. Create base DBs and Schemas
CREATE DATABASE IF NOT EXISTS ANALYTICS;
CREATE SCHEMA IF NOT EXISTS ANALYTICS.MARTS;

-- 2. Create and populate Orders fact table
CREATE OR REPLACE TABLE ANALYTICS.MARTS.FCT_ORDERS (
    ORDER_ID INT,
    CUSTOMER_ID INT,
    ORDER_DATE DATE,
    TOTAL_AMOUNT NUMBER(10, 2)
);

INSERT INTO ANALYTICS.MARTS.FCT_ORDERS VALUES
    (101, 1, '2026-03-01', 150.00),
    (102, 1, '2026-03-01', 89.50),
    (103, 2, '2026-03-02', 210.25),
    (104, 3, '2026-03-02', 95.00),
    (105, 1, '2026-03-03', 120.00);

-- 3. Create and populate Customer dimension
CREATE OR REPLACE TABLE ANALYTICS.MARTS.DIM_CUSTOMERS (
    CUSTOMER_ID INT,
    CUSTOMER_NAME VARCHAR,
    CUSTOMER_SEGMENT VARCHAR,
    REGION VARCHAR,
    LIFETIME_REVENUE NUMBER(10, 2)
);

INSERT INTO ANALYTICS.MARTS.DIM_CUSTOMERS VALUES
    (1, 'TechCorp', 'Enterprise', 'NA', 150000.00),
    (2, 'GlobalNet', 'Enterprise', 'EMEA', 210000.00),
    (3, 'LocalShop', 'SMB', 'NA', 12000.00);

-- 4. Create and populate Sales fact table
CREATE OR REPLACE TABLE ANALYTICS.MARTS.FCT_SALES (
    SALE_ID INT,
    REGION VARCHAR,
    PRODUCT_CATEGORY VARCHAR,
    REVENUE NUMBER(10, 2)
);

INSERT INTO ANALYTICS.MARTS.FCT_SALES VALUES
    (1001, 'NA', 'Hardware', 1500.00),
    (1002, 'EMEA', 'Software', 2300.00),
    (1003, 'NA', 'Software', 4100.00),
    (1004, 'EMEA', 'Hardware', 8900.00);
