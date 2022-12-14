-- find retirement eligibility
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- 1952 births 
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- 1953
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- 1954
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--1955
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
And (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring 
SELECT COUNT (first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
And (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility into new table 
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

select * from retirement_info; 
And (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name, 
	d.dept_name
INTO sales_emp
FROM retirement_info as ri
INNER JOIN dept_emp as de
	ON (ri.emp_no = de.emp_no)
INNER JOIN departments as d 
	on (de.dept_no = d.dept_no)
WHERE (d.dept_name = ('Sales'));