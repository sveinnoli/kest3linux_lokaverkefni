## Security
admin: sveinnoli    
pass : secretpassword112


## Networking
domain: ddp.is
network address: 192.168.100.0/24
server ip: 192.68.100.10/24

### Ports opened
port 514/tcp: used for rsyslog


## Configuration files
#### Networking 
**/etc/netplan/.yaml**:
this file allows you to change the ip addr subnetmask and so fourth of the device.

#### DHCP
**/etc/dhcp/dhcpd.conf**: subnets and such\
**/etc/default/isc-dhcp-server**: telling which interface to listen on

#### DNS - bind9
**/etc/bind/named.conf.options**: global DNS options\
**/etc/bind/named.conf.local**: for your zones\
**/etc/bind/named.conf.default-zones**: default zones such as localhost, its reverse, and the root hints

NOTE: zones are used to create info on a domain\
named.conf.local is used to tell what domain corresponds to what zone and if it cannot match it locally it will resolve to an external dns (8.8.8.8 and 8.8.8.4)

#### Logger - rsyslog
**/etc/rsyslog.conf**
**/etc/rsyslog.d/\*.conf**

all files in rsyslog.d get importe to rsyslog.conf, the server and clients have been configured in the rsyslog.conf file at the end of the file.

#### ntp
**/etc/ntp.conf**
For clients, the ip address of the server has to be set and tell them to listen to server for time sync.


## Services
### Server 
isc-dhcp-server  # used for dhcp\
bind9            # used for dns\
mysql-server     # used to store information
openssh-server   # used as ssh server
rsyslog          # used for logging
ntp              # used for synchronising time of server and clients
postfix          # email server
sendmail         # used to send emails
mail-utils       # used to read emails

### Clients
openssh-client   # To connectt to ssh server
rsyslog          # used for logging
ntp              # used for synchronising time of server and clients

### Starting up services
sudo systemctl start mysql.service\
sudo systemctl enable mysql.service

sudo systemctl start isc-dhcp-server\
sudo systemctl enable isc-dhcp-server

sudo systemctl start bind9\
sudo systemctl enable bind9

sudo systemctl start ntp
sudo systemctl enable ntp



## Backup with crontab
Crontab config can be viewed with 
> crontab -e

## Logging
all clients are remotely logged to the server to the directory
**/var/log/remotelogs/RemoteLog.log**


## Database
Scripts used:

**setup_humanresources.sh**: create humanresources database and associated tables\
**insert_data.sh**: inserts appropriate information into tables.


### Access
To access database, you need to be root and execute the command:
> **mysql**

in scripts it is possible to execute
> **sudo mysql -uroot**

to gain access to the database. From there normal commands can be used like:
> show tables;\
> select * from tablename;

...etc.


## Debugging
#### centos
sometimes the virtual network gives the client a dhcp connection to some weird dhcp server, to fix it use: 
> nmcli connection show

and then use:
> nmcli connection delete "ConnectionName"

to delete it.

Alternatively the services which cause the connection to appear can be stopped and disabled:

>sudo systemctl stop libvirtd

>sudo systemctl disable libvirtd

by default centos will not ask for a lease upon booting.
the file **/etc/sysconfig/network-scripts/ifcfg-ens33** can be modified so that onboot=no is set to onboot=yes.

## Usefull commands
Get new lease:
> dhclient