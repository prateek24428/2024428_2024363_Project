# University ERP System

A comprehensive Enterprise Resource Planning (ERP) system for universities built with Java Swing, featuring role-based access control, course management, and student information system capabilities.

![Java](https://img.shields.io/badge/Java-17+-blue.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-336791.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📋 Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Default Credentials](#default-credentials)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### 🔐 Authentication & Security
- Secure password hashing using PBKDF2 with salt
- Session management and timeout handling
- Role-based access control (Admin, Instructor, Student)
- Login attempt tracking and account lockout protection
- Password change functionality

### 👨‍💼 Admin Dashboard
- User management (create, update, delete users)
- Course catalog management
- System-wide maintenance mode control
- Data backup and restore capabilities
- Administrative cleanup tasks
- Session monitoring

### 👨‍🏫 Instructor Features
- View assigned courses and sections
- Manage course enrollment
- Grade management and submission
- View student rosters
- Course schedule overview

### 👨‍🎓 Student Features
- View enrolled courses
- Check grades and GPA
- Interactive timetable visualization
- Course registration
- Personal profile management
- Change password

### 🗄️ Database Management
- Dual database architecture (Auth & ERP)
- Automated backup system
- SQL schema versioning
- Seed data for testing

## 🖼️ Screenshots

> Add screenshots of your application here to showcase the UI

## 📦 Prerequisites

Before running this application, ensure you have the following installed:

- **Java Development Kit (JDK) 17 or higher**
  - Verify installation: `java -version`
  - Download from: [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://openjdk.org/)

- **PostgreSQL 13 or higher**
  - Verify installation: `psql --version`
  - Download from: [PostgreSQL Official Site](https://www.postgresql.org/download/)
  - Ensure the PostgreSQL service is running

- **Git** (for cloning the repository)
  - Download from: [Git Official Site](https://git-scm.com/)

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/university-erp-system.git
cd university-erp-system/AP-Project
```

### 2. Verify Project Structure

Ensure the following directories exist:
- `src/` - Source code
- `lib/` - PostgreSQL JDBC driver (postgresql-42.7.4.jar)
- `config/` - Configuration files
- `sql/` - Database schema and seed files

### 3. Configure Database Connection

Edit `config/app.properties` with your PostgreSQL credentials:

```properties
# PostgreSQL JDBC configs
auth.url=jdbc:postgresql://localhost:5432/univ_auth
auth.user=your_postgres_username
auth.password=your_postgres_password

erp.url=jdbc:postgresql://localhost:5432/univ_erp
erp.user=your_postgres_username
erp.password=your_postgres_password

# App settings
app.title=University ERP (Java + Swing)
```

## 🗄️ Database Setup

### Windows (PowerShell)

```powershell
# 1. Create databases
psql -U postgres -c "CREATE DATABASE univ_auth;"
psql -U postgres -c "CREATE DATABASE univ_erp;"

# 2. Load schemas
psql -U postgres -d univ_auth -f sql/auth_schema.sql
psql -U postgres -d univ_erp -f sql/erp_schema.sql

# 3. Load seed data (test data with default users)
psql -U postgres -d univ_auth -f sql/auth_seed.sql
psql -U postgres -d univ_erp -f sql/erp_seed.sql
```

### Linux/Mac (Bash)

```bash
# 1. Create databases
psql -U postgres -c "CREATE DATABASE univ_auth;"
psql -U postgres -c "CREATE DATABASE univ_erp;"

# 2. Load schemas
psql -U postgres -d univ_auth -f sql/auth_schema.sql
psql -U postgres -d univ_erp -f sql/erp_schema.sql

# 3. Load seed data
psql -U postgres -d univ_auth -f sql/auth_seed.sql
psql -U postgres -d univ_erp -f sql/erp_seed.sql
```

## ▶️ Running the Application

### Method 1: Using Compile Script (Recommended)

#### Windows
```powershell
# Compile
.\compile.bat

# Run
java -cp "bin;bin/lib/*" edu.univ.erp.Main
```

#### Linux/Mac
```bash
# Compile
chmod +x compile.sh
./compile.sh

# Run
java -cp "bin:bin/lib/*" edu.univ.erp.Main
```

### Method 2: Manual Compilation

```bash
# Create bin directory
mkdir -p bin

# Copy resources
cp -r config bin/
cp -r lib bin/

# Compile
javac -d bin -cp "lib/*" src/edu/univ/erp/**/*.java

# Run
java -cp "bin:bin/lib/*" edu.univ.erp.Main
```

### Method 3: Using IDE (VS Code, IntelliJ, Eclipse)

1. Import project as Java project
2. Add `lib/postgresql-42.7.4.jar` to build path
3. Set working directory to project root
4. Run `edu.univ.erp.Main` class

## 🔑 Default Credentials

The system comes with pre-configured test accounts:

| Role | Username | Password |
|------|----------|----------|
| Admin | `admin1` | `admin123` |
| Instructor | `inst1` | `inst123` |
| Student | `stu1` | `student1` |
| Student | `stu2` | `student2` |

⚠️ **Security Notice**: Change these default credentials in a production environment!

## 📁 Project Structure

```
AP-Project/
├── src/                          # Source code
│   └── edu/univ/erp/
│       ├── Main.java            # Application entry point
│       ├── access/              # Access control logic
│       ├── auth/                # Authentication services
│       ├── data/                # Database access layer
│       ├── domain/              # Domain models (Student, Course, etc.)
│       ├── service/             # Business logic services
│       ├── ui/                  # User interface components
│       │   ├── admin/           # Admin dashboard
│       │   ├── auth/            # Login screens
│       │   ├── instructor/      # Instructor dashboard
│       │   └── student/         # Student dashboard
│       └── util/                # Utility classes
├── sql/                         # Database scripts
│   ├── auth_schema.sql          # Authentication database schema
│   ├── auth_seed.sql            # Auth seed data
│   ├── erp_schema.sql           # ERP database schema
│   └── erp_seed.sql             # ERP seed data
├── config/                      # Configuration files
│   └── app.properties           # Database and app settings
├── lib/                         # External libraries
│   └── postgresql-42.7.4.jar    # PostgreSQL JDBC driver
├── bin/                         # Compiled classes (generated)
├── backups/                     # Database backups (generated)
├── compile.bat                  # Windows compilation script
├── compile.sh                   # Unix compilation script
└── README.md                    # This file
```

## ⚙️ Configuration

### Application Properties

The `config/app.properties` file contains all configuration settings:

```properties
# Authentication Database
auth.url=jdbc:postgresql://localhost:5432/univ_auth
auth.user=postgres
auth.password=your_password

# ERP Database
erp.url=jdbc:postgresql://localhost:5432/univ_erp
erp.user=postgres
erp.password=your_password

# Application Settings
app.title=University ERP (Java + Swing)
```

### Database Architecture

The system uses a dual-database architecture:

1. **univ_auth** - Authentication & Authorization
   - User credentials and roles
   - Session management
   - Login attempt tracking

2. **univ_erp** - Core ERP Data
   - Students, Instructors, Courses
   - Enrollments and Grades
   - Sections and Schedules

## 🧪 Testing

Test credentials and sample data are provided in:
- `sql/auth_seed.sql` - User accounts
- `sql/erp_seed.sql` - Sample courses and enrollments
- `testing/test_data.sql` - Additional test scenarios

For detailed test plans, see:
- `testing/test-plan.md`
- `testing/test-summary.md`

## 🛠️ Development

### Key Technologies
- **Language**: Java 17+
- **GUI Framework**: Swing
- **Database**: PostgreSQL
- **Security**: PBKDF2 password hashing
- **JDBC Driver**: PostgreSQL 42.7.4

### Utility Tools

The project includes several utility tools:

- `HashGen.java` - Generate password hashes
- `GenerateAuthHash.java` - Authentication hash generator
- `PasswordDebug.java` - Password debugging tools
- `BackupService.java` - Database backup functionality

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Coding Standards
- Follow Java naming conventions
- Add JavaDoc comments for public methods
- Write unit tests for new features
- Keep methods focused and concise

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

Project Maintainers:
- Student ID: 2024428, 2024363

For questions or support, please open an issue on GitHub.

## 🙏 Acknowledgments

- PostgreSQL JDBC Driver
- Java Swing Framework
- University course project inspiration

---

**Note**: This is an educational project developed as part of a university course. It is not intended for production use without proper security hardening and testing.
