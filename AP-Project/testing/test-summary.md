# Test Summary — AP-Project (one-page)

Overview
--------
This one-page summary accompanies the test pack for AP-Project. It contains test objectives, how to run the small dataset, key test cases and expected outcomes.

How to run (quick)
-------------------
1. Ensure PostgreSQL is running and reachable. Update `config/app.properties` if your DB credentials differ.
2. Apply schemas:
   - `psql -U <user> -d univ_auth -f sql/auth_schema.sql`
   - `psql -U <user> -d univ_erp -f sql/erp_schema.sql`
3. Load test data:
   - `psql -U <user> -d univ_auth -f testing/test_data.sql`
   - `psql -U <user> -d univ_erp -f testing/test_data.sql`
4. Build:
   - Run `compile.bat` in the project root.
5. Start app:
   - From project root: `java -cp "bin;lib\postgresql-42.7.4.jar" edu.univ.erp.Main`
   - Or use the VS Code launch configuration `Launch Main (AP-Project)`.

Key test credentials
--------------------
- Admin: `admin1` / `admin123`
- Instructor: `inst1` / `inst123`
- Student: `stu1` / `student1`

Key test cases (short)
----------------------
- Startup & resources: App launches; `config/app.properties` loads; background image visible.
- Authentication: admin/instructor/student login succeed with test credentials.
- Enrollment: `stu1` can be enrolled in `CS101` and duplicate enrollment is prevented.
- Access control: Student cannot access admin-only functions.
- Change password: User can change password and re-login with new password.

Expected outcomes
-----------------
- All UI actions should not throw unhandled exceptions.
- DB operations (insert/select/update) should succeed for valid actions and return meaningful error messages on failure.

Notes / Troubleshooting
-----------------------
- If the background image doesn't load when using VS Code Run button, ensure the launch configuration `cwd` is the project root or copy `config` and images to the working directory used by VS Code (see prior instructions in repo). I included workspace launch configs to help with this.
- If authentication fails, check `config/app.properties` for `auth.url`, `auth.user`, `auth.password` and ensure the `users_auth` table contains seeded records.

Conclusions
-----------
This test pack provides a minimal dataset and a focused set of functional tests to validate core ERP behaviours. Run the quick steps above to reproduce tests locally; capture any error output and share logs for debugging.
