DROP TABLE employee_titles;
-- Deliverable 1.1

SELECT emp_no,
	first_name,
	last_name
FROM employees;

-- Deliverable 1.2

SELECT title,
	from_date,
	to_date
FROM titles;

-- Deliverable 1.3, 1.4, 1.5
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO employee_titles
FROM employees as e
INNER JOIN titles as t ON
e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

-- Deliverable 1.8 to 1.12
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM employee_titles
ORDER BY emp_no, to_date DESC;

drop table retiring_titles;
-- Deliverable 1.15 to 1.20
SELECT COUNT(title) AS "ret_count",  title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "ret_count" DESC;

-- Deliverable 2

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no
INNER JOIN titles AS t ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- Find mentors by employee title
select mentorship_eligibility.title,
count(mentorship_eligibility.title) as me_count 
into me_by_title 
from mentorship_eligibility
group by mentorship_eligibility.title;

select * from me_by_title;
select * from retiring_titles;

select sum(ret_count)
from retiring_titles;