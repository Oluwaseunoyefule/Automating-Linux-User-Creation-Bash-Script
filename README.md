# Automating-Linux-User-Creation-Bash-Script
This repository discusses steps to creating a bash script that automates user and group creation process as a sysOps engineer, ensuring consistency, accuracy and efficiency in task management.

# Procedures
1. Script initialization
First, the script makes sure it executes with root privileges and verifies that the necessary parameter is there.
![Capture](https://github.com/Oluwaseunoyefule/Automating-Linux-User-Creation-Bash-Script/assets/94696105/1cb904c9-dd5a-4780-897a-02415a05d473)

2. Initialize password and log file
To maintain security, we provide the locations for the password and log files, make the required folders, and establish the right permissions. 
![Capture2](https://github.com/Oluwaseunoyefule/Automating-Linux-User-Creation-Bash-Script/assets/94696105/8b1c61da-959a-413a-a484-60f74766ddd3)

3. Creating random Passwords and logging Capabilities
This procedure assist in creating random passwords and timestamping activity logs.
![Capture3](https://github.com/Oluwaseunoyefule/Automating-Linux-User-Creation-Bash-Script/assets/94696105/e642cd88-a82e-4f1f-b1be-8c95ff665c38)

4. Whitespace removal
The script reads the user list file line by line, stripping whitespace for cleaner processing.
![Capture4](https://github.com/Oluwaseunoyefule/Automating-Linux-User-Creation-Bash-Script/assets/94696105/00c8527b-57c0-4e1e-91f7-8a92ac071f6a)

5. User and Group Creation
The aim of this function is to check if the user already exists then Create a personal group for each user and a group for the groups. This function the Creates the user and adds them to specified groups and adds user to multiple groups if required.
![Capture5](https://github.com/Oluwaseunoyefule/Automating-Linux-User-Creation-Bash-Script/assets/94696105/6fa273ce-0458-4838-beaa-5c4357752237)

6. Password generation along with secure storage
Lastly, the script creates and assigns a random password to every user, safely saves it, and records the activity.
