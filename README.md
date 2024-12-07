rSyncBackup Script (automating backups across multiple servers)
====================================
This Bash script automates the process of backing up files from specified remote servers to designated local directories using rsync. It includes logging capabilities for monitoring the backup operations and handles password authentication using sshpass.
<br><br>

## 🌟 Key Features
<li><strong>Automated Backup:</strong> The script facilitates automatic backups from specified remote servers to designated local directories, eliminating the need for manual intervention.</li>
<li><strong>Efficient Transfer:</strong> Utilizing rsync, the script efficiently transfers files by only copying changed data, which minimizes bandwidth usage and speeds up the process.</li>
<li><strong>Logging Capabilities:</strong> It logs essential information such as the start and end times of backup operations, along with any errors encountered during the process. This ensures that users can monitor and review backup activities effectively.</li>
<li><strong>Archiving Previous Backups:</strong> To prevent data loss, the script archives previous backups with timestamps. This feature allows users to maintain historical versions of their data.</li>
<br><br>

## 🌟 Implementation Details
<li><strong>Prerequisites:</strong> The script requires bash, rsync, and sshpass for password authentication. It is also recommended to set up passwordless SSH access for seamless operation.</li>
<li><strong>Scheduling:</strong> The script can be scheduled to run at regular intervals using a cron job, ensuring that backups are performed consistently without user input.</li>
<li><strong>Error Handling:</strong> While basic logging is included, users are advised to implement additional error handling mechanisms to address potential issues during backup operations.</li>
<li><strong>Usage Scenarios:</strong> The script can be adapted for various use cases, such as backing up web server files, databases, or personal data across different systems.</li>
<li>This automation not only enhances data security by ensuring regular backups but also simplifies the management of backup processes across multiple servers.</li>
<br><br>

## 💡 Configuration Section :
```shell
declare -A SOURCE_SERVERS=(
    ["user@192.168.162.11:22:/backends"]="password11:/mnt/storage/backup/backends-11"
    ["user@192.168.162.12:2223:/etc/nginx"]="password12:/mnt/storage/backup/nginx-12"
)

ARCHIVE_BASE="/mnt/storage/backup/archive"
LOG_DESTINATION="/mnt/storage/backup"
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
```
<br>
<li><strong>Associative Array:</strong> SOURCE_SERVERS holds the mapping of source server details (user, IP, port, and path) to their respective passwords and local backup destinations.</li>
<li><strong>Directories:</strong> ARCHIVE_BASE is where previous backups are stored, and LOG_DESTINATION is where log files are saved.</li>
<li><strong>Current Date:</strong> The current date and time are captured for use in logging and archiving.</li>
<br><br>


## 📜 Conclusion
<li> This Bash script is a robust solution for automating backups across multiple servers while ensuring data integrity through archiving and comprehensive logging. By using tools like <code>rsync</code> and <code>sshpass</code>, it simplifies file transfers while managing passwords securely within a controlled environment. </li>
<br><br>


## — Feedback ❤️—
Please leave a comment if you have any comments, suggestions or problems.

