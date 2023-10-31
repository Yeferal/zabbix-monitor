# !/bin/bash

# Descarga el agente de Zabbix



# Mostrar las opciones al usuario
echo "Elige una opción:"
echo "1. Opción 1"
echo "2. Opción 2"

# Leer la entrada del usuario
read opcion

# Utilizar una estructura case para manejar las opciones
case $opcion in
    1)
        echo "Debian"
        # Para Debian
        sudo apt-get update
        sudo apt-get install zabbix-agent
        sudo nano /etc/zabbix/zabbix_agentd.conf
        sudo systemctl start zabbix-agent
        sudo systemctl enable zabbix-agent
        ;;
    2)
        echo "CentosOS"
        # Para CentosOS
        sudo yum install zabbix-agent
        sudo nano /etc/zabbix/zabbix_agentd.conf
        sudo systemctl start zabbix-agent
        sudo systemctl enable zabbix-agent
        ;;
    *)
        echo "Opción no válida."
        ;;
esac


# sudo nano /etc/zabbix/zabbix_agentd.conf


# sudo systemctl start zabbix-agent
# sudo systemctl enable zabbix-agent