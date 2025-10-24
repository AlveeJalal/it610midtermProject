#!/bin/bash
#Download the Wazuh installation assistant and the configuration file.
apt-get install -y curl sudo
apt-get update && apt-get install -y openjdk-11-jdk
cd /WazuhApp/testWazuh
curl -sO https://packages.wazuh.com/4.13/wazuh-install.sh
curl -sO https://packages.wazuh.com/4.13/config.yml

sed -i "s|<indexer-node-ip>|${INDEXER_IP}|g" config.yml
sed -i "s|<wazuh-manager-ip>|${SERVER_IP}|g" config.yml
sed -i "s|<dashboard-node-ip>|${DASHBOARD_IP}|g" config.yml

sudo bash wazuh-install.sh --generate-config-files
sudo bash  wazuh-install.sh --wazuh-indexer node-1

#the part below was given with assistance from generative AI due to unknown issues on my end
if [ -f /usr/share/wazuh-indexer/bin/opensearch ]; then
    echo "Starting Wazuh Indexer..."
    nohup /usr/share/wazuh-indexer/bin/opensearch > /var/log/wazuh-indexer.log 2>&1 &
else
    echo " opensearch binary missing!"
    ls -l /usr/share/wazuh-indexer/bin || echo "Directory missing!"
fi



sudo bash  wazuh-install.sh --start-cluster
#TEST CLUSTER INSTALLATION
#tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep -P "\'admin\'" -A 1
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200/_cat/nodes?v
