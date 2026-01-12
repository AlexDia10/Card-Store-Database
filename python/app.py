import oracledb
import os
from flask import Flask, render_template

app = Flask(__name__)

# Database connection details from environment variables
dsn = f"{os.getenv('ORACLE_HOST', 'localhost')}:{int(os.getenv('ORACLE_PORT', 1521))}/{os.getenv('ORACLE_SID', 'XE')}"
connection = oracledb.connect(
    user=os.getenv('ORACLE_USER', 'system'),
    password=os.getenv('ORACLE_PASSWORD', 'oracle'),
    dsn=dsn
)

@app.route('/')
def home():
    return render_template('base.html')

@app.route('/report1')
def report1():
    try:
        cursor = connection.cursor()
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc('GET_CUSTOMER_ORDER_SUMMARY', [ref_cursor])
        result_cursor = ref_cursor.getvalue()
        columns = [desc[0] for desc in result_cursor.description]
        data = result_cursor.fetchall()
        return render_template('report.html', 
                             title='Customer Order Summary',
                             columns=columns,
                             data=data)
    except Exception as e:
        return f"Error: {str(e)}", 500

@app.route('/report2')
def report2():
    try:
        cursor = connection.cursor()
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc('GET_POPULAR_TEMPLATES', [ref_cursor])
        result_cursor = ref_cursor.getvalue()
        columns = [desc[0] for desc in result_cursor.description]
        data = result_cursor.fetchall()
        return render_template('report.html',
                             title='Popular Card Templates',
                             columns=columns,
                             data=data)
    except Exception as e:
        return f"Error: {str(e)}", 500

@app.route('/report3')
def report3():
    try:
        cursor = connection.cursor()
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc('GET_SUPPLIER_MATERIAL_USAGE', [ref_cursor])
        result_cursor = ref_cursor.getvalue()
        columns = [desc[0] for desc in result_cursor.description]
        data = result_cursor.fetchall()
        return render_template('report.html',
                             title='Supplier Material Usage',
                             columns=columns,
                             data=data)
    except Exception as e:
        return f"Error: {str(e)}", 500

@app.route('/report4')
def report4():
    try:
        cursor = connection.cursor()
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc('GET_REVENUE_BY_TEMPLATE', [ref_cursor])
        result_cursor = ref_cursor.getvalue()
        columns = [desc[0] for desc in result_cursor.description]
        data = result_cursor.fetchall()
        return render_template('report.html',
                             title='Revenue by Template',
                             columns=columns,
                             data=data)
    except Exception as e:
        return f"Error: {str(e)}", 500

if __name__ == '__main__':
    app.run(debug=True)