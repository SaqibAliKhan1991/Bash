#!/bin/bash

threshold=60
disk=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ $disk -gt $threshold ]; then
    echo "⚠️ Warning! Disk usage is ${disk}%"
else
    echo "✅ Disk usage is ${disk}%"
fi

