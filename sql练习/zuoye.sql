-- 1.	查询所有员工的姓名、邮箱和工作岗位。
SELECT CONCAT(first_name, ' ', last_name) AS full_name, email, job_title
FROM employees;

-- 2. 查询所有部门的名称和位置。
SELECT dept_name, location
FROM departments;

-- 3. 查询工资超过70000的员工姓名和工资。
SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE salary > 70000;

-- 4. 查询IT部门的所有员工。
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 5. 查询入职日期在2020年之后的员工信息。
SELECT *
FROM employees
WHERE hire_date > '2020-01-01';

-- 6. 计算每个部门的平均工资。
SELECT d.dept_name, AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 7. 查询工资最高的前3名员工信息。
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- 8. 查询每个部门员工数量。
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 9. 查询没有分配部门的员工。
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE dept_id IS NULL;

-- 10. 查询参与项目数量最多的员工。
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS full_name, COUNT(ep.project_id) AS project_count
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id
ORDER BY project_count DESC
LIMIT 1;

-- 11. 计算所有员工的工资总和。
SELECT SUM(salary) AS total_salary
FROM employees;

-- 12. 查询姓"Smith"的员工信息。
SELECT *
FROM employees
WHERE last_name = 'Smith';

-- 13. 查询即将在半年内到期的项目。
SELECT *
FROM projects
WHERE end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

-- 14. 查询至少参与了两个项目的员工。
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS full_name, COUNT(ep.project_id) AS project_count
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id
HAVING project_count >= 2;

-- 15. 查询没有参与任何项目的员工。
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees e
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;

-- 16. 计算每个项目参与的员工数量。
SELECT p.project_name, COUNT(ep.emp_id) AS employee_count
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_name;

-- 17. 查询工资第二高的员工信息。
SELECT p.project_name, COUNT(ep.emp_id) AS employee_count
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_name;

-- 18. 查询每个部门工资最高的员工。
SELECT e.*
FROM employees e
JOIN (
    SELECT dept_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY dept_id
) AS max_salaries ON e.dept_id = max_salaries.dept_id AND e.salary = max_salaries.max_salary;

-- 19. 计算每个部门的工资总和,并按照工资总和降序排列。
SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY total_salary DESC;

-- 20. 查询员工姓名、部门名称和工资。
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- 21. 查询每个员工的上级主管(假设emp_id小的是上级)。
SELECT e1.emp_id AS employee_id, CONCAT(e1.first_name, ' ', e1.last_name) AS employee_name,
       e2.emp_id AS supervisor_id, CONCAT(e2.first_name, ' ', e2.last_name) AS supervisor_name
FROM employees e1
LEFT JOIN employees e2 ON e1.dept_id = e2.dept_id AND e1.emp_id > e2.emp_id;

-- 22. 查询所有员工的工作岗位,不要重复。
SELECT DISTINCT job_title
FROM employees;

-- 23. 查询平均工资最高的部门。
SELECT d.dept_name
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY AVG(e.salary) DESC
LIMIT 1;

-- 24. 查询工资高于其所在部门平均工资的员工。
SELECT e.*
FROM employees e
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) AS dept_avg ON e.dept_id = dept_avg.dept_id
WHERE e.salary > dept_avg.avg_salary;

-- 25. 查询每个部门工资前两名的员工。
SELECT e.*
FROM (
    SELECT emp_id, first_name, last_name, salary, dept_id,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rank
    FROM employees
) AS ranked
WHERE rank <= 2;

-- ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
-- ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

-- 1. 查询所有学生的信息。
SELECT * FROM student;

-- 2. 查询所有课程的信息。
SELECT * FROM course;

-- 3. 查询所有学生的姓名、学号和班级。
SELECT name, student_id, my_class FROM student;

-- 4. 查询所有教师的姓名和职称。
SELECT name, title FROM teacher;

-- 5. 查询不同课程的平均分数。
SELECT course_id, AVG(score) AS average_score
FROM score
GROUP BY course_id;

-- 6. 查询每个学生的平均分数。
SELECT student_id, AVG(score) AS average_score
FROM score
GROUP BY student_id;

-- 7. 查询分数大于85分的学生学号和课程号。
SELECT student_id, course_id
FROM score
WHERE score > 85;

-- 8. 查询每门课程的选课人数。
SELECT course_id, COUNT(student_id) AS student_count
FROM score
GROUP BY course_id;

-- 9. 查询选修了"高等数学"课程的学生姓名和分数。
SELECT s.name, sc.score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.course_id = 'C001';

-- 10. 查询没有选修"大学物理"课程的学生姓名。
SELECT name
FROM student
WHERE student_id NOT IN (
    SELECT student_id
    FROM score
    WHERE course_id = 'C002'
);

