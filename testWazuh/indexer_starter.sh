#!/bin/bash
#Download the Wazuh installation assistant and the configuration file.

#install packages
apt-get install -y curl sudo
apt-get update && apt-get install -y openjdk-11-jdk
cd /WazuhApp/testWazuh
curl -sO https://packages.wazuh.com/4.13/wazuh-install.sh
curl -sO https://packages.wazuh.com/4.13/config.yml

# OpenAI. (2025). ChatGPT (GPT-5 ) [Large language model]. Code generated for passing IP addresses to .yaml files for installation assistance. https://chat.openai.com/chat
#set IP addresses in Config file
sed -i "s|<indexer-node-ip>|${INDEXER_IP}|g" config.yml
sed -i "s|<wazuh-manager-ip>|${SERVER_IP}|g" config.yml
sed -i "s|<dashboard-node-ip>|${DASHBOARD_IP}|g" config.yml

#install indexer
sudo bash wazuh-install.sh --generate-config-files
sudo bash  wazuh-install.sh --wazuh-indexer node-1

#start indexer
if [ -f /usr/share/wazuh-indexer/bin/opensearch ]; then
    echo "Starting Wazuh Indexer..."
    nohup /usr/share/wazuh-indexer/bin/opensearch > /var/log/wazuh-indexer.log 2>&1 &
else
    echo " opensearch binary missing!"
    ls -l /usr/share/wazuh-indexer/bin || echo "Directory missing!"
fi


#start security cluster
sudo bash  wazuh-install.sh --start-cluster

#TEST CLUSTER INSTALLATION
#tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep -P "\'admin\'" -A 1
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200/_cat/nodes?v
