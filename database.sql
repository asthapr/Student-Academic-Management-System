DROP DATABASE IF EXISTS student_management;

CREATE DATABASE student_management;

USE student_management;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    branch VARCHAR(30) NOT NULL,
    semester INT NOT NULL
);
CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    faculty_id INT,

    FOREIGN KEY (faculty_id)
    REFERENCES Faculty(faculty_id)
);
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES Courses(course_id)
);
CREATE TABLE Marks (
    student_id INT,
    course_id INT,
    marks INT NOT NULL,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES Courses(course_id)
);
CREATE TABLE Attendance (
    student_id INT,
    course_id INT,
    attendance_percentage DECIMAL(5,2) NOT NULL,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES Courses(course_id)
);
INSERT INTO Faculty
(faculty_name, department, email)
VALUES
('Kalyan Das Sir', 'Computer Science', 'kalyan.das@college.edu'),
('Abhishek Sethy Sir', 'Computer Science', 'abhishek.sethy@college.edu'),
('Swetangi Somyadarshi Maam', 'Computer Science', 'swetangi.somyadarshi@college.edu'),
('Shreeharshadas Maam', 'Computer Science', 'shreeharshadas@college.edu'),
('Tushar Kanta Samal Sir', 'Computer Science', 'tushar.samal@college.edu');

INSERT INTO Courses
(course_name, credits, faculty_id)
VALUES
('Theory of Computation', 4, 1),
('Database Management Systems', 4, 2),
('Internet and Web Technology', 3, 3),
('Operating Systems', 4, 4),
('Soft Computing', 3, 5);
INSERT INTO Students
(first_name, last_name, date_of_birth, email, phone_number, branch, semester)
VALUES
('Astha', 'Pradhan', '2005-05-03', 'astha.pradhan@student.edu', '9000000001', 'CSE', 5),
('Arpita', 'Chand', '2007-02-05', 'arpita.chand@student.edu', '9000000002', 'CSE', 5),
('Lawrencee', 'Sethi', '2006-11-13', 'lawrencee.sethi@student.edu', '9000000003', 'CSE', 5),
('Nath', 'Swaymshree', '2006-11-28', 'nath.swaymshree@student.edu', '9000000004', 'CSE', 5),
('Bhukesh', 'Barik', '2006-10-01', 'bhukesh.barik@student.edu', '9000000005', 'CSE', 5),
('Preeti', 'Priyadarshini', '2006-07-03', 'preeti.priyadarshini@student.edu', '9000000006', 'CSE', 5),
('Harshika', 'Chowhan', '2006-08-15', 'harshika.chowhan@student.edu', '9000000007', 'CSE', 5),
('Priyambada', 'Arya', '2006-06-20', 'priyambada.arya@student.edu', '9000000008', 'CSE', 5),
('Shiwang', 'Jaiswal', '2006-09-10', 'shiwang.jaiswal@student.edu', '9000000009', 'CSE', 5),
('Komrade Colaussus', 'Gowtham', '2006-12-25', 'komrade.gowtham@student.edu', '9000000010', 'CSE', 5);
INSERT INTO Enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2026-07-01'),
(1, 2, '2026-07-01'),
(1, 3, '2026-07-01'),
(1, 4, '2026-07-01'),

(2, 1, '2026-07-01'),
(2, 2, '2026-07-01'),
(2, 5, '2026-07-01'),

(3, 2, '2026-07-01'),
(3, 3, '2026-07-01'),
(3, 4, '2026-07-01'),

(4, 1, '2026-07-01'),
(4, 2, '2026-07-01'),
(4, 4, '2026-07-01'),

(5, 2, '2026-07-01'),
(5, 3, '2026-07-01'),
(5, 5, '2026-07-01'),

(6, 1, '2026-07-01'),
(6, 3, '2026-07-01'),
(6, 4, '2026-07-01'),

(7, 1, '2026-07-01'),
(7, 2, '2026-07-01'),
(7, 5, '2026-07-01'),

(8, 2, '2026-07-01'),
(8, 3, '2026-07-01'),
(8, 4, '2026-07-01'),

(9, 1, '2026-07-01'),
(9, 2, '2026-07-01'),
(9, 4, '2026-07-01'),

(10, 3, '2026-07-01'),
(10, 4, '2026-07-01'),
(10, 5, '2026-07-01');
INSERT INTO Marks
(student_id, course_id, marks)
VALUES
-- Astha
(1, 1, 82),
(1, 2, 91),
(1, 3, 76),
(1, 4, 88),

-- Arpita
(2, 1, 74),
(2, 2, 86),
(2, 5, 92),

-- Lawrencee
(3, 2, 79),
(3, 3, 88),
(3, 4, 81),

-- Nath
(4, 1, 93),
(4, 2, 89),
(4, 4, 95),

-- Bhukesh
(5, 2, 68),
(5, 3, 74),
(5, 5, 81),

-- Preeti
(6, 1, 88),
(6, 3, 91),
(6, 4, 84),

-- Harshika
(7, 1, 96),
(7, 2, 94),
(7, 5, 89),

-- Priyambada
(8, 2, 73),
(8, 3, 82),
(8, 4, 77),

-- Shiwang
(9, 1, 85),
(9, 2, 80),
(9, 4, 87),

-- Gowtham
(10, 3, 69),
(10, 4, 75),
(10, 5, 78);
INSERT INTO Attendance
(student_id, course_id, attendance_percentage)
VALUES
-- Astha
(1, 1, 88.50),
(1, 2, 92.00),
(1, 3, 79.50),
(1, 4, 85.00),

-- Arpita
(2, 1, 76.00),
(2, 2, 89.00),
(2, 5, 94.00),

-- Lawrencee
(3, 2, 82.00),
(3, 3, 91.00),
(3, 4, 86.50),

-- Nath
(4, 1, 95.00),
(4, 2, 93.00),
(4, 4, 96.00),

-- Bhukesh
(5, 2, 71.00),
(5, 3, 68.50),
(5, 5, 79.00),

-- Preeti
(6, 1, 90.00),
(6, 3, 94.00),
(6, 4, 88.00),

-- Harshika
(7, 1, 97.00),
(7, 2, 96.00),
(7, 5, 91.00),

-- Priyambada
(8, 2, 74.00),
(8, 3, 81.00),
(8, 4, 78.50),

-- Shiwang
(9, 1, 86.00),
(9, 2, 83.00),
(9, 4, 89.00),

-- Gowtham
(10, 3, 65.00),
(10, 4, 72.00),
(10, 5, 76.00);

CREATE VIEW student_academic_report AS
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
DELIMITER //

CREATE TRIGGER check_student_delete
BEFORE DELETE ON Students
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Enrollments
        WHERE student_id = OLD.student_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete student with enrollments';
    END IF;
END //

DELIMITER ;
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
START TRANSACTION;

UPDATE Marks
SET marks = 90
WHERE student_id = 1 AND course_id = 1;

UPDATE Attendance
SET attendance_percentage = 90
WHERE student_id = 1 AND course_id = 1;

COMMIT;
START TRANSACTION;

UPDATE Marks
SET marks = 50
WHERE student_id = 1 AND course_id = 1;

ROLLBACK;