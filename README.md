# Submission Reminder Script

## Project Structure & Purpose
This project automates the process of setting up a submission reminder system for tracking student assignment submissions using Bash scripts. It is managed using two Git branches:
- **`feature/setup`**: Used for development and rough work.
- **`main`**: Contains only the final production-ready scripts.
  
---

## Files in the `main` Branch

After merging, only the following files should be present in the `main` branch:
- `create_environment.sh`  
  Sets up the directory structure and initializes all required files for the reminder app.
- `copilot_shell_script.sh`  
  Allows a user to input a new assignment name and checks which students have not submitted it yet.
- `README.md`  
  Provides documentation and usage instructions.
  
---

## Script Details
### 1. `create_environment.sh`
- Prompts the user for their name.
- Creates a directory named: `submission_reminder_{yourName}`.
- Inside this directory, it creates the following subdirectories and files:
  - `app/reminder.sh`
  - `modules/functions.sh`
  - `assets/submissions.txt`
  - `config/config.env`
  - `startup.sh`
> This script prepares the environment needed to run the assignment reminder system.

---

### 2. `copilot_shell_script.sh`
- Prompts the user to enter a new assignment name.
- Updates the assignment name in the config file.
- Automatically runs the reminder system to check which students haven't submitted that assignment.
  
---

## How to Use
1. Clone the repository.
2. Run `create_environment.sh` to generate the environment:
   ```bash
   bash create_environment.sh
bash copilot_shell_script.sh
