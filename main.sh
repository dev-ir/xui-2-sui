#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
plain='\033[0m'
NC='\033[0m' # No Color

# [[ $EUID -ne 0 ]] && echo -e "${RED}Fatal error: ${plain} Please run this script with root privilege \n " && exit 1

install_jq() {
    if ! command -v jq &> /dev/null; then
        # Check if the system is using apt package manager
        if command -v apt-get &> /dev/null; then
            echo -e "${RED}jq is not installed. Installing...${NC}"
            sleep 1
            sudo apt-get update
            sudo apt-get install -y jq
        else
            echo -e "${RED}Error: Unsupported package manager. Please install jq manually.${NC}\n"
            read -p "Press any key to continue..."
            exit 1
        fi
    fi
}

require_command(){
    
    apt update -y && apt upgrade -y
    install_jq
    if ! command -v pv &> /dev/null
    then
        echo "pv could not be found, installing it..."
        sudo apt update
        sudo apt install -y pv
    fi
}


menu(){
    clear
    # Get server IP
    SERVER_IP=$(hostname -I | awk '{print $1}')
    
    # Fetch server country using ip-api.com
    SERVER_COUNTRY=$(curl -sS "http://ip-api.com/json/$SERVER_IP" | jq -r '.country')
    
    # Fetch server isp using ip-api.com
    SERVER_ISP=$(curl -sS "http://ip-api.com/json/$SERVER_IP" | jq -r '.isp')
    
    SUI_CORE=$(check_sui_exist)
    
    echo "+---------------------------------------------------------------------------+"                                                                                                
    echo "| __   __ _    _  _____     ___       _____  _    _  _____                  |"
    echo "| \ \ / /| |  | ||_   _|   |__ \     / ____|| |  | ||_   _|                 |"
    echo "|  \ V / | |  | |  | |        ) |   | (___  | |  | |  | |    TG CHANNEL     |"
    echo "|   > <  | |  | |  | |       / /     \___ \ | |  | |  | |    @DVHOST_CLOUD  |"
    echo "|  / . \ | |__| | _| |_     / /_     ____) || |__| | _| |_     ( 0.0.1 )    |"
    echo "| /_/ \_\ \____/ |_____|   |____|   |_____/  \____/ |_____|                 |"
    echo "+---------------------------------------------------------------------------+"                                                                                                
    echo -e "|Telegram Channel : ${GREEN}@DVHOST_CLOUD ${NC}|YouTube : ${RED}youtube.com/@dvhost_cloud${NC}  "
    echo "+---------------------------------------------------------------------------+"                                                                                                
    echo -e "|${GREEN}Server Country    |${NC} $SERVER_COUNTRY"
    echo -e "|${GREEN}Server IP         |${NC} $SERVER_IP"
    echo -e "|${GREEN}Server ISP        |${NC} $SERVER_ISP"
    echo -e "|${GREEN}Server SUI        |${NC} $SUI_CORE"
    echo "+---------------------------------------------------------------------------+"                                                                                                
    echo -e "|${YELLOW}Please choose an option:${NC}"
    echo "+---------------------------------------------------------------------------+"                                                                                                
    echo -e $1
    echo "+---------------------------------------------------------------------------+"                                                                                                
    echo -e "\033[0m"
}

loader(){
    
    menu "| 1  - Import X-UI To S-UI \n| 2  - Backup/Restore Database \n| 0  - Exit"
    
    read -p "|Enter option number: " choice
    case $choice in
        1)
            transfer_db
        ;;
        2)
            gift_user
        ;;
        3)
            manage_user
        ;;
        0)
            echo -e "${GREEN}Exiting program...${NC}"
            exit 0
        ;;
        *)
            echo "Not valid"
        ;;
    esac
    
}

check_sui_exist() {
    local file_path="/usr/local/s-ui/db/s-ui.db"
    local status
    
    if [ -f "$file_path" ]; then
        status="${GREEN}Installed"${NC}
    else
        status=${RED}"Not installed"${NC}
    fi
    
    echo "$status"
}

require_command
loader