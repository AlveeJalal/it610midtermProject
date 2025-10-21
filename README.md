# it610midtermProject

## Introduction
This project is meant to install, configure, and run an instance of the Wazuh SIEM (Security Information and Event Management) software. The Wazuh SIEM is a tool used to monitor activity on systems to ultimately assist with cyber security efforts(Incident response, prevention, recovery, etc). The intention was to run Wazuh SIEM on a single container as per the midterm directions. However it was ultimately discovered that Wazuh cannot run this way due to its multi-service architecture requiring multiple containers. However this documentation explains the containerized attempt, along with the solution to run on the host OS without Docker as per professors suggestion after explaining to them.

### What is Wazuh?
Wazuh is a Security Information And Event Management(SIEM) System used to monitor a system's security. Wazuh constantly scans for threats and aggregates findings to a log. Wazuh provides data to display to users and possible mitigation solutions. Wazuh's Agent system can monitor activity and flag any concerns for the user to examine and escalate. This a great and free tool to use, and it is a great software to demonstrate containerization and systems administration on because of its flexible configuration. 

### Prerequisites
* OS: Linux(Either Native, Virtualized, or WSL2) Preferred with **ROOT** access, as this was tested on WSL2. Possible on Windows with PowerShell(anything with a terminal)
* Software: Docker Desktop with a DockerHub account
* Browser access with ports 443, 5601, 55000, 9200, 1514/1515, 514 unblocked


### Ideal Containerized Attempt
## Environment Setup

Have a project directory where you will pull and run the software. 

### Running on Host OS
## Environment Setup
Have a project directory where you will pull and run the software. (Ex: "WazuhProject")

``` git clone git@github.com:AlveeJalal/it610midtermProject.git ```
