# Greeting Card Store Management System  
**Oracle SQL + Python Flask Reporting App**

![Oracle](https://img.shields.io/badge/Database-Oracle%20XE%2021c-red) ![Flask](https://img.shields.io/badge/Backend-Flask-black) ![Docker](https://img.shields.io/badge/Deploy-Docker-blue) ![Python](https://img.shields.io/badge/Python-3.x-yellow)

A database management system for a greeting card store using **Oracle SQL** and **Python Flask**.  
It provides reporting and analytics for orders, templates, material usage, and revenue.

## ✅ Features
- 📦 Customer Orders Report  
- ⭐ Popular Templates Report  
- 🧾 Material Usage Report  
- 💰 Revenue by Template Report  

## 🚀 Local Deployment Guide

### ✅ 1) Start Oracle Database (Docker Recommended)
> Make sure **Docker Desktop** is installed & running.

Run from the project root:
docker-compose up -d

Wait **30–60 seconds** for Oracle to initialize.

Check if the container is running:
docker ps

✅ You should see a container named **oracle-db**.

### ✅ 2) Setup the Flask Application
Create a virtual environment (recommended):
python -m venv venv
venv\Scripts\activate

Install dependencies:
cd python
pip install -r requirements.txt
cd ..

### ✅ 3) Environment Variables (Database Connection)
The app uses environment variables for Oracle connection. Defaults work automatically with Docker.

| Variable | Default | Description |
|---------|---------|-------------|
| ORACLE_HOST | localhost | Database host |
| ORACLE_PORT | 1521 | Database port |
| ORACLE_SID | XE | Oracle SID |
| ORACLE_USER | system | DB username |
| ORACLE_PASSWORD | oracle | DB password |

(Optional) Set custom values (PowerShell):
$env:ORACLE_HOST = "localhost"
$env:ORACLE_PORT = "1521"
$env:ORACLE_SID = "XE"
$env:ORACLE_USER = "system"
$env:ORACLE_PASSWORD = "oracle"

### ✅ 4) Run the Application
From the project root:
python python/app.py

Open in browser:
http://localhost:5000

### ✅ 5) Verify Reports
- 🏠 Home → Home page + greeting card image  
- 📦 Customer Orders → Order summary report  
- ⭐ Popular Templates → Popular templates report  
- 🧾 Material Usage → Supplier material usage report  
- 💰 Revenue by Template → Revenue analysis report  

✅ If reports show data → deployment is successful.

## 🛠 Troubleshooting

### ❗ Stored Procedures Not Recognized / Reports Show No Data
Sometimes the initialization may not fully complete.

Fix: manually run init.sql in the Oracle container:
docker cp sql/init.sql oracle-db:/tmp/init.sql
docker exec oracle-db sqlplus -S system/oracle@XE "@/tmp/init.sql"

Restart Flask:
python python/app.py

## 🛑 Stop / Reset
Stop Flask:
Ctrl + C

Stop Oracle Docker container:
docker-compose down

Reset database (remove volumes/data):
docker-compose down -v
