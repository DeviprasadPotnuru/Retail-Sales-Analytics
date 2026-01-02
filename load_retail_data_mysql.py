import pandas as pd
import pymysql
import numpy as np

# =====================================================
# CONFIG
# =====================================================
CSV_PATH = "data/processed/retail_orders_cleaned.csv"
BATCH_SIZE = 500

DB_CONFIG = {
    "host": "127.0.0.1",
    "user": "root",
    "password": "200359",
    "database": "retail_sales_analytics",
    "port": 3306,
    "connect_timeout": 5
}

# =====================================================
# LOAD DATA
# =====================================================
print("📥 Reading cleaned retail data...")
df = pd.read_csv(CSV_PATH)

print(f"Total rows in CSV: {len(df)}")

# =====================================================
# 🔴 CRITICAL FIX: HANDLE NaN PROPERLY
# =====================================================
# Convert NaN / NaT / inf to None (MySQL NULL)
df = df.replace({np.nan: None, np.inf: None, -np.inf: None})

print("✅ NaN values converted to NULL")

# =====================================================
# MYSQL CONNECTION
# =====================================================
print("🔌 Connecting to MySQL...")
conn = pymysql.connect(**DB_CONFIG)
cursor = conn.cursor()

# =====================================================
# INSERT QUERY
# =====================================================
insert_query = """
INSERT INTO retail_orders (
    order_id, order_date, order_year, order_month, order_month_name,
    ship_mode, segment, country, city, state, postal_code, region,
    category, sub_category, product_id,
    quantity, list_price, discount_percent, selling_price,
    sales, total_cost, profit, profit_margin_pct
)
VALUES (
    %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s,
    %s, %s, %s, %s,
    %s, %s, %s, %s
)
"""

# =====================================================
# BATCH INSERT (SAFE & STABLE)
# =====================================================
rows = df.values.tolist()
total_rows = len(rows)

print("🚀 Starting batch insert into MySQL...")

for i in range(0, total_rows, BATCH_SIZE):
    batch = rows[i:i + BATCH_SIZE]
    cursor.executemany(insert_query, batch)
    conn.commit()
    print(f"Inserted rows {i + 1} to {i + len(batch)}")

# =====================================================
# CLEANUP
# =====================================================
cursor.close()
conn.close()

print("✅ DATA LOAD COMPLETED SUCCESSFULLY")

