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

-- unique titles table
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name, 
	title 
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no asc, to_date DESC;

-- retiring titles table
SELECT count(title)
	count, 
	title
into retiring_titles
from unique_titles
group by title
order by count desc;

-- mentorship eligibilty table
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,  
	de.from_date, 
	de.to_date, 
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
	on (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no asc, t.to_date DESC;