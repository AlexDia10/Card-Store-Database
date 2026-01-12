# Greeting Card Store Management System

This project implements a database management system for a greeting card store using Oracle SQL and Python.

## Project Structure
- `sql/`: Contains SQL scripts for database creation, population, and stored procedures.
- `python/`: Contains the Python application code.
- `docs/`: For documentation.

## Setup Instructions

### Database (Docker)
1. Install Docker Desktop from https://www.docker.com/products/docker-desktop.
2. Run `docker-compose up` to start the Oracle database.
3. The database will initialize with the scripts in `sql/`.

### Application (Manual Setup)
1. Install Python dependencies: `pip install -r python/requirements.txt` (uses oracledb for Oracle connection, no Instant Client needed for 21c).
2. Update `python/app.py` connection details if needed (host=localhost, port=1521, sid=XE, user=system, password=oracle).
3. Run `python python/app.py` to start the app at http://localhost:5000.

### Manual Setup
1. Install Oracle Database.
2. Run `sql/create_db.sql` to create tables.
3. Run `sql/populate.sql` to insert sample data.
4. Run `sql/procedures.sql` to create stored procedures.
5. In `python/`, install dependencies: `pip install -r requirements.txt`
6. Update connection details in `app.py`.
7. Run `python app.py` to start the application.

For deployment, follow the project requirements.