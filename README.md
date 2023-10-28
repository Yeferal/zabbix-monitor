# zabbix-monitor
* Si es necesario dar permiso de uso al archivo **1_installation_zabbix.sh** ejecutando el archivo **0_init.sh**
* Para instalar y configurar zabbix ejecutar el bash **1_installation_zabbix.sh**

1. Ejecutar **1_installation_zabbix.sh**
2. Al ingresar a la DB, agregar el usuario y otorgarle permisos

```
> CREATE DATABASE zabbix character set utf8 collate utf8_bin;
> CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';
> GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
> set global log_bin_trust_function_creators = 1;
> FLUSH PRIVILEGES;
> EXIT;
```
3. Entra por segunda ves la db.

```
set global log_bin_trust_function_creators = 0;
```
4. Ajusta la contraseña de la base de datos archivo **/etc/zabbix/zabbix_server.conf**
```
DBPassword=zabbix
```
# Agente Zabbix (Para host)
Accede al host: Conéctate al host en el que deseas instalar el agente de Zabbix a través de SSH o mediante acceso físico

* Si estás utilizando un sistema basado en Debian/Ubuntu, puedes usar el siguiente comando

    ```
    sudo apt-get update
    sudo apt-get install zabbix-agent
    ```
* Si estás utilizando un sistema basado en Red Hat/CentOS, puedes usar el siguiente comando

    ```
    sudo yum install zabbix-agent
    ```

## Configura el agente de Zabbix

El archivo de configuración principal del agente de Zabbix se llama zabbix_agentd.conf. Puedes encontrarlo en la ubicación /etc/zabbix/. Edita este archivo según tus necesidades. Algunas de las configuraciones clave incluyen el servidor al que se conectará el agente, el nombre del host, el puerto y otros ajustes de seguridad.

```
sudo nano /etc/zabbix/zabbix_agentd.conf
```

Ejemplo:

Agrega las siguientes configuraciones para habilitar el monitoreo de interfaces. Asegúrate de que estas configuraciones reflejen tus necesidades y la interfaz que deseas monitorear. En el ejemplo siguiente, asumimos que estás monitoreando la interfaz de red "eth0":

```
# Dirección IP o nombre del servidor Zabbix
Server=nombre_o_IP_del_servidor_Zabbix

# Puerto del servidor Zabbix
ServerPort=10051

# Nombre del host (tal como se configuró en el servidor Zabbix)
Hostname=nombre_del_host_en_Zabbix

# Incluir la plantilla de interfaz
Include=/etc/zabbix/zabbix_agentd.conf.d/
```

* Inicia y habilita el servicio del agente de Zabbix
```
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent
```

## Agregar Host

[Documentacion Agregar Host](https://www.zabbix.com/documentation/6.4/en/manual/quickstart/host)

1. Data collection → Hosts and Monitoring → Hosts

2. Haz clic en "Crear host" para cada uno de tus dispositivos de red (servidor, switches, routers).

3. En la pestaña "General", proporciona un nombre descriptivo para el host y, opcionalmente, un grupo al que pertenecerá.

4. En la pestaña "Interfaz", define la dirección IP del dispositivo y el puerto que se utilizará para la comunicación con el dispositivo. Esto generalmente es el puerto 161 para SNMP.

5. E la pestaña "SNMP", proporciona la cadena comunitaria (SNMP community) necesaria para acceder al dispositivo. Dependiendo del dispositivo, también puedes definir otros parámetros SNMP relevantes.

## Configuración de Elementos de Monitoreo

1. Después de crear el host, ve a la pestaña "Elementos" y haz clic en "Crear elemento" para agregar elementos de monitoreo.

2. Configura elementos de monitoreo SNMP para obtener información específica del dispositivo, como tráfico de red en interfaces, uso de CPU, memoria, etc. Esto implica configurar un OID (identificador de objeto SNMP) adecuado para el tipo de información que deseas supervisar.

## Definición de Triggers
En la pestaña "Disparadores" del host, configura disparadores para definir umbrales y condiciones que activarán alertas en caso de problemas. Por ejemplo, puedes configurar un trigger para que te avise si el ancho de banda en una interfaz supera un cierto límite.


## Creación de Gráficos y Paneles

1. Ve a la sección "Gráficos" o "Paneles" en la interfaz web de Zabbix.

2. Crea gráficos y paneles para visualizar los datos de monitoreo en tiempo real. Puedes mostrar gráficos de tráfico de red, uso de CPU, memoria y otros parámetros relevantes.