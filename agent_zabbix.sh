# !/bin/bash

# Descarga el agente de Zabbix
# Para Debian
sudo apt-get update
sudo apt-get install zabbix-agent

# Para CentosOS
# sudo yum install zabbix-agent


sudo nano /etc/zabbix/zabbix_agentd.conf


sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent