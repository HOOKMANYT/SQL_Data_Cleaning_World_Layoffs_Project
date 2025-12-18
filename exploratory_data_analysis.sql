-- Exploratory Data Analysis
Select *
From layoffs_staging2;

Select Max(total_laid_off) , Max(percentage_laid_off)
From layoffs_staging2;

Select *
From layoffs_staging2
Where percentage_laid_off = 1
Order by funds_raised_millions desc;

Select company , Sum(total_laid_off)
From layoffs_staging2
Group by company
Order by 2 desc;


Select Min(`date`),Max(`date`)
From layoffs_staging2;

Select country, Sum(total_laid_off)
From layoffs_staging2
Group by country
Order by 2 desc;

Select Year(`date`), Sum(total_laid_off)
From layoffs_staging2
Group by Year(`date`)
Order by 1 desc;

Select stage, Sum(total_laid_off)
From layoffs_staging2
Group by stage
Order by 1 desc;

Select company, Avg(percentage_laid_off)
From layoffs_staging2
Group by company
Order by 1 desc;

Select Substring(`date` ,1,7) as `Month` , Sum(total_laid_off)
From layoffs_staging2
Where Substring(`date` ,1,7) Is Not Null
Group by `Month`
Order by 1 Asc
;


With Rolling_total As
(
Select Substring(`date` ,1,7) as `Month` , Sum(total_laid_off) As total_off
From layoffs_staging2
Where Substring(`date` ,1,7) Is Not Null
Group by `Month`
Order by 1 Asc
)
Select `Month` , total_off,
 Sum(total_off) Over(Order by `Month`) As rolling_total
From Rolling_total;



Select company, Sum(total_laid_off)
From layoffs_staging2
Group by company
Order by 2 desc;


Select company,Year(`date`), Sum(total_laid_off)
From layoffs_staging2
Group by company,Year(`date`)
Order by 3 desc;

With Company_year (company , year,total_laid_off) as
(
Select company,Year(`date`), Sum(total_laid_off)
From layoffs_staging2
Group by company,Year(`date`)
) , company_year_rank as
(Select * , Dense_rank() Over(Partition by year Order by total_laid_off desc) As Ranking
From Company_year
Where year is Not Null
)
Select * 
From company_year_rank
Where ranking <= 5 ;

Select *
From layoffs_staging2
Order by 1;













