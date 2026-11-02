use HR;

#Q1. How many employees are present in the HR Analytics dataset?
SELECT COUNT(*) AS Total_Employees
FROM hr_analytics;

#Q2. Display all employee records from the dataset.
SELECT *
FROM hr_analytics;

#Q3. Find the total number of employees in each department.
SELECT 
    Department,
    COUNT(Employee_ID) AS Total_Employees
FROM hr_analytics
GROUP BY Department;

#Q4. Calculate the average salary of all employees.
SELECT 
    ROUND(AVG(Salary), 2) AS Average_Salary
FROM hr_analytics;

#Q5. Find the highest and lowest salary in the company.
SELECT
    MAX(Salary) AS Highest_Salary,
    MIN(Salary) AS Lowest_Salary
FROM hr_analytics;

#Q6. Find departments where the average salary is greater than 10,00,000.
SELECT
    Department,
    AVG(Salary) AS Average_Salary
FROM hr_analytics
GROUP BY Department
HAVING AVG(Salary) > 1000000;

#Q7. Find the average performance rating of each department.
SELECT
    Department,
    ROUND(AVG(Performance_Rating), 2) AS Average_Rating
FROM hr_analytics
GROUP BY Department
ORDER BY Average_Rating DESC;

#Q8. Find the average experience of employees in each department.
SELECT
    Department,
    ROUND(AVG(Experience_Years), 2) AS Average_Experience
FROM hr_analytics
GROUP BY Department;

#Q9. Find employees who received a promotion in the last three years.
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Promotion_Last_3Yrs
FROM hr_analytics
WHERE Promotion_Last_3Yrs = 'Yes';

#Q10. Find employees whose salary is greater than the company's average salary.
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Salary
FROM hr_analytics
WHERE Salary > (
    SELECT AVG(Salary)
    FROM hr_analytics
);

#Q11. Find the second-highest salary in the company.
SELECT MAX(Salary) AS Second_Highest_Salary
FROM hr_analytics
WHERE Salary < (
    SELECT MAX(Salary)
    FROM hr_analytics
);

#Q12. Find the top 3 highest-paid employees in each department.
WITH Employee_Ranking AS (
    SELECT
        Employee_ID,
        Employee_Name,
        Department,
        Salary,
        DENSE_RANK() OVER (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS Salary_Rank
    FROM hr_analytics
)
SELECT *
FROM Employee_Ranking
WHERE Salary_Rank <= 3;