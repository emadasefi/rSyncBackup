rSyncBackup Script (automating backups across multiple servers)
====================================
This Bash script automates the process of backing up files from specified remote servers to designated local directories using rsync. It includes logging capabilities for monitoring the backup operations and handles password authentication using sshpass.
<br><br>

## 🌟 Key Features
<li><strong>Automated Backup:</strong> The script automates the backup process for multiple source servers.</li>
<li><strong>Efficient Transfer:</strong> It uses rsync, which is known for its efficiency in transferring files.</li>
<li><strong>Logging:</strong> The script logs the start and end times of backup operations, as well as any errors encountered.</li>
<li><strong>Archiving:</strong> Previous backups are archived with a timestamp to prevent data loss.</li>
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

