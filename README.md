### linux_assignment_HeroVired
# Linux Assignment

# Scripts Run Log

## Task 1 Commands Run

### Step 1: Environment details
```bash
uname -a > outputs/task1/environment.txt
lsb_release -a >> outputs/task1/environment.txt
cat outputs/task1/environment.txt
```

### Step 2: Install monitoring tool
```bash
sudo apt update
sudo apt install -y htop
htop --version
```

### Step 3: Disk usage collection
```bash
df -h > outputs/task1/df_output.txt
cat outputs/task1/df_output.txt

sudo du -sh /home/* > outputs/task1/du_output.txt
cat outputs/task1/du_output.txt
```

### Step 4: Top CPU and memory processes
```bash
ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 15 > outputs/task1/top_cpu.txt
cat outputs/task1/top_cpu.txt

ps -eo pid,user,comm,%cpu,%mem --sort=-%mem | head -n 15 > outputs/task1/top_mem.txt
cat outputs/task1/top_mem.txt
```

### Step 5: Consolidated report
```bash
{
	echo "===== ENV ====="; cat outputs/task1/environment.txt
	echo "===== DF ====="; cat outputs/task1/df_output.txt
	echo "===== DU ====="; cat outputs/task1/du_output.txt
	echo "===== TOP CPU ====="; cat outputs/task1/top_cpu.txt
	echo "===== TOP MEM ====="; cat outputs/task1/top_mem.txt
} > outputs/task1/monitoring_report.txt

echo "Task1 completed" > outputs/task1/status.txt
```

## Task 2 Commands Run

### Step 1: Create users
```bash
id Sarah >/dev/null 2>&1 || sudo useradd -m -s /bin/bash Sarah
id mike >/dev/null 2>&1 || sudo useradd -m -s /bin/bash mike
getent passwd Sarah mike
```

### Step 2: Set secure passwords
```bash
sudo passwd Sarah
sudo passwd mike
```

### Step 3: Create and secure workspaces
```bash
sudo mkdir -p /home/Sarah/workspace /home/mike/workspace
sudo chown -R Sarah:Sarah /home/Sarah
sudo chown -R mike:mike /home/mike
sudo chmod 700 /home/Sarah/workspace /home/mike/workspace
sudo ls -ld /home/Sarah/workspace /home/mike/workspace
```

### Step 4: Password expiry policy
```bash
sudo chage -M 30 Sarah
sudo chage -M 30 mike
sudo chage -l Sarah
sudo chage -l mike
```

### Step 5: Password complexity baseline
```bash
sudo apt install -y libpam-pwquality
sudo sed -i 's/^#\?minlen.*/minlen = 12/' /etc/security/pwquality.conf
sudo sed -i 's/^#\?minclass.*/minclass = 3/' /etc/security/pwquality.conf
grep -E '^(minlen|minclass)' /etc/security/pwquality.conf
```

### Step 6: Consolidated report
```bash
{
	echo "===== USERS ====="; getent passwd Sarah mike
	echo "===== PERMISSIONS ====="; sudo ls -ld /home/Sarah/workspace /home/mike/workspace
	echo "===== CHAGE SARAH ====="; sudo chage -l Sarah
	echo "===== CHAGE MIKE ====="; sudo chage -l mike
	echo "===== PWQUALITY ====="; grep -E '^(minlen|minclass)' /etc/security/pwquality.conf
} > outputs/task2/user_management_report.txt

echo "Task2 completed" > outputs/task2/status.txt
```

## Task 3 Commands Run

### Step 1: Prepare backup and log directories
```bash
sudo mkdir -p /backups /var/log/devops-assignment
sudo chmod 775 /backups /var/log/devops-assignment
```

### Step 2: Script deployment
```bash
chmod +x scripts/backup_apache.sh scripts/backup_nginx.sh
sudo cp scripts/backup_apache.sh /usr/local/bin/backup_apache.sh
sudo cp scripts/backup_nginx.sh /usr/local/bin/backup_nginx.sh
sudo chmod +x /usr/local/bin/backup_apache.sh /usr/local/bin/backup_nginx.sh

cat scripts/backup_apache.sh
cat scripts/backup_nginx.sh
```

### Step 3: Configure cron (Tuesday 12:00 AM)
```bash
sudo bash -c '(crontab -u Sarah -l 2>/dev/null; echo "0 0 * * 2 /usr/local/bin/backup_apache.sh >> /var/log/devops-assignment/apache_backup_cron.log 2>&1") | crontab -u Sarah -'
sudo crontab -u Sarah -l

sudo bash -c '(crontab -u mike -l 2>/dev/null; echo "0 0 * * 2 /usr/local/bin/backup_nginx.sh >> /var/log/devops-assignment/nginx_backup_cron.log 2>&1") | crontab -u mike -'
sudo crontab -u mike -l
```

### Step 4: Run backups manually
```bash
sudo /usr/local/bin/backup_apache.sh
sudo /usr/local/bin/backup_nginx.sh
ls -lh /backups
```

### Step 5: Capture verification logs
```bash
DATE=$(date +%F)
sudo cp /var/log/devops-assignment/apache_verify_${DATE}.log outputs/task3/apache_verify.log
sudo cp /var/log/devops-assignment/nginx_verify_${DATE}.log outputs/task3/nginx_verify.log

cat outputs/task3/apache_verify.log
cat outputs/task3/nginx_verify.log
```

### Step 6: Consolidated report
```bash
{
	echo "===== BACKUPS ====="; ls -lh /backups
	echo "===== CRON SARAH ====="; sudo crontab -u Sarah -l
	echo "===== CRON MIKE ====="; sudo crontab -u mike -l
	echo "===== APACHE VERIFY ====="; cat outputs/task3/apache_verify.log
	echo "===== NGINX VERIFY ====="; cat outputs/task3/nginx_verify.log
} > outputs/task3/backup_report.txt

echo "Task3 completed" > outputs/task3/status.txt
```
