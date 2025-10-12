#!/bin/bash
#Download the Wazuh installation assistant and the configuration file.
curl -sO https://packages.wazuh.com/4.13/wazuh-install.sh
curl -sO https://packages.wazuh.com/4.13/config.yml
bash wazuh-install.sh --generate-config-files
bash wazuh-install.sh --wazuh-indexer node-1
bash wazuh-install.sh --start-cluster
#TEST CLUSTER INSTALLATION
#tar -axf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt -O | grep -P "\'admin\'" -A 1
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200
#curl -k -u admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200/_cat/nodes?v
