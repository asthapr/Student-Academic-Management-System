-- ============================================
-- STUDENT ACADEMIC MANAGEMENT SYSTEM
-- SQL QUERIES & REPORTS
-- ============================================

USE student_management;


-- 1. Complete Academic Report
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    f.faculty_name,
    m.marks,
    a.attendance_percentage
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id
JOIN Faculty f
    ON c.faculty_id = f.faculty_id
JOIN Marks m
    ON s.student_id = m.student_id
    AND c.course_id = m.course_id
JOIN Attendance a
    ON s.student_id = a.student_id
    AND c.course_id = a.course_id;
    -- 2. Number of Students Enrolled in Each Course

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM Courses c
JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_students DESC;
-- 3. Average Marks for Each Course

SELECT
    c.course_name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Courses c
JOIN Marks m
    ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name
ORDER BY average_marks DESC;
-- 4. Students Scoring Above the Overall Average

SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    m.marks
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
JOIN Courses c
    ON m.course_id = c.course_id
WHERE m.marks > (
    SELECT AVG(marks)
    FROM Marks
)
ORDER BY m.marks DESC;
-- 5. Highest Scorer

SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    m.marks
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
JOIN Courses c
    ON m.course_id = c.course_id
WHERE m.marks = (
    SELECT MAX(marks)
    FROM Marks
);
-- 6. Students with Low Attendance

SELECT
    student_name,
    course_name,
    attendance_percentage
FROM student_academic_report
WHERE attendance_percentage < 75
ORDER BY attendance_percentage ASC;
-- 7. Student Performance Categories

SELECT
    student_name,
    ROUND(AVG(marks), 2) AS average_marks,
    CASE
        WHEN AVG(marks) >= 90 THEN 'Excellent'
        WHEN AVG(marks) >= 80 THEN 'Good'
        WHEN AVG(marks) >= 70 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM student_academic_report
GROUP BY student_name
ORDER BY average_marks DESC;
-- 8. Student Ranking by Average Marks

SELECT
    student_name,
    ROUND(AVG(marks), 2) AS average_marks,
    RANK() OVER (ORDER BY AVG(marks) DESC) AS student_rank
FROM student_academic_report
GROUP BY student_name
ORDER BY student_rank;
-- 9. Stored Procedure: Generate Report for a Student

DELIMITER //

CREATE PROCEDURE student_report(IN sid INT)
BEGIN
    SELECT
        student_name,
        course_name,
        faculty_name,
        marks,
        attendance_percentage
    FROM student_academic_report
    WHERE student_id = sid;
END //

DELIMITER ;
-- 10. Trigger: Validate Marks Before Insert

DELIMITER //

CREATE TRIGGER check_marks
BEFORE INSERT ON Marks
FOR EACH ROW
BEGIN
    IF NEW.marks < 0 OR NEW.marks > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks must be between 0 and 100';
    END IF;
END //

DELIMITER ;
-- 11. Trigger: Validate Attendance Before Insert

DELIMITER //

CREATE TRIGGER check_attendance
BEFORE INSERT ON Attendance
FOR EACH ROW
BEGIN
    IF NEW.attendance_percentage < 0
       OR NEW.attendance_percentage > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attendance must be between 0 and 100';
    END IF;
END //

DELIMITER ;
-- 12. Trigger: Validate Marks Before Update

DELIMITER //

CREATE TRIGGER check_marks_update
BEFORE UPDATE ON Marks
FOR EACH ROW
BEGIN
    IF NEW.marks < 0 OR NEW.marks > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks must be between 0 and 100';
    END IF;
END //

DELIMITER ;
-- 13. Trigger: Prevent Deletion of Students with Enrollments

DELIMITER //

CREATE TRIGGER check_student_delete
BEFORE DELETE ON Students
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Enrollments
        WHERE student_id = OLD.student_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete student with enrollments';
    END IF;
END //

DELIMITER ;
-- 14. Trigger: Validate Attendance Before Update

DELIMITER //

CREATE TRIGGER check_attendance_update
BEFORE UPDATE ON Attendance
FOR EACH ROW
BEGIN
    IF NEW.attendance_percentage < 0
       OR NEW.attendance_percentage > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attendance must be between 0 and 100';
    END IF;
END //

DELIMITER ;
-- ============================================
-- 15. TRANSACTIONS
-- ============================================

-- Successful transaction
START TRANSACTION;

UPDATE Marks
SET marks = 90
WHERE student_id = 1 AND course_id = 1;

UPDATE Attendance
SET attendance_percentage = 90
WHERE student_id = 1 AND course_id = 1;

COMMIT;


-- Transaction that is cancelled
START TRANSACTION;

UPDATE Marks
SET marks = 50
WHERE student_id = 1 AND course_id = 1;

ROLLBACK;