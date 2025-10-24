FROM ubuntu
#base image with SystemD enabled for wazuh to run above 
ARG WAZUH_USER
ARG WAZUH_PASSWORD

ENV WAZUH_USER=${WAZUH_USER}
ENV WAZUH_PASSWORD=${WAZUH_PASSWORD}


RUN apt-get update 
RUN  apt-get -y upgrade
RUN apt-get install -y \
sed curl gnupg sudo  apt-transport-https lsb-release \
    openjdk-17-jdk
RUN rm -rf /var/lib/apt/lists/* 

 

WORKDIR /WazuhApp
RUN useradd $WAZUH_USER && echo "$WAZUH_USER:$WAZUH_PASSWORD" | chpasswd

USER root
COPY . .

RUN mkdir -p /var/log/supervisor /etc/supervisor/conf.d


WORKDIR "/WazuhApp/testWazuh"

#ENV INDEXER_IP=172.23.128.164
#ENV SERVER_IP=172.23.128.164
#ENV DASHBOARD_IP=172.23.128.164


ENV INDEXER_IP=127.0.0.1
ENV SERVER_IP=127.0.0.1
ENV DASHBOARD_IP=127.0.0.1

RUN curl -sO https://packages.wazuh.com/4.13/wazuh-install.sh && \
    curl -sO https://packages.wazuh.com/4.13/config.yml && \
    chmod +x wazuh-install.sh && \
    sed -i "s|<indexer-node-ip>|${INDEXER_IP}|g" config.yml && \
    sed -i "s|<wazuh-manager-ip>|${SERVER_IP}|g" config.yml && \
    sed -i "s|<dashboard-node-ip>|${DASHBOARD_IP}|g" config.yml    

#RUN bash wazuh-install.sh --generate-config-files && \
#    bash wazuh-install.sh --wazuh-indexer node-1 && \
 #   bash wazuh-install.sh -o --wazuh-server wazuh-1 && \
#    bash wazuh-install.sh -o --wazuh-dashboard dashboard

RUN chmod +x indexer_starter.sh server_starter.sh dashboard_starter.sh

#RUN ./indexer_starter.sh ./server_starter.sh ./dashboard_starter.sh


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 1514/tcp 55000/tcp 5601/tcp 9200/tcp
VOLUME ["/WazuhApp/testWazuh/wazuh-install-files"]




# Run a post-fix setup command to reload config
# RUN /usr/bin/wazuh-config-reload || true
 

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["bash"]

#, "-c", "./indexer_starter.sh && /server_starter.sh && dashboard_starter.sh && tail -f /dev/null"]

#configure environment for user setting up Wazuh SIEM for security.

#Used assistance from Generative AI to help with passing env files to .yaml file during docker build (was having trouble with this)
