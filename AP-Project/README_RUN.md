# AP-Project — How to run (Development)

This document explains how to build and run the AP-Project (desktop Java Swing ERP) on Windows (PowerShell), and includes default test credentials and DB setup commands.

Important: the application expects `config/app.properties` to exist in the project root `config/` directory (the runtime working directory should be the project root). The JDBC driver JAR must be available under `lib/` (the project includes `lib/postgresql-42.7.4.jar`).

Prerequisites
- Java JDK 17+ (the project was tested with JDK 24). Ensure `javac` and `java` are on your PATH.
- PostgreSQL server accessible from your machine and `psql` client available.
- PowerShell (instructions below use PowerShell syntax).

Quick build & run (recommended)
1. Open PowerShell and change to the project root (where `compile.bat` is located):

```powershell
cd C:\Users\prate\OneDrive\Desktop\ERP\AP-Project
```

2. Compile the project (this copies `config/` and `lib/*.jar` into `bin/` when using the provided `compile.bat`):

```powershell
.\compile.bat
```

3. Run the application (from project root). Include `bin` and the `bin/lib/*` jars on the classpath:

```powershell
java -cp "bin;bin/lib/*" edu.univ.erp.Main
```

Notes for VS Code Run button
- Set the launch configuration `cwd` to the project root (the folder containing `config/app.properties`).
- Make sure the runtime classpath includes `bin` and `lib/*` (or `bin/lib/*`). If using the Java extension, add `bin` and `lib/*.jar` to the referenced libraries in `.vscode/settings.json`.

Database setup (example)
1. Create two databases (names used by the default config examples): `univ_auth` and `univ_erp` and load schema + seed data.

Run these commands in PowerShell (adjust `-U` user and host as needed):

```powershell
# create DBs (run as a user with create DB permissions)
psql -U postgres -c "CREATE DATABASE univ_auth;"
psql -U postgres -c "CREATE DATABASE univ_erp;"

# load schemas and seed data
psql -U postgres -d univ_auth -f sql/auth_schema.sql
psql -U postgres -d univ_auth -f sql/auth_seed.sql
psql -U postgres -d univ_erp -f sql/erp_schema.sql
psql -U postgres -d univ_erp -f sql/erp_seed.sql
```

Configuration (`config/app.properties`)
Place a `config/app.properties` file under `config/` (project root). Example contents (edit usernames/passwords/hosts if needed):

```properties
auth.url=jdbc:postgresql://localhost:5432/univ_auth
auth.user=postgres
auth.password=postgres

erp.url=jdbc:postgresql://localhost:5432/univ_erp
erp.user=postgres
erp.password=postgres
```

Default application credentials (seeded)
- Admin: `username=admin1` / `password=admin123`
- Instructor: `username=inst5` / `password=inst1234`
- Student 1: `username=stu1` / `password=student1`
- Student 2: `username=stu3` / `password=student3`

Troubleshooting
- ClassNotFoundException: org.postgresql.Driver — Ensure the JDBC jar exists in `lib/` and has been copied into `bin/lib/` (re-run `compile.bat` or add the jar to classpath).
- Could not read `config/app.properties` — confirm `cwd` is project root or that `config/app.properties` exists at `./config/app.properties` relative to where you run `java`.
- Background image not loaded — the application looks for image files in the workspace; ensure the image referenced by the UI is present in the expected path or copy it into `bin/`.

Advanced run command (explicit classpath with full jars)
If you prefer to include the jar explicitly:

```powershell
java -cp "bin;lib/postgresql-42.7.4.jar" edu.univ.erp.Main
```

How to run tests / seed data quickly
- The SQL files in `sql/` contain schema and seed data. Use the `psql` commands above to reset and seed the DBs.
- A small test pack is included under `testing/` with manual test cases.

Committing these runtime changes
- If you want me to commit the added `.vscode` launch settings, `compile.bat` edits, or `docs/short-report.md` and this README to git, tell me which files you want included and I will create a branch and commit them.

If anything fails, paste the exact error text and I will help debug.
