#!/bin/bash
#start indexer 

/lib/systemd/systemd &
SYSTEMD_PID=$!
sleep 3

cd /WazuhApp/testWazuh

if [ ! -f  /usr/share/wazuh-indexer/bin/wazuh-indexer ]; then
	echo "Installing Wazuh Indexer..."
	bash wazuh-install.sh --generate-config-files
	bash wazuh-install.sh --wazuh-indexer node-1
# Show the actual error log
        echo "=== INSTALLATION ERROR LOG ==="
        cat /var/log/wazuh-install.log
        echo "=== END ERROR LOG ==="

fi

#start manager 
if [ ! -f /var/ossec/bin/wazuh-control ]; then
	echo "Installing Wazuh Server/manager..."
       bash wazuh-install.sh -o --wazuh-server wazuh-1
fi


#start dashboard
if [ ! -f /usr/share/wazuh-dashboard/bin/wazuh-dashboard ]; then
	echo "Installing Wazuh Dashboard..."
	bash wazuh-install.sh -o --wazuh-dashboard dashboard
fi

echo "Starting Services"

if [ -x /usr/share/wazuh-indexer/bin/wazuh-indexer ]; then
	echo "Starting Wazuh Indexer..."
	/usr/share/wazuh-indexer/bin/wazuh-indexer & 
	sleep 10
else
    echo "ERROR: Wazuh Indexer binary not found"
fi

if [ -x /var/ossec/bin/wazuh-control ]; then
	echo "Starting Wazuh Server..."
	/var/ossec/bin/wazuh-control start
	sleep 5
else
    echo "ERROR: Wazuh Manager binary not found"
fi

if [ -x /usr/share/wazuh-dashboard/bin/wazuh-dashboard ]; then
	echo "Starting Wazuh Dashboard..."
	exec /usr/share/wazuh-dashboard/bin/wazuh-dashboard

else
    echo "ERROR: Wazuh Dashboard binary not found!"
    tail -f /dev/null
fi

#keep container alive
#tail -f /var/ossec/logs/ossec.log /usr/share/wazuh-dashboard/data/wazuh-logs.log 2>/dev/null || tail-f /dev/null
	
