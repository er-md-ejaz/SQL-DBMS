CREATE DATABASE MyCompany;
USE MyCompany;

CREATE TABLE EmployeeInfo(
	_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT NOT NULL
);

INSERT INTO EmployeeInfo
(_id, name, salary)
VALUES
(1, "Ejaz", 1000),
(2, "Habibi", 1500),
(3, "Koyla", 500),
(4, "Danav", 2000);

SELECT * FROM EmployeeInfo;