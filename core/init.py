import sqlite3

SUI_PATH = "/usr/local/s-ui/db/s-ui.db"
XUI_PATH = '/etc/x-ui/x-ui.db'

def dvhost_connect_to_xui_db():
    return sqlite3.connect(XUI_PATH)

def dvhost_connect_to_sui_db():
    return sqlite3.connect(SUI_PATH)

def dvhost_transfer_user():
    xui = dvhost_connect_to_xui_db()
    sui = dvhost_connect_to_sui_db()
    cursor.execute("SELECT * FROM users where username = ")


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
