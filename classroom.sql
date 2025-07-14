
-- CREATE DATABASE college;
-- DROP DATABASE IF EXISTS college; 
-- CREATE DATABASE IF NOT EXISTS college;

-- DROP DATABASE IF EXISTS company;

-- SHOW DATABASES;

-- SHOW TABLES;

-- USE college;

-- CREATE TABLE student (
-- 	id INT PRIMARY KEY,
--     name VARCHAR(50),
--     age INT NOT NULL
-- );

-- DROP TABLE student;
-- DROP TABLE studend;

-- INSERT INTO student VALUES(1, "Ejaz", 22);
-- INSERT INTO student VALUES(2, "Habibi", 20);

-- SELECT * FROM student;





CREATE DATABASE IF NOT EXISTS college;
USE college;

CREATE TABLE student(
	rollno INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO student (name, rollno) VALUES ("Ejaz", 56), ("Habibi", 256);
INSERT INTO student VALUES (154, "Ansari");

SELECT * FROM student;






USE college;
CREATE TABLE temp1(
	_id INT,
    age INT,
    name VARCHAR(40),
    PRIMARY KEY (_id, age),
    salary INT DEFAULT 1000
);

CREATE TABLE temp(
	temp_id INT,
    FOREIGN KEY (temp_id) REFERENCES temp1(_id)
);

DROP TABLE IF EXISTS student;

INSERT INTO temp1 VALUES (10);
INSERT INTO temp1 VALUES (10);

SELECT * FROM temp1;






CREATE TABLE student(
	rollno INT PRIMARY KEY,
	name VARCHAR(40),
    marks INT NOT NULL,
    grade VARCHAR(2),
    city VARCHAR(30)
);

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(1, "MD", 96, "SA", "PATNA"),
(2, "EJAZ", 90, "SA", "CHAPRA"),
(3, "HABIBI", 85, "AA", "DUBAI"),
(4, "ANSARI", 79, "BB", "DELHI");
INSERT INTO student VALUES (5, "ALAM", 83, "AB", "PATNA");

-- SELECT COMMAND 
SELECT name, marks FROM student;
SELECT DISTINCT city FROM student;
SELECT * FROM student;

-- WHERE CLAUSE
SELECT * FROM student WHERE marks >= 85;

-- OPERATORS 
SELECT * FROM student WHERE city = "PATNA" OR marks >= 90;
SELECT * FROM student WHERE marks BETWEEN 80 AND 90;
SELECT * FROM student WHERE city IN ("DUBAI", "CHAPRA", "AGRA");
SELECT * FROM student WHERE city NOT IN ("DUBAI", "CHAPRA", "AGRA") AND city != "PATNA";

-- LIMIT CLAUSE 
SELECT * FROM student LIMIT 3;
SELECT * FROM student WHERE marks > 65 LIMIT 3;

-- ORDER BY CLAUSE
SELECT * FROM student ORDER BY marks ASC LIMIT 3;

-- AGGREGATE FUNCTIONS --> COUNT, MAX, MIN, SUM, AVG, etc.
SELECT max(marks) FROM student;
SELECT avg(marks) FROM student;
SELECT min(marks) FROM student;
SELECT sum(marks) FROM student;

-- GROUP BY CLAUSE
SELECT city, count(name) FROM student GROUP BY city;
SELECT city, avg(marks) FROM student GROUP BY city;


-- HAVING CLUASE --> GENERALLY USE TO APPLY CONDITION ON COLUMNS. 
SELECT city, count(rollno) FROM student GROUP BY city HAVING max(marks) >= 90;

-- ORDER OF THE CLAUSES OR COMMANDS
SELECT city, count(rollno)
FROM student
WHERE marks > 85
GROUP BY city
HAVING avg(marks)
ORDER BY city ASC;

-- UPDATE COMMANDS
SET SQL_SAFE_UPDATES = 0;
UPDATE student SET grade = "OA" WHERE grade = "SA";
UPDATE student SET marks = 88 WHERE rollno = 4;
UPDATE student SET grade = "AA" WHERE marks between 85 AND 90;
UPDATE student SET marks = marks+1;
UPDATE student SET marks = 12 WHERE rollno = 4;
SELECT * FROM student;

-- DELETE COMMAND
DELETE FROM student WHERE marks < 33;
SELECT * FROM student;


-- FOREIGN KEY IN DETAIL
CREATE TABLE dept(
	id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO dept VALUES (101, "ECE");
INSERT INTO dept VALUES (102, "CSE");

SELECT * FROM dept;

CREATE TABLE teacher(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES dept(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

UPDATE dept SET id = 103 WHERE name = "CSE";

INSERT INTO teacher VALUES (101, "MD", 101);
INSERT INTO teacher VALUES (102, "EJAZ", 102);

SELECT * FROM teacher;

-- ALTER COMMAND
ALTER TABLE teacher
ADD COLUMN age INT NOT NULL DEFAULT 18;

ALTER TABLE teacher
DROP COLUMN age;

ALTER TABLE dept
RENAME TO department;

-- ALTER TABLE teacher
-- CHANGE age teacher_age INT;

ALTER TABLE teacher
MODIFY teacher_age VARCHAR(2);

ALTER TABLE teacher
CHANGE teacher_age age INT;

INSERT INTO teacher
(id, name, age)
VALUES
(103, "HABIBI", 104);

SELECT * FROM department;

-- TRUNCATE COMMAND
TRUNCATE TABLE teacher;
SELECT * FROM teacher;



-- JOINS IN SQL
CREATE TABLE people(
	id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO people
(id, name)
VALUES
(101, "MD"),
(102, "EJAZ"),
(103, "HABIBI"),
(104, "ANSARI");

SELECT * FROM people;


CREATE TABLE course(
	id INT PRIMARY KEY,
    course VARCHAR(50)
);

INSERT INTO course
(id, course)
VALUES
(102, "MATH"),
(105, "ENGLISH"),
(103, "PHYSICS"),
(107, "CHEMISTRY");

SELECT * FROM course;

-- INNER JOINS
SELECT *
FROM people as p
INNER JOIN course as c
ON p.id = c.id;


-- LEFT JOINS
SELECT *
FROM people as p
LEFT JOIN course as c
ON p.id = c.id;


-- RIGHT JOINS
SELECT *
FROM people as p
RIGHT JOIN course as c
ON p.id = c.id;


-- FULL JOINS
SELECT *
FROM people as p
LEFT JOIN course as c
ON p.id = c.id
UNION
SELECT *
FROM people as p
RIGHT JOIN course as c
ON p.id = c.id;


-- LEFT EXCLUSIVE JOIN
SELECT *
FROM people as p
LEFT JOIN course as c
ON p.id = c.id
WHERE c.id IS NULL;

-- RIGHT EXCLUSIVE JOIN
SELECT *
FROM people as p
RIGHT JOIN course as c
ON p.id = c.id
WHERE p.id IS NULL;

-- FULL EXCLUSIVE JOIN
SELECT *
FROM people as p
LEFT JOIN course as c
ON p.id = c.id
WHERE c.id IS NULL
UNION
SELECT *
FROM people as p
RIGHT JOIN course as c
ON p.id = c.id
WHERE p.id IS NULL;

-- SELF JOIN 
CREATE TABLE employee(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

INSERT INTO employee
(id, name, manager_id)
VALUES
(101, "ADAM", 103),
(102, "BOB", 104),
(103, "CASSEY", NULL),
(104, "DINALD", 103);

SELECT * FROM employee;

SELECT a.name as manager_name, b.name
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;

-- UNION AND UNION ALL
SELECT name FROM employee
UNION
SELECT name FROM employee;

SELECT name FROM employee
UNION ALL
SELECT name FROM employee;





-- SQL Sub Queries
SELECT * FROM student;
SELECT AVG(marks)
FROM student;

-- SQL SUB QUERY USING WHERE
SELECT full_name, marks
FROM student
WHERE marks > 90.66;

SELECT full_name, marks
FROM student
WHERE marks > (SELECT AVG(marks) FROM student);

SELECT full_name, rollno
FROM student
WHERE rollno IN (SELECT rollno FROM student WHERE rollno%2 = 0);

-- SQL SUB QUERY USING FROM
SELECT MAX(marks)
FROM (SELECT * FROM student WHERE city = "PATNA") AS temp;

-- SQL SUB QUERY USING SELECT
SELECT (SELECT MAX(marks) FROM student)
FROM student;



-- MySQL Views
SELECT * FROM student;

CREATE VIEW view1 AS
SELECT rollno, full_name, marks FROM student;

SELECT * FROM view1;


































-- Practice Questions
SELECT city, avg(marks) FROM student GROUP BY city ORDER BY city ASC;


-- Practice Questions --> for the given table, find the total payment according to each payment method. 
CREATE TABLE payment(
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    payment_mode VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO payment
(customer_id, customer_name, payment_mode, city)
VALUES
(101, "OLIVIA", "NETBANKING", "PORTLAND"),
(102, "ETHAN", "CREDIT CARD", "MIAMI"),
(103, "MAYA", "CREDIT CARD", "SEATTLE"),
(104, "LIAM", "NETBANKING", "DENVER"),
(105, "SOPHIA", "CREDIT CARD", "NEW ORLEANS"),
(106, "CALEB", "DEBIT CARD", "MINNEAPOLIS"),
(107, "AVA", "DEBIT CARD", "PHOENIX"),
(108, "LUCAS", "NETBANKING", "BOSTON"),
(109, "ISABELLA", "NETBANKING", "NASHVILLE"),
(110, "JACKSON", "CREDIT CARD", "BOSTON");

SELECT * FROM payment;
SELECT payment_mode, count(payment_mode) FROM payment GROUP BY payment_mode; 




-- Practice Question Part two
-- 1. change the name of the column from name to full_name
ALTER TABLE student
CHANGE name full_name VARCHAR(50);

INSERT INTO student VALUES(4, "ANSARI", 45, "CC", "DELHI");
UPDATE student
SET marks = 59 
WHERE rollno = 3;

-- 2. delete all the students who scored less than 80
DELETE FROM student
WHERE marks < 80;

-- 3. delete the column for grades
ALTER TABLE student
DROP grade;

SELECT * FROM student;






















