#!/bin/bash

#Investigate to know if the script is being run as root
if [[ $EUID -ne 0 ]]; then
	echo "YOU MUST RUN THIS SCRIPT AS ROOT!"
	exit 1
fi

# To check if the argument is provided
if [ -z "$1" ]; then
	echo "use: $0 <user_list_file>"
	exit 1
fi

USER_FILE=$1
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"

#Creating directories for file and setting permissions
sudo mkdir -p /var/log
sudo touch $LOG_FILE
sudo chmod 600 $LOG_FILE
sudo mkdir -p /var/secure
sudo touch $PASSWORD_FILE
sudo chmod 600 $PASSWORD_FILE

#creating a function to generate random password

gen_password() {
	echo "$(date + '%Y-%M-%D %H:%M:%S') - $1" >> $LOG_FILE
}

#Reading the user list file line by line
while IFS=';' read -r user groups; do
	# Remove whitespaces
	user=$(echo $user | xargs)
	groups=$(echo $groups | xargs)

	# Check if user already exists
	if id "$user" &>/dev>null; then
		log_message "user $user already exists."
		continue
	fi

	#Creating personal group for user
	groupadd $user
	log_message "Group $user created"

	#creating personal group for group
	useradd -m -g $user -s /bin/bash $user
	log_message "User $user created with home directory and personal group"

	# Assign user to more  groups
	if [ -n "$groups" ]; then
		IFS=',' read -r -a group_array <<< "$groups"
		for group in "${group_array[@]}"; do
			#remove whitespaces
			group=$(echo $group | xargs)
			if ! getent group "$group" > /dev/null; then
				groupadd $group
				log_message "Group $group created"
			fi
			usermod -aG $group $user
			log_message "user $user added to $group."
		done
	fi
	#Generate random password
	password=$(generate_password)
	echo "$user:$password" | chpasswd
	log_message "Password set for user $user."

	#store password in secure file
	echo "$user,$password" >> $PASSWORD_FILE
done < "$USER_FILE"

log_message "User creation process completed."

echo "Script executed successfully. View $LOG_FILE for details."

