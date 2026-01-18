import oracledb
import os

# Database connection details from environment variables
dsn = f"{os.getenv('ORACLE_HOST', 'localhost')}:{int(os.getenv('ORACLE_PORT', 1521))}/{os.getenv('ORACLE_SID', 'XE')}"
connection = oracledb.connect(
    user=os.getenv('ORACLE_USER', 'system'),
    password=os.getenv('ORACLE_PASSWORD', 'oracle'),
    dsn=dsn
)

cursor = connection.cursor()

# Check what procedures exist
cursor.execute("""
    SELECT object_name, object_type, status 
    FROM user_objects 
    WHERE object_type = 'PROCEDURE'
    ORDER BY object_name
""")

print("Procedures in database:")
for row in cursor.fetchall():
    print(f"  {row[0]} ({row[1]}) - {row[2]}")

cursor.close()
connection.close()
