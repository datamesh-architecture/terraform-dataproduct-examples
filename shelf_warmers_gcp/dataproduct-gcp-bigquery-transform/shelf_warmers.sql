SELECT * FROM <your_table> WHERE available > 0 and updated_at < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)  LIMIT 1000
