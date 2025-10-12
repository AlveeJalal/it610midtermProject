FROM ubuntu
RUN apt-get update 
RUN  apt-get -y upgrade 
WORKDIR /WazuhApp
RUN useradd WazuhUser
USER root
COPY . .
WORKDIR "/WazuhApp/testWazuh"
RUN ./indexer_starter.sh
RUN ./server_starter.sh
RUN ./dashboard_starter.sh
USER WazuhUser
#configure environment for user setting up Wazuh SIEM for security.
