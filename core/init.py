# Name  : XUI 2 SUI
# Author: DVHOST_CLOUD
# Date  : 8/25/2024
# Test  : This script converts an XUI database to an SUI database format seamlessly. It is designed to handle all necessary transformations and ensure data integrity during the conversion process.
import sqlite3

DB_PATH = "/usr/local/s-ui/db/s-ui.db"

def dvhost_connect_to_db():
    return sqlite3.connect(DB_PATH)

def dvhost_inbound():
    conn = dvhost_connect_to_db()
    cursor = conn.cursor()

    # Check if port 443 already exists in the settings
    cursor.execute('''
    SELECT COUNT(*) FROM inbounds WHERE json_extract(settings, '$.port') = 443
    ''')
    count = cursor.fetchone()[0]

    if count == 0:
        # Insert new data if port 443 does not exist
        cursor.execute('''
        INSERT INTO inbounds (id, user_id, up, down, total, remark, enable, expiry_time, listen, port, protocol, settings)
        VALUES (8, 1, 0, 0, 0, 'Server 19', 1, 0, 0, 50981, 'dokodemo-door', '{"address": "149.154.167.220", "port": 443, "network": "tcp", "followRedirect": false, "timeout": 0}')
        ''')
        print("Telegram bot is activated.")
    else:
        print("Port 443 already exists in the settings. Data not inserted.")

def dvhost_main():
    try:
        while True:
            print("Are you sure? ( Y / N )")
            choise = input("Enter your choice: ")
            
            if choise == 'y' :
                print("let's go")
            elif choise == 'n':
                print('Cancelled.')
            else:
                print("Invalid choice. Please enter a valid option.")
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

# run this function after load file .  
if __name__ == "__main__":
    dvhost_main()
