#!/bin/bash
sudo mysql -uroot -e "source mysql_setup_database.sql"
sudo mysql -uroot -D HumanResources -e "source mysql_setup_tables.sql"
