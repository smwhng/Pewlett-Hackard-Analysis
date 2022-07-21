--1. Create retirement_titles table and csv
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--1. Create unique_titles table and csv
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
                    rt.first_name,
                    rt.last_name,
                    rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no, title DESC;

--1. Create retiring_titles table and csv
SELECT COUNT(ut.emp_no),
             ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY title 
ORDER BY COUNT(title) DESC;

--2 Create mentorship_eligibility table and csv
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
                   e.first_name, 
                   e.last_name, 
                   e.birth_date,
                   de.from_date,
                   de.to_date,
                   t.title
INTO mentorship_eligibilty
FROM employees AS e
LEFT OUTER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT OUTER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;