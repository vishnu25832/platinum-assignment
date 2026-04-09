# PlatinumRx Data Analyst Assignment

## Overview

This project demonstrates end-to-end data analysis using SQL, Excel, and Python.
It focuses on querying structured data, validating results, and automating aggregation.

---

## Project Structure

```
platinum-assignment/
│
├── hotel_queries.sql
├── clinic_queries.sql
├── solution.py
├── ticket.xlsx
└── README.md
```

---

## SQL

### Hotel Analysis

The following queries were implemented:

* Retrieve the last booked room for each user
* Calculate total billing amount per booking
* Identify bills greater than a threshold
* Determine most and least ordered items per month
* Find the second highest bill per month

### Clinic Analysis

The following queries were implemented:

* Calculate revenue by sales channel
* Identify top customers based on spending
* Compute monthly revenue, expense, and profit
* Find the most profitable clinic per city
* Identify the second least profitable clinic per state

---

## Excel

Excel was used for data validation and intermediate analysis:

* Verified ticket data
* Computed:

  * Same Day flag (created_at vs closed_at)
  * Same Hour flag
* Ensured correctness of logic before automation

---

## Python

Python (pandas) was used to automate final aggregation:

### Steps:

* Loaded Excel data
* Cleaned column names
* Converted Excel datetime values to proper format
* Computed:

  * same_day
  * same_hour
* Grouped data by outlet_id

---

## How to Run

### Install dependencies

```
pip install pandas openpyxl
```

### Run script

```
python solution.py
```

---

## Expected Output

```
outlet_id        same_day_count   same_hour_count
wrqy-juv-978     0                0
8woh-k3u-23b     1                0
```

---

## Key Highlights

* Clean and structured SQL queries
* Proper use of joins, aggregation, and filtering
* Excel used for validation (not overcomplicated)
* Python used for reliable and scalable computation
* Focus on correctness and clarity

---

## Notes

* All queries execute without errors
* Python script produces correct output
* Dataset kept clean for accurate processing
* Designed to reflect real-world data analysis workflow
