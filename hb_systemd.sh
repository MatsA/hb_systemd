#!/bin/bash
echo " " 
echo "--------------------------------------------------------------------"
echo "This script will install, systemd, autostart and restart at failure "
echo "                       for Homebridge                               "

# Get program location
where=$(which homebridge)

cat > /etc/systemd/system/homebridge.service <<EOL
# systemd service file to start Homebridge

[Unit]
Description=Node.js HomeKit Server 
After=syslog.target network-online.target
# Documentation=

[Service]
Type=simple
User=pi
ExecStart=${where}
Restart=always
RestartSec=10
KillMode=process
KillSignal=SIGINT
SyslogIdentifier=Homebridge

[Install]
WantedBy=multi-user.target
EOL

echo " "  
echo "Starting deamon .... please wait"                     
echo " "  

systemctl daemon-reload
systemctl enable homebridge
systemctl restart homebridge

echo "Showing status "  
echo "--------------------------------------------------------------------"
echo " "  

systemctl status homebridge