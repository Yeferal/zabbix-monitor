# !/bin/bash

# Actualiza el sistema
sudo apt update
sudo apt upgrade -y

# Instala los paquetes necesarios, como el servidor web Apache, la base de datos MySQL y otros componentes requeridos para Zabbix
sudo apt install -y apache2 mysql-server mysql-client php libapache2-mod-php php-mysql php-gd php-bcmath php-mbstring php-xml php-ldap php-net-socket php-zip

# Habilita y arranca los servicios de Apache y MySQL
sudo systemctl enable apache2
sudo systemctl enable mysql
sudo systemctl start apache2
sudo systemctl start mysql

# Descarga e importa el esquema de base de datos de Zabbix
sudo wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb
sudo apt update
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Configura la base de datos Zabbix en MySQL
sudo mysql

# Entra en el entorno de MySQL
# CREATE DATABASE zabbix character set utf8 collate utf8_bin;
# CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';
# GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
# set global log_bin_trust_function_creators = 1;
# FLUSH PRIVILEGES;
# EXIT;

# Importa el esquema de la base de datos de Zabbix
# sudo zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | sudo mysql -uzabbix -p zabbix
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

mysql -u root -p
# set global log_bin_trust_function_creators = 0;
# quit;

# Edita el archivo de configuración de Zabbix Server
sudo nano /etc/zabbix/zabbix_server.conf

# Ajusta la contraseña de la base de datos
# DBPassword=zabbix

# Reinicia el servidor Zabbix
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
