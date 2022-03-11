-- 1.1
SELECT
	employees.emp_no,
	employees.first_name,
	employees.last_name
	title,
	from_date,
	to_date
FROM titles
INNER JOIN employees
ON employees.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ASC, titles.from_date DESC
;

-- 1.2
DROP TABLE IF EXISTS retirement_titles;

SELECT
	employees.emp_no,
	employees.first_name,
	employees.last_name
	title,
	from_date,
	to_date
INTO retirement_titles
FROM titles
INNER JOIN employees
ON employees.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ASC
;

SELECT * FROM retirement_titles;

-- 1.3
DROP TABLE IF EXISTS unique_titles;

SELECT
	DISTINCT ON (emp_no)
	employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title
INTO TABLE unique_titles
FROM titles
INNER JOIN employees
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND to_date = '9999-01-01'
ORDER BY employees.emp_no ASC, titles.from_date DESC
;

SELECT * FROM unique_titles;

-- 1.4
SELECT title, COUNT(*)
INTO TABLE retiring_titles
	FROM unique_titles
	GROUP BY title
	ORDER BY COUNT DESC
;

SELECT * 
FROM retiring_titles;

-- 2.1
DROP TABLE IF EXISTS mentorship_eligibility;

SELECT
	DISTINCT ON (emp_no)
	employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_employees.from_date,
	dept_employees.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees
	INNER JOIN
		dept_employees
		ON employees.emp_no = dept_employees.emp_no
	INNER JOIN
		titles
		ON dept_employees.emp_no = titles.emp_no
WHERE dept_employees.to_date = '9999-01-01'
	AND employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY employees.emp_no ASC, titles.from_date DESC
;

SELECT * FROM mentorship_eligibility;



-- ADDITIONAL INFORMATION GATHERED

-- TOTAL AMOUNT OF "CURRENT" EMPLOYEES

DROP TABLE IF EXISTS total_titles;

SELECT title, COUNT(*)
INTO TABLE total_titles
	FROM titles
	WHERE titles.to_date = '9999-01-01'
	GROUP BY title
	ORDER BY COUNT DESC
;

SELECT * FROM total_titles;

-- MENTORS GROUPED BY TITLE

DROP TABLE IF EXISTS mentorship_eligibility;

SELECT title, COUNT(*)
FROM mentorship_eligibility
WHERE to_date = '9999-01-01'
GROUP BY title
;


