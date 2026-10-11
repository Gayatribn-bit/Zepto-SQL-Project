# Zepto-SQL-Project
End-to-end quick-commerce inventory and supply chain data analysis project using SQL Server (T-SQL), modeling weight segmentation, stockout risk, and category revenue distribution.
# Quick-Commerce Inventory & Supply Chain Analytics (Zepto Dataset)

## 📌 Project Overview
This project applies **Industrial Engineering and Operations Research principles** to analyze a quick-commerce retail dataset (`zepto`). Built using **Microsoft SQL Server (T-SQL)**, the project evaluates dark-store inventory distribution, weight-based SKU segmentation, stock availability gaps, and category-level revenue concentrations to model operational efficiencies in fast-paced retail logistics.

## 🏭 Industrial Engineering & Operations Highlights
* **Inventory Control & Warehousing:** Computed total inventory weight per category using heavy-load data casting (`BIGINT`) to prevent arithmetic overflow and assist in storage/weight capacity planning.
* **Material & Weight Segmentation:** Grouped products into structural weight tiers (`Low`, `Medium`, `Bulk`) using conditional logic (`CASE`) to evaluate physical handling and storage footprints.
* **Supply Chain Risk Analysis:** Identified high-value items facing stockouts (`outOfStock = 1` with high MRP) to highlight availability gaps impacting customer service levels.
* **Revenue & Yield Modeling:** Computed estimated category revenues based on discounted selling prices and available quantities.

## 🛠️ Technical Implementation & Architecture
* **DBMS:** Microsoft SQL Server (SSMS)
* **Language:** T-SQL
* **ETL Pipeline:** 
  - Bypassed file-locking and strict type constraints by importing raw data into a flexible staging architecture (`VARCHAR(MAX)` columns) via `BULK INSERT`.
  - Implemented error-resilient type casting (`TRY_CAST`) to clean and transfer raw text strings into structured production data types (`INT`, `NUMERIC`, `BIT`).

## 📂 Project Structure & Script Contents
The analysis script (`zepto_analysis_script.sql`) is divided into three core operational stages:
1. **Data Exploration:** Row counting, null-value checks, category distributions, and multi-SKU product identification.
2. **Data Cleaning:** Anomaly detection (filtering zero-MRP records) and pricing standardization.
3. **Data Analysis & Business Queries:** Advanced aggregations, revenue calculations, weight classifications, and stockout tracking.

## 🚀 How to Run the Project
1. Open SQL Server Management Studio (SSMS).
2. Create your database: `CREATE DATABASE Zepto_SQL_project;`
3. Execute the data staging and `TRY_CAST` insertion workflow to load the dataset.
4. Run `zepto_analysis_script.sql` to execute the exploration, cleaning, and analysis queries.
