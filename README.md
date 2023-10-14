https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/

# kest3linux_lokaverkefni
Note: additonal information regarding setup can be found in this [markdown file.](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/other.md)

# 1. Hostname
![hostname output](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/hostname.png)\
[Script for hostname](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/scripts/set_hostname)\
[Configuration file for hostname](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/hostname)

# 2. Configure IP ADDRESS
[netplan.yaml - for server](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/netplan.yaml)\
Screenshot of server configuration\
![Ip conf of server](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/ip_addr_server.png)

Screenshot of client configuration
![https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/ip_addr_client.png)
# 3. DHCP configuration
[DHCP config file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/dhcpd.conf)\
DHCP was set on the appropriate network and has the server ip address 192.168.100.10 excluded from the range. The server was also set to provide DNS

# 4. Setup DNS on server
bind9 was used to configure DNS on server.

[bind9 zone file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/ddp.is.zone)\
[bind9 config file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/named.conf.local)

# 5. Create and configure Users
[User script](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/scripts/create_users.sh)

Screenshot of users in /etc/passwd:\
![screenshot of users in /etc/passwd](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/users.png)

# 6. Install and configure MYSQL server
[Create HumanResources database and tables for database script](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/mysql_files/setup_humanresources.sh)

[Insert data into HumanResources database](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/mysql_files/insert_data.sh)

Output of selecting all data from database after insertion using [show_data.sh](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/mysql_files/show_data.sh):\
[Link to output.txt](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/mysql_files/output.txt)

### SQL QUERIES
[sql file for creating database](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/mysql_files/mysql_setup_database.sql)\
[sql file for creating tables](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/mysql_files/mysql_setup_tables.sql)

# 7. Weekly backups
Crontab was used to schedule the backups at midnight on fridays.

[script for backing up home directory](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/scripts/backup.sh)\
[crontab used for scheduling backup](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/backup_crontab)

**NOTE** only bottom part of the crontab is relevant for scheduling the run of backup.sh at midnight on fridays.

# 8. Install and configure NTP
[Server config file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/ntp.conf)

[Clients config file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/client_vm/ntp.conf)

Screenshot of server as NTP master server for client:\
![Screenshot of server as NTP master server for client](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/ntp_client_synced_2.png)

**IMPORTANT:** There are many ntp servers listed, however the main server 192.168.100.10 is preferred (can be seen in the client config file at the bottom) and the other are used as backup and to simply get a time reference from more sources to accurately synchronise time on the client.

# 9. Install and configure Syslog
[Server configuration](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/rsyslog.conf)

[Client configuration](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/client_vm/rsyslog.conf)

**Note:** port 514/udp is used to transmit logs to server. The logs are saved in **/var/logs/remotelogs/RemoteLogs.log** on the server.

[Output of remote logs (the raw file is too large to be viewed on github.)](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/logging_output.txt)


# 10. Install and configure Postfix
Postfix and mail-utils were used to host the mailserver and send mail between users.

[Configuration file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/postfix_main.cf)

Screenshot of received mails:\
![Screenshot of received mails](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/mailing.png)

# 11. Install and configure shared printers
All printers were added using the cups interface at http://localhost:631.

[Configuration file](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/cupsd.conf)

Printers in cups interface:\
![Screenshot of registered printers on cups interface](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/all_printers_cups.png)

Printers shown using lpstat -a\
![Screenshot of registered printers](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/printers.png)

Printer queues shown using lpstat -p -d\
![Screenshot of printer in queue](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/now_printing.png)

**NOTE:** prints in the image above failed because a dummy printer was being used.

# 12. Install and configure SSH
To allow for seemless login, the public keys were copied using ssh-copy-id user@192.168.100.10 where user was the respective user that was to allowed to have seemless login with the server.

[Authorized keys file for server](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/server_vm/conf_files/authorized_keys)

# 13. Close all unused ports
Open ports shown using nmap on server:
![open ports shown using nmap](https://github.com/sveinnoli/kest3linux_lokaverkefni/blob/main/screenshots/ports_closed.png)

All ports that appear in nmap need to be kept open.
22: for ssh\
25: for mailing\
53: for dns\
514: for syslog\
587: for mailing\
631: for printing\
3306: for mysql server

All other ports were closed as they were not needed.