![Project Pipeline](https://github.com/MITRANAND6MITRANK/Walmart-SQL-Python-Data-Analysis-Project/blob/main/Walmart_Project.png)

# Walmart SQL + Python Data Analysis Project

## 📊 Project Overview
This end-to-end data analysis project...

This end-to-end data analysis project focuses on Walmart sales data. It combines Python (Pandas) and SQL (PostgreSQL & MySQL) to clean data, engineer features, and answer real-world business questions. Ideal for showcasing data wrangling, EDA, and SQL proficiency.

🔄 Project Pipeline

1. Environment Setup

Tools: VS Code, Python, PostgreSQL/MySQL, Jupyter Notebook

Libraries: pandas, numpy, sqlalchemy, mysql-connector-python, psycopg2

2. Kaggle API & Dataset Setup

Used Kaggle API to download the Walmart dataset

Data stored under data/

3. Data Cleaning (Python)

Removed duplicates

Fixed data types (date, price)

Handled missing values

Cleaned currency values from unit_price

4. Feature Engineering

Added total_amount = unit_price * quantity

Extracted month/year from date for time-based grouping

5. Data Upload to SQL

Used SQLAlchemy to connect and push cleaned data to PostgreSQL

Table auto-created if not exists: walmart

6. SQL Analysis

Key queries used:

Revenue per category and branch

Most profitable category monthly

Peak days by branch

Most used payment method per branch

Year-over-year performance analysis

7. Business Questions Answered

Which branch has the highest sales?

What is the busiest day per store?

Which category yields the highest monthly profit?

Preferred payment method by branch?

Performance comparison between 2022 and 2023?

8. Documentation & Publishing

Code, SQL queries, and analysis stored and explained in Jupyter Notebook

Project available on GitHub

📃 Project Structure

|-- data/                     # Raw and cleaned data
|-- sql_queries/              # SQL scripts used in analysis
|-- notebooks/                # Jupyter notebooks for EDA
|-- requirements.txt          # Python libraries list
|-- README.md                 # Project overview
|-- main.py                   # Script to process and upload data

🔢 Tech Stack

Language: Python 3.8+

Databases: PostgreSQL, MySQL

Libraries: pandas, numpy, sqlalchemy, psycopg2, mysql-connector-python

Tools: VS Code, Jupyter Notebook, Git, Kaggle

📊 Results & Insights

City & Category Trends: Clear insights on which cities sell which categories the most

Profitability: Electronics & Fashion showed highest margins

Behavioral Trends: Evening hours & weekends were peak times

Payment Patterns: Ewallets were most popular

🖼️ Visual Project Flow



🚀 Future Improvements

Connect PostgreSQL to Tableau or Power BI for dashboarding

Include real-time ingestion with APIs

Schedule monthly updates using cron jobs

📄 Acknowledgments

Dataset: Kaggle - Walmart Sales Dataset

Inspired by: Real Walmart case studies on operational efficiency
