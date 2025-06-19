#!/bin/bash

# User name
read -p "Enter your name: " user_name

# Directory name
dir_name="submission_reminder_${user_name}"

# Create directory structure
mkdir -p "$dir_name"/{app,modules,assets,config}

# Create reminder.sh
cat <<EOL > "$dir_name/app/reminder.sh"
#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions \$submissions_file
EOL
chmod +x "$dir_name/app/reminder.sh"

# Create functions.sh
cat <<EOL > "$dir_name/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOL
chmod +x "$dir_name/modules/functions.sh"

# Copy and append submissions.txt
# cp submissions.txt "$dir_name/assets/submissions.txt"
cat <<EOL > "$dir_name/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Mugisha, Git, not submitted
Sam, Shell Navigation, Submitted
Robert, Git, Submitted
David, Shell, submitted
EOL

# Create config.env
cat <<EOL > "$dir_name/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# Create startup.sh
cat <<EOL > "$dir_name/startup.sh"
#!/bin/bash

# Start reminder script if it exists
if [ -f "./app/reminder.sh" ]; then
    echo "Starting the reminder script..."
    ./app/reminder.sh
else
    echo "reminder.sh not found!"
fi
EOL
chmod +x "$dir_name/startup.sh"

# Make all .sh files executable inside the directory
find "$dir_name" -type f -name "*.sh" -exec chmod +x {} \;

echo " Environment setup complete in: $dir_name"
echo " To run the app: cd $dir_name && ./startup.sh"

