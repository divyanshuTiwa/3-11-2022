-- test 3/11/2022
create database org;
use org;
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
INSERT INTO Worker 
    (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
        (001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
        (002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
        (003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
        (004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
        (005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
        (006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
        (007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
        (008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        select * from worker;
       -- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
				
                Select FIRST_NAME AS WORKER_NAME from Worker;
            
		-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
					Select upper(FIRST_NAME) from Worker;
		-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
					Select distinct DEPARTMENT from Worker;
		/* Q-4. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
				A space char should separate them.*/
                select concat(FIRST_NAME, ' ', LAST_NAME) As 'COMPLETE_NAME.' from worker;
		-- Q-5. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
				Select * from Worker order by FIRST_NAME asc;
        /* Q-6. Write an SQL query to print all Worker details from the Worker table
				order by FIRST_NAME Ascending and DEPARTMENT Descending. */
					Select * from Worker order by FIRST_NAME asc,DEPARTMENT desc;
        /*  Q-7. Write an SQL query to print details for Workers with the first name as “Vipul” 
					and “Satish” from Worker table. */
					select * from worker where FIRST_NAME in('vipul','satish');
            
        /* Q-8. Write an SQL query to print details of workers
				excluding first names, “Vipul” and “Satish” from Worker table. */
                select * from worker where FIRST_NAME not in ('vipul','satish');
         -- Q-9. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.       
					select * from worker where  DEPARTMENT like'admin';
         -- Q-10. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
					select * from worker where FIRST_name like ('%a%');
           -- Q-11. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
					select * from worker where FIRST_name like ('%a');
           /* Q-12. Write an SQL query to print details of the Workers whose FIRST_NAME 
					ends with ‘h’ and contains six alphabets. */
                    select * from worker where FIRST_NAME like ('_____h%');
            /* Q-13. Write an SQL query to print details of the 
					Workers whose SALARY lies between 100000 and 500000. */
                    select * from worker where SALARY between 100000 and 500000;
            -- Q-14. Write an SQL query to print details of the Workers who have joined in Feb’2014.
						select * from worker where year(JOINING_DATE)= 2014 and month(JOINING_DATE)=2;
            -- Q-15. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
						select count(*) from worker where department='admin';
            -- Q-16. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
						SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) As Worker_Name, Salary
						FROM worker 
						WHERE WORKER_ID IN 
						(SELECT WORKER_ID FROM worker 
						WHERE Salary BETWEEN 50000 AND 100000);
                        
            /* Q-17. Write an SQL query to fetch the no. 
            of workers for each department in the descending order.*/
						SELECT DEPARTMENT, count(WORKER_ID) No_Of_Workers 
						FROM worker 
						GROUP BY DEPARTMENT 
					ORDER BY No_Of_Workers DESC;
              
						CREATE TABLE Bonus (
						WORKER_REF_ID INT,
						BONUS_AMOUNT INT(10),
						BONUS_DATE DATETIME,
						FOREIGN KEY (WORKER_REF_ID)
						REFERENCES Worker(WORKER_ID)
						ON DELETE CASCADE
						);
                        INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
 -- Q-18. Write an SQL query to print details of the Workers who are also Managers.
			-- the Workers who are also Managers
				select DISTINCT W.FIRST_NAME, T.WORKER_TITLE
				from Worker W
				inner join Title T
				ON W.WORKER_ID = T.WORKER_REF_ID
				AND T.WORKER_TITLE in ('Manager');

            -- Q-19. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
						select AFFECTED_FROM, COUNT(*)
						from  Title
						group by WORKER_TITLE, AFFECTED_FROM
						having COUNT(*) > 1;
             -- Q-20. Write an SQL query to show only odd rows from a table.alter
						select * from Worker where MOD (WORKER_ID, 2) <> 0;
            -- Q-21. Write an SQL query to show only even rows from a table.
						select * from Worker where MOD (WORKER_ID, 2)=0;
             -- Q-22. Write an SQL query to show the current date and time.
						select now();
              -- Q-23. Write an SQL query to show the top n (say 10) records of a table.          
						select * from Worker order  by Salary desc LIMIT 10 ;    
              -- Q-24. Write an SQL query to determine the nth (say n=5) highest salary from a table.
						select SALARY, FIRST_NAME
						from Worker W
						where 4 = (select count(distinct( S.SALARY ))
						from Worker S
						where S.SALARY >= W.SALARY);
            -- Q-25. Write an SQL query to fetch the list of employees with the same salary.
		select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary 
		from Worker W, Worker W1 
		where W.Salary = W1.Salary 
		and W.WORKER_ID != W1.WORKER_ID;  
        -- Q-26. Write an SQL query to show the second highest salary from a table.
			select max(Salary) from Worker 
			where Salary not in (select max(Salary) from Worker);
       -- Q-27. Write an SQL query to fetch the first 50% records from a table.
				select * from Worker 
				where WORKER_ID <= (select count(WORKER_ID)/2 from Worker);
        -- Q-28. Write an SQL query to fetch the departments that have less than five people in it.
				
					SELECT DEPARTMENT, COUNT(Worker_id) AS 'Number of Workers' FROM Worker 
					GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;
          -- Q-29. Write an SQL query to show all departments along with the number of people in there.
					 SELECT DEPARTMENT, COUNT(department) AS 'Number of Workers' FROM Worker 
					GROUP BY department;
            -- Q-30. Write an SQL query to show the last record from a table. 
					select *from worker
					ORDER BY worker_id DESC 
					LIMIT 1;
                    -- Q-31. Write an SQL query to fetch the first row of a table.  
                    select *from worker
					ORDER BY worker_id 
					LIMIT 1;
                    -- Q-32. Write an SQL query to fetch three max salaries from a table.
                    	SELECT DISTINCT salary  AS Max_salary
					FROM worker worker1 
					WHERE 3 >= (SELECT COUNT(DISTINCT salary) 
					FROM worker worker2 
					WHERE worker2.salary >= worker1.salary) 
					ORDER BY worker1.salary DESC;
                    -- Q-33. Write an SQL query to fetch three min salaries from a table.
                    SELECT DISTINCT salary  AS Max_salary
					FROM worker worker1 
					WHERE 3 >= (SELECT COUNT(DISTINCT salary) 
					FROM worker worker2 
					WHERE worker2.salary <= worker1.salary) 
					ORDER BY worker1.salary;
                    -- Q-34. Write an SQL query to fetch departments along with the total salaries paid for each of them.
						SELECT department, SUM(salary)
						FROM worker 
						GROUP BY department;
				
                    -- Q-35. Write an SQL query to fetch the names of workers who earn the highest salary.
						SELECT first_name,salary from worker
						WHERE salary = (SELECT MAX(salary) FROM worker);
					