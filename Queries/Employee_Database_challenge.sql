SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by (e.emp_no);

SELECT emp_no, 
	first_name, 
	last_name  from retirement_titles;


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

-- Analysis queries 
Select title, count(title)
from unique_titles
group by title
order by count(title) desc;

-- creating a current total employees table 

SELECT distinct on (emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	t.title,  
	t.to_date
INTO all_current_emp
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
order by emp_no asc, to_date desc; 

select count(emp_no) 
from all_current_emp;
select sum(retiring_total)
from retiring_titles;
select count(emp_no)
from employees;


select title, count(title)
into mentorship_eligibility_total
from mentorship_eligibilty
group by title
order by count(title) desc;

select title, count(title)
into employee_title_total
from all_current_emp
group by title
order by count(title) desc;

-- alter tables

alter table employee_title_total
rename column count TO employee_total;

-- creating totals graph
select e.title,
	e.employee_total,
	rt.retiring_total,
	me.mentorship_total
into overall_totals
from employee_title_total as e
inner join retiring_titles as rt
on (e.title = rt.title)
inner join mentorship_eligibility_total as me
on (rt.title = me.title)
order by rt.retiring_total desc;

-- totals 
select count(emp_no)
from all_current_emp;

select count(emp_no)
from unique_titles;

select sum(employee_total)
from employemployee_title_total;

-- Delete tables
--drop table overall_totals;

--  duplicates 
select emp_no, count(emp_no)
from unique_titles
group by emp_no
having count(emp_no) > 1;

-- graphs 
select * from retiring_titles;

select sum(mentorship_total) from mentorship_eligibility_total;

select * from overall_totals;

select * from mentorship_eligibilty;

alter table overall_totals
add percent_retiring int;

alter table overall_totals
add percent_mentorship AS (mentorship_total / retiring_total);