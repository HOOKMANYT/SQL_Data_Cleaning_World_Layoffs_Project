# SQL_Data_Cleaning_World_Layoffs_Project
Complete Data Cleaning project in MySQL. Covers duplicate removal, data standardization, null handling, and schema optimization using CTEs and Window Functions.

Project Title: Global Layoffs Data Cleaning Project.

Objective: "To transform raw layoff data into a usable format for analysis by fixing errors, handling nulls, and standardizing formats."

Tools Used: MySQL Workbench.

Key Techniques: Window Functions (ROW_NUMBER), CTEs, Self Joins, Data Type Conversion.

Steps Taken: Briefly list the 4 steps you took (Duplicates, Standardization, Nulls, Removal).

#Exploratory Data Analysis

Identified a rolling total of layoffs showing a massive spike in early 2023.

Calculated that Amazon and Google had the highest total layoffs using Group By.

Used Dense Rank to isolate the top 5 companies with the most layoffs per year.

