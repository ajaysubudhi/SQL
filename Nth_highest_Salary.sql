--Nth Highest Salary
--------------------
CREATE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
result NUMBER;
BEGIN
    Select max(ref.salary) INTO result
    From 
    (
    Select 
        salary,
        DENSE_RANK() OVER (order by salary desc) AS Rnk
    FROM Employee
    ) ref
    where ref.Rnk= N ;

    RETURN result;
END;
