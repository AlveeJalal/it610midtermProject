FROM ubuntu
RUN apt-get update 
RUN  apt-get -y upgrade 
WORKDIR ~/WazuhApp
RUN useradd WazuhUser
USER WazuhUser
#configure environment for user setting up Wazuh SIEM for security.
