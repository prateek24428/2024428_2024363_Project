-- Small test dataset for AP-Project (University ERP)
-- Run after applying schema: sql/auth_schema.sql and sql/erp_schema.sql

-- Seed authentication table (re-uses demo hashes from auth_seed.sql)
TRUNCATE users_auth RESTART IDENTITY;
INSERT INTO users_auth (user_id, username, role, password_hash, status) VALUES
  (1, 'admin1', 'ADMIN', 'PBKDF2$120000$CazttQGbhur42Flh039EdQ==$MPPrIKCMW2risYe4vNggO9CSvdjSmwD67YZw4CPH4cw=', 'ACTIVE'),
  (3, 'inst1', 'INSTRUCTOR', 'PBKDF2$120000$BHtkyMDp9RbIJtpgwhzJkQ==$CV93YdUgZttBe0scgAjuLDgfRh0HWiN8kkr8Jn8boJU=', 'ACTIVE'),
  (4, 'stu1', 'STUDENT', 'PBKDF2$120000$Z5RPBbNS07GaUfNmvsn+UQ==$cjTyB4PbVdW9sPzaqxGAQ/QcUOEbzdHfdJdweWc97sM=', 'ACTIVE'),
  (5, 'stu2', 'STUDENT', 'PBKDF2$120000$Lk/nIf53sd9peBECdPh91w==$rxmdvnzLyLB/wk1P9tUz5aFG/GyKjgfuw24iuxFptuY=', 'ACTIVE');

-- Seed ERP tables: students, instructors, courses, sections
TRUNCATE students RESTART IDENTITY CASCADE;
TRUNCATE instructors RESTART IDENTITY CASCADE;
TRUNCATE courses RESTART IDENTITY CASCADE;
TRUNCATE sections RESTART IDENTITY CASCADE;
TRUNCATE enrollments RESTART IDENTITY CASCADE;

-- students (user_id must match users_auth.user_id for students)
INSERT INTO students (user_id, roll_no, program, year) VALUES
  (4, 'S2025001', 'BSc Computer Science', 2),
  (5, 'S2025002', 'BSc Mathematics', 1);

-- instructors
INSERT INTO instructors (user_id, department) VALUES
  (3, 'Computer Science');

-- courses
INSERT INTO courses (code, title, credits) VALUES
  ('CS101', 'Intro to Computer Science', 3),
  ('MA101', 'Calculus I', 3);

-- sections (assign instructor to CS101)
INSERT INTO sections (course_id, instructor_user_id, day_time, room, capacity, semester, year)
SELECT c.course_id, CASE WHEN c.code = 'CS101' THEN 3 ELSE NULL END, 'Mon 10:00-12:00', 'R101', 30, 'Fall', 2025
FROM courses c;

-- create a sample enrollment (will be used by enrollment tests)
-- find the section id for CS101
INSERT INTO enrollments (student_user_id, section_id)
SELECT 4, s.section_id FROM sections s JOIN courses c ON s.course_id = c.course_id WHERE c.code = 'CS101' LIMIT 1;

-- Test data ready
