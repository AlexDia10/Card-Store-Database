================================================================================
GREETING CARD STORE MANAGEMENT SYSTEM - LOCAL DEPLOYMENT GUIDE
================================================================================

PROJECT OVERVIEW:
A database management system for a greeting card store using Oracle SQL and 
Python Flask. Provides reporting and analytics for customer orders, popular 
templates, material usage, and revenue analysis.

================================================================================
PROJECT STRUCTURE:
================================================================================
Proiect/
├── python/              # Python Flask application
│   ├── app.py          # Main Flask application
│   ├── requirements.txt # Python dependencies
│   └── templates/      # Jinja2 HTML templates
│       ├── base.html   # Base template with navigation
│       └── report.html # Report display template
├── sql/                # Database scripts
│   └── init.sql        # Complete schema, data, and procedures
├── images/             # Static image assets
├── docker-compose.yml  # Docker configuration
├── README.md           # Technical documentation
└── README.txt          # This file

================================================================================
LOCAL DEPLOYMENT STEPS:
================================================================================

STEP 1: SETUP DATABASE WITH DOCKER (RECOMMENDED)
-----------------------------------------------
1. Install Docker Desktop if not already installed.
2. Open PowerShell/Terminal in the project root directory.
3. Run the following command to start Oracle Database:
   
   docker-compose up -d

   This will:
   - Pull the Oracle XE 21c image
   - Create a container named 'oracle-db'
   - Initialize the database with init.sql
   - Expose Oracle on localhost:1521

4. Wait 30-60 seconds for the database to fully initialize.

5. Verify the database is running:
   
   docker ps
   
   You should see 'oracle-db' in the list.

STEP 2: SETUP PYTHON APPLICATION
---------------------------------
1. Open PowerShell/Terminal in the project root directory.

2. Create a Python virtual environment (optional but recommended):
   
   python -m venv venv
   venv\Scripts\activate

3. Install Python dependencies:
   
   cd python
   pip install -r requirements.txt

4. Return to project root:
   
   cd ..

STEP 3: CONFIGURE APPLICATION
------------------------------
The application uses environment variables for database connection.
Default values should work with Docker setup:

Environment Variable | Default Value | Description
--------------------|---------------|------------------
ORACLE_HOST         | localhost     | Database host
ORACLE_PORT         | 1521          | Database port
ORACLE_SID          | XE            | Database SID
ORACLE_USER         | system        | Database user
ORACLE_PASSWORD     | oracle        | Database password

If you need custom values, set them in PowerShell:
   
   $env:ORACLE_HOST = "your_host"
   $env:ORACLE_PORT = "1521"
   $env:ORACLE_SID = "XE"
   $env:ORACLE_USER = "system"
   $env:ORACLE_PASSWORD = "oracle"

STEP 4: RUN THE APPLICATION
----------------------------
1. In PowerShell/Terminal, from the project root directory:
   
   python python/app.py

2. The application will start at:
   
   http://localhost:5000

3. Open your browser and navigate to http://localhost:5000

4. You should see the "Timeless Greetings" home page with report links.

STEP 5: VERIFY FUNCTIONALITY
----------------------------
1. Click on "Home" - should display the home page with greeting card image
2. Click on "Customer Orders" - should display customer order summary report
3. Click on "Popular Templates" - should display popular card templates
4. Click on "Material Usage" - should display supplier material usage report
5. Click on "Revenue by Template" - should display revenue analysis

If reports show data, the deployment is successful!

================================================================================
TROUBLESHOOTING:
================================================================================

ISSUE: Stored Procedures Not Recognized / Reports Show No Data
SOLUTION:
- The database initialization may not have completed properly
- Run the following commands to manually execute the init script:
  
  docker cp sql/init.sql oracle-db:/tmp/init.sql
  docker exec oracle-db sqlplus -S system/oracle@XE "@/tmp/init.sql"

- This will:
  1. Copy init.sql to the container
  2. Execute it using SQLPlus within the container
  3. Create all tables, sequences, data, and stored procedures

- After execution, restart the Flask application:
  
  python python/app.py

- Verify the reports now display data correctly

================================================================================
STOPPING THE APPLICATION:
================================================================================

To stop Flask application:
   Press Ctrl+C in the terminal

To stop Docker database:
   docker-compose down

To stop Docker and remove data (reset database):
   docker-compose down -v
