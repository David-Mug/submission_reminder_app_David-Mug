#!/bin/bash

# Start reminder script if it exists
if [ -f "./app/reminder.sh" ]; then
    echo "Starting the reminder script..."
    ./app/reminder.sh
else
    echo "reminder.sh not found!"
fi
