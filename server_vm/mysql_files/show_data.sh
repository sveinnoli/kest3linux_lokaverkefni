#!/bin/bash
echo "Employees"
sudo mysql -uroot -D HumanResources -e "select * from Employees"

echo "Departments"
sudo mysql -uroot -D HumanResources -e "select * from Departments"

