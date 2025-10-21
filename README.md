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

Have a project directory where you will pull and run the software. 

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
### Precautions
* Ensure all scripts are run in the EXACT ORDER mentioned (index_starter.sh->server_starter.sh->dashboard_starter.sh) and let each script finish before starting the next
* Ensure the ENTIRE installment is done on ONE terminal/session/tab. 
* Ensure firewall rules are NOT blocking ports 443, 5601, 55000, 9200, 1514/1515, 514
* Ensure the `wazuh-certificates.tar` file is present with the installer files - this is needed to assign and verify certificated for security


