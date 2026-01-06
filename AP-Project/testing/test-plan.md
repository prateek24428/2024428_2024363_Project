# Test Plan — AP-Project (University ERP)

Purpose
-------
This test plan defines functional tests for the University ERP desktop application (Java + Swing). It focuses on core authentication, enrollment, role-based access control and resource-loading behaviours described in the project.

Scope
-----
- Verify application starts with expected resources (config, images, JDBC driver).
- Verify authentication flows for Admin / Instructor / Student test accounts.
- Verify basic CRUD flows: create user (admin), change password, enroll student, prevent duplicate enrollments, view catalog and timetable, and record grades.
- Verify access control: students cannot access admin features; instructors cannot perform admin-only actions.

Test environment
----------------
- OS: Windows 10/11 (developer environment)
- Java: JDK 17+ (JDK 24 validated during development)
- PostgreSQL: running locally with two DBs as configured in `config/app.properties` (`univ_auth`, `univ_erp`)
- Repo: `AP-Project` workspace opened in VS Code
- JDBC driver: `lib/postgresql-42.7.4.jar` available on runtime classpath

Prerequisites
-------------
1. PostgreSQL server running and reachable.
2. Databases created and schema applied: run `sql/auth_schema.sql` and `sql/erp_schema.sql`.
3. Load the provided small test dataset: `testing/test_data.sql` (this inserts test users, courses, and sections).
4. Build the project: run `compile.bat` in the project root.
5. Launch the app using the recommended launch configuration (see `.vscode/launch.json`) or run from project root: `java -cp "bin;lib\postgresql-42.7.4.jar" edu.univ.erp.Main`.

Test cases
----------
ID | Test case | Steps | Expected result
---|-----------|-------|----------------
T01 | App startup and resource load | Start app via launch config | App starts; `config/app.properties` loaded; background image displayed; no ClassNotFoundException for JDBC
T02 | Admin login (happy path) | Login with `admin1` / `admin123` | Login succeeds; Admin dashboard opens
T03 | Instructor login | Login with `inst1` / `inst123` | Login succeeds; Instructor dashboard opens
T04 | Student login | Login with `stu1` / `stu1` | Login succeeds; Student dashboard opens
T05 | Invalid login | Wrong password for `admin1` | Login fails with error message; no crash
T06 | Access control | Login as student and attempt admin action (create user) | Action blocked; user sees permission error
T07 | Change password | As `stu1`, change password then re-login with new password | Password change succeeds; new password authenticates; old password rejected
T08 | Enroll student in a section | As Admin or Student (UI flow), enroll `stu1` in section S1 | Enrollment record created; UI reflects enrollment
T09 | Prevent duplicate enrollment | Attempt to enroll the same student in same section again | UI/database prevents duplicate; error shown
T10 | Instructor grade entry | As instructor for section S1, record a grade for `stu1` | Grade saved and visible under student/section

Pass/Fail criteria
------------------
- A test case passes when the actual behaviour matches the expected result without unhandled exceptions.
- Overall acceptance: all critical tests (T01–T06, T08–T09) must pass.

Deliverables
------------
- `testing/test_data.sql` — small dataset to populate DB for the tests.
- `testing/test-plan.md` — this file.
- `testing/test-summary.md` — one-page summary (results and how-to).

Notes
-----
- If running under VS Code, ensure the `Launch Main (AP-Project)` config is selected and that `cwd` points to the project root so `config/app.properties` and images are discovered.
- For any DB connectivity failures, check `config/app.properties` and ensure the Postgres server is running and credentials match.
