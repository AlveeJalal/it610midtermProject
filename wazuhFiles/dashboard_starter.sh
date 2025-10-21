#!/bin/bash
bash wazuh-install.sh --wazuh-dashboard dashboard -o
# Create config file if missing
sudo mkdir -p /etc/wazuh-dashboard
sudo bash -c 'cat > /etc/wazuh-dashboard/opensearch_dashboards.yml << EOF
server.host: 0.0.0.0
server.port: 443
opensearch.hosts: https://localhost:9200
opensearch.username: admin
opensearch.password: admin
opensearch.ssl.verificationMode: none
csp.strict: false
csp.warnLegacyBrowsers: false
logging.verbose: true
EOF'
sudo chown wazuh-dashboard:wazuh-dashboard /etc/wazuh-dashboard/opensearch_dashboards.yml
sudo systemctl start wazuh-dashboard

sudo bash -c 'cat > /etc/systemd/system/wazuh-dashboard.service << EOF
[Unit]
Description=Wazuh dashboard
After=network.target

[Service]
Type=simple
User=wazuh-dashboard
Group=wazuh-dashboard
WorkingDirectory=/usr/share/wazuh-dashboard
ExecStart=/usr/share/wazuh-dashboard/node/bin/node --no-warnings --max-http-header-size=65536 /usr/share/wazuh-dashboard/src/cli/dist
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable wazuh-dashboard
sudo systemctl start wazuh-dashboard