-- 11. 查询C001比C002课程成绩高的学生信息及课程分数。
SELECT s.student_id, s.name, sc1.score AS score_C001, sc2.score AS score_C002
FROM student s
JOIN score sc1 ON s.student_id = sc1.student_id AND sc1.course_id = 'C001'
JOIN score sc2 ON s.student_id = sc2.student_id AND sc2.course_id = 'C002'
WHERE sc1.score > sc2.score;

-- 12. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
SELECT sc.course_id, c.course_name,
       SUM(CASE WHEN sc.score >= 85 THEN 1 ELSE 0 END) AS '100-85',
       SUM(CASE WHEN sc.score < 85 AND sc.score >= 70 THEN 1 ELSE 0 END) AS '85-70',
       SUM(CASE WHEN sc.score < 70 AND sc.score >= 60 THEN 1 ELSE 0 END) AS '70-60',
       SUM(CASE WHEN sc.score < 60 THEN 1 ELSE 0 END) AS '60-0',
       COUNT(sc.student_id) AS total,
       (SUM(CASE WHEN sc.score >= 85 THEN 1 ELSE 0 END) / COUNT(sc.student_id) * 100) AS percentage_100_85,
       (SUM(CASE WHEN sc.score < 85 AND sc.score >= 70 THEN 1 ELSE 0 END) / COUNT(sc.student_id) * 100) AS percentage_85_70,
       (SUM(CASE WHEN sc.score < 70 AND sc.score >= 60 THEN 1 ELSE 0 END) / COUNT(sc.student_id) * 100) AS percentage_70_60,
       (SUM(CASE WHEN sc.score < 60 THEN 1 ELSE 0 END) / COUNT(sc.student_id) * 100) AS percentage_60_0
FROM score sc
JOIN course c ON sc.course_id = c.course_id
GROUP BY sc.course_id, c.course_name;

-- 13. 查询选择C002课程但没选择C004课程的成绩情况(不存在时显示为 null )。
SELECT s.student_id, s.name, sc2.score
FROM student s
LEFT JOIN score sc1 ON s.student_id = sc1.student_id AND sc1.course_id = 'C002'
LEFT JOIN score sc2 ON s.student_id = sc2.student_id AND sc2.course_id = 'C004'
WHERE sc1.score IS NOT NULL;

-- 14. 查询平均分数最高的学生姓名和平均分数。
SELECT student_id, name, AVG(score) AS average_score
FROM score s
JOIN student st ON s.student_id = st.student_id
GROUP BY s.student_id
ORDER BY average_score DESC
LIMIT 1;

-- 15. 查询总分最高的前三名学生的姓名和总分。
SELECT student_id, name, SUM(score) AS total_score
FROM score s
JOIN student st ON s.student_id = st.student_id
GROUP BY s.student_id
ORDER BY total_score DESC
LIMIT 3;

-- 16. 查询各科成绩最高分、最低分和平均分。要求如下：
-- 以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
-- 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
-- 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
SELECT sc.course_id, c.course_name,
       MAX(score) AS max_score,
       MIN(score) AS min_score,
       AVG(score) AS avg_score,
       SUM(CASE WHEN score >= 60 THEN 1 ELSE 0 END) / COUNT(student_id) * 100 AS passing_rate,
       SUM(CASE WHEN score >= 70 AND score < 80 THEN 1 ELSE 0 END) / COUNT(student_id) * 100 AS medium_rate,
       SUM(CASE WHEN score >= 80 AND score < 90 THEN 1 ELSE 0 END) / COUNT(student_id) * 100 AS good_rate,
       SUM(CASE WHEN score >= 90 THEN 1 ELSE 0 END) / COUNT(student_id) * 100 AS excellent_rate,
       COUNT(DISTINCT student_id) AS student_count
FROM score sc
JOIN course c ON sc.course_id = c.course_id
GROUP BY sc.course_id, c.course_name
ORDER BY student_count DESC, sc.course_id ASC;

-- 17. 查询男生和女生的人数。
SELECT gender, COUNT(*) AS count
FROM student
GROUP BY gender;

-- 18. 查询年龄最大的学生姓名。
SELECT name
FROM student
ORDER BY birth_date ASC
LIMIT 1;

-- 19. 查询年龄最小的教师姓名。
SELECT name
FROM teacher
ORDER BY birth_date DESC
LIMIT 1;

-- 20. 查询学过「张教授」授课的同学的信息。
SELECT s.*
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.course_id IN (SELECT course_id FROM course WHERE teacher_id = 'T001');

-- 21. 查询查询至少有一门课与学号为"2021001"的同学所学相同的同学的信息 。
SELECT DISTINCT s.*
FROM student s
JOIN score sc1 ON s.student_id = sc1.student_id
WHERE sc1.course_id IN (SELECT course_id FROM score WHERE student_id = '2021001')
  AND s.student_id != '2021001';

