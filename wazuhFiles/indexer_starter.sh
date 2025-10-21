#!/bin/bash
#Download the Wazuh installation assistant and the configuration file.
apt-get install -y curl sudo
#cd /WazuhApp/testWazuh
curl -sO https://packages.wazuh.com/4.13/wazuh-install.sh
curl -sO https://packages.wazuh.com/4.13/config.yml

INDEXER_IP="172.23.128.164"
SERVER_IP="172.23.128.164"
DASHBOARD_IP="172.23.128.164"

sudo sed -i "s|<indexer-node-ip>|${INDEXER_IP}|g" config.yml
sudo sed -i "s|<wazuh-manager-ip>|${SERVER_IP}|g" config.yml
sudo sed -i "s|<dashboard-node-ip>|${DASHBOARD_IP}|g" config.yml

if [ ! -f wazih-install.sh ]; then
	sudo bash  wazuh-install.sh  --generate-config-files
	sudo bash  wazuh-install.sh --wazuh-indexer node-1 -o
fi
sudo bash  wazuh-install.sh --start-cluster
#TEST CLUSTER INSTALLATION
#tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep -P "\'admin\'" -A 1
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200/_cat/nodes?v
