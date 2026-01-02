import pymysql

try:
    print("Trying to connect to MySQL using PyMySQL...")

    conn = pymysql.connect(
        host="127.0.0.1",
        user="root",
        password="200359",
        database="retail_sales_analytics",
        port=3306,
        connect_timeout=5
    )

    print("✅ Connected to MySQL successfully (PyMySQL)")
    conn.close()

except Exception as e:
    print("❌ MySQL connection error:")
    print(e)



