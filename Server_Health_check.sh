#!/bin/bash
# Script to generate a comprehensive server health report
#AUTHOR : KARRI JAGAPATHI BABU 

# Output file

REPORT="/tmp/server_health_report_$(date +%F_%T).txt"

echo "==== Server Health Report - $(hostname) ====" > "$REPORT"
echo "Generated on: $(date)" >> "$REPORT"
echo "-------------------------------------------" >> "$REPORT"

# Uptime
echo -e "\n>> UPTIME:" >> "$REPORT"
uptime >> "$REPORT"

# Load Average
echo -e "\n>> LOAD AVERAGE:" >> "$REPORT"
cat /proc/loadavg >> "$REPORT"

# Memory Usage
echo -e "\n>> MEMORY USAGE:" >> "$REPORT"
free -h >> "$REPORT"


# Disk Usage
echo -e "\n>> DISK USAGE:" >> "$REPORT"
df -h --output=source,fstype,size,used,avail,pcent,target >> "$REPORT"

# Top 5 Memory Consuming Processes
echo -e "\n>> TOP 5 MEMORY CONSUMING PROCESSES:" >> "$REPORT"
ps aux --sort=-%mem | head -n 6 >> "$REPORT"

# Top 5 CPU Consuming Processes
echo -e "\n>> TOP 5 CPU CONSUMING PROCESSES:" >> "$REPORT"
ps aux --sort=-%cpu | head -n 6 >> "$REPORT"

# Network Interfaces
echo -e "\n>> NETWORK INTERFACES & IP ADDRESSES:" >> "$REPORT"
ip -brief addr show >> "$REPORT"

# DNS Resolution
echo -e "\n>> DNS RESOLUTION CHECK:" >> "$REPORT"
nslookup google.com >> "$REPORT" 2>&1



# Users currently logged in
echo -e "\n>> LOGGED-IN USERS:" >> "$REPORT"
whoami >> "$REPORT"

echo -e "\nHealth check report generated at: $REPORT"
