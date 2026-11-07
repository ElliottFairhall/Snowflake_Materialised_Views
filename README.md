# 🚀 Snowflake Materialised Views

> Architecture and design rationale: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

[![Snowflake](https://img.shields.io/badge/Snowflake-Cloud%20Data%20Platform-29B5E8?style=flat&logo=snowflake)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-Snowflake%20Dialect-lightgrey)](https://docs.snowflake.com/)
[![Status](https://img.shields.io/badge/Status-Educational-success)](https://github.com/ElliottFairhall/Snowflake_Materialised_Views)

A guide to accelerating query performance using **Snowflake Materialised Views**. This project demonstrates how to
pre-compute complex aggregations and joins on single tables, leverage serverless maintenance, and optimise storage
costs.

______________________________________________________________________

## Key Features

- **Performance Acceleration**: Pre-computing results for frequent analytical queries.
- **Serverless Maintenance**: Leveraging Snowflake-managed compute for automatic refreshes.
- **Optimization**: Clustering materialised views for massive datasets.
- **Monitoring**: Tracking refresh history and storage consumption using system views.

______________________________________________________________________

## Project Structure

```text
Snowflake_Materialised_Views/
├── README.md               # You are here
├── Tutorial/
│   └── MATERIALISED_VIEWS_TUTORIAL.md # Step-by-step walkthrough
├── scripts/                # Extracted SQL scripts
│   ├── 01_basic_view_setup.sql
│   ├── 02_clustered_view.sql
│   ├── 03_secure_view_sharing.sql
│   ├── 04_maintenance_monitoring.sql
│   └── 05_storage_monitoring.sql
├── notebook/
│   └── Materialised_Views_Tutorial.ipynb
└── data/                   # Initialised as empty
```

______________________________________________________________________

## Getting Started

> **Environment Setup:** Before beginning, execute `scripts/00_setup_environment.sql` to provision the necessary
> databases, schemas, and sample data for this project.

1. Read the **[Introduction to Materialised Views](Tutorial/MATERIALISED_VIEWS_TUTORIAL.md)**.
2. Follow the deployment sequence in the `scripts/` folder.

______________________________________________________________________

## Author

**Elliott Fairhall** *Data Engineering Educational Series*