-- 22. 查询每门课程的平均分数，并按平均分数降序排列。
SELECT course_id, AVG(score) AS average_score
FROM score
GROUP BY course_id
ORDER BY average_score DESC;

-- 23. 查询学号为"2021001"的学生所有课程的分数。
SELECT course_id, score
FROM score
WHERE student_id = '2021001';

-- 24. 查询所有学生的姓名、选修的课程名称和分数。
SELECT s.name, c.course_name, sc.score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id;

-- 25. 查询每个教师所教授课程的平均分数。
SELECT t.name, AVG(sc.score) AS average_score
FROM teacher t
JOIN course c ON t.teacher_id = c.teacher_id
JOIN score sc ON c.course_id = sc.course_id
GROUP BY t.name;

-- 26. 查询分数在80到90之间的学生姓名和课程名称。
SELECT s.name, c.course_name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
JOIN course c ON sc.course_id = c.course_id
WHERE sc.score BETWEEN 80 AND 90;

-- 27. 查询每个班级的平均分数。
SELECT my_class, AVG(sc.score) AS average_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY my_class;

-- 28. 查询没学过"王讲师"老师讲授的任一门课程的学生姓名。
SELECT s.name
FROM student s
WHERE s.student_id NOT IN (
    SELECT sc.student_id
    FROM score sc
    JOIN course c ON sc.course_id = c.course_id
    WHERE c.teacher_id = 'T002'
);

-- 29. 查询两门及其以上小于85分的同学的学号，姓名及其平均成绩 。
SELECT s.student_id, s.name, AVG(sc.score) AS average_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.score < 85
GROUP BY s.student_id, s.name
HAVING COUNT(sc.course_id) >= 2;

-- 30. 查询所有学生的总分并按降序排列。
SELECT student_id, SUM(score) AS total_score
FROM score
GROUP BY student_id
ORDER BY total_score DESC;

-- 31. 查询平均分数超过85分的课程名称。
SELECT c.course_name
FROM course c
JOIN score sc ON c.course_id = sc.course_id
GROUP BY c.course_id
HAVING AVG(sc.score) > 85;

-- 32. 查询每个学生的平均成绩排名。
SELECT student_id, name, AVG(score) AS average_score,
       RANK() OVER (ORDER BY AVG(score) DESC) AS rank
FROM score s
JOIN student st ON s.student_id = st.student_id
GROUP BY s.student_id, st.name;

-- 33. 查询每门课程分数最高的学生姓名和分数。
SELECT s.name, sc.score, sc.course_id
FROM score sc
JOIN student s ON sc.student_id = s.student_id
WHERE (sc.course_id, sc.score) IN (
    SELECT course_id, MAX(score)
    FROM score
    GROUP BY course_id
);

-- 34. 查询选修了"高等数学"和"大学物理"的学生姓名。
SELECT DISTINCT s.name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.course_id IN ('C001', 'C002')
GROUP BY s.student_id
HAVING COUNT(DISTINCT sc.course_id) = 2;

-- 35. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩（没有选课则为空）。
SELECT s.student_id, s.name, c.course_name, sc.score,
       AVG(sc.score) OVER (PARTITION BY s.student_id) AS average_score
FROM student s
LEFT JOIN score sc ON s.student_id = sc.student_id
LEFT JOIN course c ON sc.course_id = c.course_id;

-- 36. 查询分数最高和最低的学生姓名及其分数。
(SELECT s.name, MAX(sc.score) AS score
 FROM score sc
 JOIN student s ON sc.student_id = s.student_id
 GROUP BY s.name
 ORDER BY score DESC
 LIMIT 1)
UNION
(SELECT s.name, MIN(sc.score) AS score
 FROM score sc
 JOIN student s ON sc.student_id = s.student_id
 GROUP BY s.name
 ORDER BY score ASC
 LIMIT 1);

-- 37. 查询每个班级的最高分和最低分。
SELECT s.my_class, MAX(sc.score) AS max_score, MIN(sc.score) AS min_score
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.my_class;

-- 38. 查询每门课程的优秀率（优秀为90分）。
SELECT course_id,
       SUM(CASE WHEN score >= 90 THEN 1 ELSE 0 END) / COUNT(student_id) * 100 AS excellent_rate
FROM score
GROUP BY course_id;

-- 39. 查询至少有一门课程分数低于80分的学生姓名。
SELECT DISTINCT s.name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
WHERE sc.score < 80;

-- 40. 查询所有课程分数都高于85分的学生姓名。
SELECT s.name
FROM student s
JOIN score sc ON s.student_id = sc.student_id
GROUP BY s.student_id
HAVING MIN(sc.score) > 85;