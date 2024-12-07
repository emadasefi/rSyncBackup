#!/bin/bash

# Print the ASCII art and message
echo -e "       ____              ___           __           \n  ____/ __/_ _____  ____/ _ )___ _____/ /____ _____ \n / __/\\ \\/ // / _ \\/ __/ _  / _ \`/ __/  '_/ // / _ \\ \n/_/ /___/\\_, /_//_/\\__/____/\\_,_/\\__/_/\\_\\\\_,_/ .__/ \n        /___/                                /_/"
echo "
  - Automated Backup Script Using Bash
  - This Bash script automates the process of backing up files from specified source servers to designated local directories. 
    It utilizes rsync for efficient file transfer and includes logging for monitoring the backup operations.
  - v1.1 / Emad Asefi  / @emadasefi / emad.asefi@gmail.com
________________________________________________________________
"

# Configuration
declare -A SOURCE_SERVERS=(
    ["user@192.168.162.11:22:/backends"]="password11:/mnt/storage/backup/backends-11"
    ["user@192.168.162.12:2223:/etc/nginx"]="password12:/mnt/storage/backup/nginx-12"
)

ARCHIVE_BASE="/mnt/storage/backup/archive"
LOG_DESTINATION="/mnt/storage/backup"
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Create archive base directory if it doesn't exist
mkdir -p "$ARCHIVE_BASE"

# Loop through each source server and directory
for SOURCE in "${!SOURCE_SERVERS[@]}"; do
    # Extract password and destination from the associative array
    IFS=':' read -r PASSWORD DESTINATION <<< "${SOURCE_SERVERS[$SOURCE]}"
    
    # Extract the SSH user, IP, port, and source path
    IFS='@:' read -r USER_IP PORT SOURCE_PATH <<< "$SOURCE"
    
    # Extract the directory name from the source path for archiving
    DIR_NAME=$(basename "$SOURCE_PATH")
    
    # Create the destination directory if it doesn't exist
    mkdir -p "$DESTINATION"
    
    # Move previous files to the archive with the current date
    if [ -d "$DESTINATION/$DIR_NAME" ]; then
        mv "$DESTINATION/$DIR_NAME" "$ARCHIVE_BASE/$DIR_NAME-$CURRENT_DATE"
    fi
	
	# Start Date rsync
	START_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
	
    # Perform the backup using rsync with sshpass for password handling
    sshpass -p "$PASSWORD" rsync -ahP -e "ssh -o ConnectTimeout=10 -p $PORT" "$USER_IP:$SOURCE_PATH" "$DESTINATION/$DIR_NAME/"
	
	# End Date rsync
	END_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
	
    # Log the backup operation
	if [ -d "$DESTINATION/$DIR_NAME" ]; then
		echo "${START_DATE}	|	INFO	|	Start Job [${DIR_NAME}] from [${SOURCE}] =>" >> "${LOG_DESTINATION}/execute.log"
		echo "${CURRENT_DATE}	|	INFO	|	Backup [${DIR_NAME}] from [${SOURCE}] taken on" >> "${LOG_DESTINATION}/execute.log"
		echo "${END_DATE}	|	INFO	|	Finish Job [${DIR_NAME}] from [${SOURCE}] =>" >> "${LOG_DESTINATION}/execute.log"
		echo "============================================================================================" >> "${LOG_DESTINATION}/execute.log"
	else 
		echo "${START_DATE}	|	ERROR	|	Start Job [${DIR_NAME}] from [${SOURCE}] =>" >> "${LOG_DESTINATION}/execute.log"
		echo "${END_DATE}	|	ERROR	|	Backup [${DIR_NAME}] from [${SOURCE}] Errored" >> "${LOG_DESTINATION}/execute.log"
		echo "${END_DATE}	|	ERROR	|	Finish Errored Job [${DIR_NAME}] from [${SOURCE}] =>" >> "${LOG_DESTINATION}/execute.log"
		echo "============================================================================================" >> "${LOG_DESTINATION}/execute.log"
	fi

done

echo "Backup completed successfully."
