# it610midtermProject

## Introduction
This project is meant to install, configure, and run an instance of the Wazuh SIEM (Security Information and Event Management) software. The Wazuh SIEM is a tool used to monitor activity on systems to ultimately assist with cyber security efforts(Incident response, prevention, recovery, etc). The intention was to run Wazuh SIEM on a single container as per the midterm directions. However it was ultimately discovered that Wazuh cannot run this way due to its multi-service architecture requiring multiple containers. However this documentation explains the containerized attempt, along with the solution to run on the host OS without Docker as per professors suggestion after explaining to them.

### What is Wazuh?
Wazuh is a Security Information And Event Management(SIEM) System used to monitor a system's security. Wazuh constantly scans for threats and aggregates findings to a log. Wazuh provides data to display to users and possible mitigation solutions. Wazuh's Agent system can monitor activity and flag any concerns for the user to examine and escalate. This a great and free tool to use, and it is a great software to demonstrate containerization and systems administration on because of its flexible configuration. 

### Prerequisites
* OS: Linux(Either Native, Virtualized, or WSL2) Preferred with **ROOT** access, as this was tested on WSL2 Ubuntu(Debian). Possible on Windows with PowerShell(anything with a terminal)
* Software: Docker Desktop with a DockerHub account
* Browser access with ports 443, 5601, 55000, 9200, 1514/1515, 514 unblocked


## Ideal Containerized Attempt
### Environment Setup
Always ensure your environment is up to date with the latest software to minimize interruption during Wazuh setup
```
    sudo apt-get update
    sudo apt-get upgrade
```

Secure Credentials - Create a .env file (if not existing) and enter your new credentials that will be created upon running and starting the image container. Use the following format in the .env file:
```
WAZUH_USER = username
WAZUH_PASSWORD = password
```

### Initialization and Execution
Have a project directory where you will pull and run the software. Become root and pull the image from the DockerHub repository. The container successfully running means the software was successfully pulled and started
```
    su -
    docker pull alveejalal/wazuhimage:latest 
    docker run -d --name <Custom Container Name> -p 5601:5601 -p 55000:55000 -p 1514:1514 -p 9200:9200  wazuhimage
```
You can also go into the bash shell:
```     docker exec -it <Custom Container Name> bash ```

Become root and change directory (CD) into the /wazuhFiles directory to access the installation scripts
``` su -
    cd wazuhFiles
```
Open the indexer_starter.sh file and set INDEXER_IP, SERVER_IP, DASHBOARD_IP to your host IP. 
```
    INDEXER_IP="<YOUR_IP>"
    SERVER_IP="<YOUR_IP>"
    DASHBOARD_IP="<YOUR_IP>"
```

Access Wazuh on your browser using your set IP(Can be Host, VM, or Localhost IP) and port number(typically 443) for the dashboard  with the URL: ``` https://<Your_IP>:port ```
<img width="1918" height="1198" alt="wazuh_dashboard_startup" src="https://github.com/user-attachments/assets/f635b5d7-d535-4a6e-b01c-23ff13c3df3b" />
Dashboard should look like the above

## Running on Host OS
### Environment Setup
Have a project directory where you will pull and run the software. (Ex: "WazuhProject")
``` git clone git@github.com:AlveeJalal/it610midtermProject.git ```

### Environment Setup & Initiation
Always ensure your environment is up to date with the latest software to minimize interruption during Wazuh setup
```
    sudo apt-get update
    sudo apt-get upgrade
```
Become root and change directory (CD) into the /wazuhFiles directory to access the installation scripts
``` su -
    cd wazuhFiles
```
Open the indexer_starter.sh file and set INDEXER_IP, SERVER_IP, DASHBOARD_IP to your host IP. 
```
    INDEXER_IP="<YOUR_IP>"
    SERVER_IP="<YOUR_IP>"
    DASHBOARD_IP="<YOUR_IP>"
```
Run the installation scripts in the FOLLOWING ORDER: index_starter.sh->server_starter.sh->dashboard_starter.sh 
```
    ./index_starter.sh
    ./server_starter.sh
    ./dashboard_starter.sh
```
Access Wazuh on your browser using your set IP(Can be Host, VM, or Localhost IP) and port number(typically 443) for the dashboard  with the URL: ``` https://<Your_IP>:port ```
<img width="1918" height="1198" alt="wazuh_dashboard_startup" src="https://github.com/user-attachments/assets/f635b5d7-d535-4a6e-b01c-23ff13c3df3b" />
Dashboard should look like the above
### Keeping Services Persistent

If using WSL2, create a script and have it run on startup. Make sure it is executable
```
sudo vi /etc/wsl.conf
```
Add this line ``` command="bash /usr/local/bin/wazuh-startup.sh" ```

Create the script
``` sudo nano /usr/local/bin/wazuh-startup.sh ```
The script will run the services on startup
```
#!/bin/bash
# Wait a few seconds for networking to stabilize
sleep 5

# Start all Wazuh services
systemctl start wazuh-indexer
systemctl start wazuh-manager
systemctl start wazuh-dashboard

```



### Precautions
* Ensure all scripts are run in the EXACT ORDER mentioned (index_starter.sh->server_starter.sh->dashboard_starter.sh) and let each script finish before starting the next
* Ensure the ENTIRE installment is done on ONE terminal/session/tab. 
* Ensure firewall rules are NOT blocking ports 443, 5601, 55000, 9200, 1514/1515, 514
* Ensure the `wazuh-certificates.tar` file is present with the installer files - this is needed to assign and verify certificated for security

## Component/features Breakdown

### indexer_starter.sh,  server_starter.sh,  dashboard_starter.sh 
Scripts to install, setup & run the Wazuh Indexer, manager & dashboard Generates config files, creates and sets a node, & initialized cluster security/certification script. Overwrites existing installations.
