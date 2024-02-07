/*Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
*/

--ANSWER--
/* Write your PL/SQL query statement below */
Select 
max(CASE WHEN reff1.RNK=2 THEN reff1.salary 
     ELSE Null END) AS SecondHighestSalary FROM 
(
Select reff.salary,reff.RNK,
  LEAD(reff.RNK) OVER (ORDER BY reff.RNK) AS next_rank,
  LAG(reff.RNK) OVER (ORDER BY reff.RNK) AS prev_rank

from
    (
    Select
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC ) AS RNK
    FROM Employee ) reff
)reff1
WHERE reff1.RNK=2 OR (reff1.next_rank is null AND reff1.prev_rank is null OR reff1.prev_rank=1) group by 1
;
