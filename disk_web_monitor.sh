#!/bin/bash

echo "===== SYSTEM MONITOR ====="
echo ""

# -------- DISK USAGE CHECK --------
threshold=80
disk=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "Disk Usage Check:"
if [ $disk -gt $threshold ]; then
    echo "⚠️  WARNING: Disk usage is ${disk}%"
else
    echo "✅ Disk usage is ${disk}%"
fi

echo ""
echo "--------------------------"
echo ""

# -------- WEBSITE UPTIME CHECK --------
sites=("google.com" "github.com" "example.com")

echo "Website Uptime Check:"
for site in "${sites[@]}"; do
    ping -c 1 $site &> /dev/null

    if [ $? -eq 0 ]; then
        echo "✅ $site is UP"
    else
        echo "❌ $site is DOWN"
    fi
done

echo ""
echo "===== CHECK COMPLETE ====="



