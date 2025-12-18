-- Data Cleaning

Select *
From layoffs;

-- Remove Duplicates
-- Standardize the Data
-- Null Values or Blank Values
-- Remove Any Columns

Create Table layoffs_staging
Like layoffs;

Select *
From layoffs_staging;

Insert layoffs_staging
Select *
From layoffs;

-- Removing Duplicates

Select *,
Row_Number() Over(
Partition By company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
) as row_num
From layoffs_staging;

With duplicates_cte As
(
	Select *,
	Row_Number() Over(
	Partition By company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
	) as row_num
	From layoffs_staging
)
Select *
From duplicates_cte
Where row_num > 1;

Select *
From layoffs_staging
Where company = 'Casper';

#This method doesn't work. Cause delete is not Updatable here..
With duplicates_cte As
(
	Select *,
	Row_Number() Over(
	Partition By company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
	) as row_num
	From layoffs_staging
)
Delete
From duplicates_cte
Where row_num > 1;

# Different Apporch by making another Temp Table
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
From layoffs_staging2
Where row_num > 1;

Insert Into	layoffs_staging2
Select *,
Row_Number() Over(
Partition By company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
) as row_num
From layoffs_staging;

Delete
From layoffs_staging2
Where row_num > 1;

Select *
From layoffs_staging2;

-- Standardize the Data

Select company,Trim(company)
From layoffs_staging2;

Update layoffs_staging2
Set company = Trim(company);


Select Distinct industry
From layoffs_staging2
Order by 1;

Update layoffs_staging2
Set industry = 'Crypto'
Where industry Like ('Crypto%');

Select Distinct country, Trim(Trailing '.' From country)
From layoffs_staging2
Order by 1;

Update layoffs_staging2
Set country = Trim(Trailing '.' From country)
Where country Like 'United States%';

Select `date`
From layoffs_staging2;

Update layoffs_staging2
Set `date` = str_to_date(`date`, '%m/%d/%Y');

Alter Table layoffs_staging2
Modify Column `date` Date;


Select *
From layoffs_staging2;

-- Null Values or Blank Values

#We we Remove this Nulls in Step 4
Select *
From layoffs_staging2
Where total_laid_off Is Null
And percentage_laid_off Is Null;

Update	layoffs_staging2
Set industry = Null
Where industry ='';

Select *
From layoffs_staging2
Where industry is Null
Or industry ='';


Select *
From layoffs_staging2
Where company = 'Airbnb';

Select t1.industry ,t2.industry
From layoffs_staging2 t1
Join layoffs_staging2 t2
	on t1.company = t2.company
Where (t1.industry Is Null Or t1.industry ='')
and t2.industry Is not null;

Update layoffs_staging2 t1
Join layoffs_staging2 t2
	on t1.company = t2.company
Set t1.industry = t2.industry
Where t1.industry Is Null
and t2.industry Is not null;


-- Remove Any Columns
Select *
From layoffs_staging2;


Select *
From layoffs_staging2
Where total_laid_off Is Null
And percentage_laid_off Is Null;

Delete
From layoffs_staging2
Where total_laid_off Is Null
And percentage_laid_off Is Null;

Select *
From layoffs_staging2;

Alter Table layoffs_staging2
Drop Column row_num;
