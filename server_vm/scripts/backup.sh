#!/bin/bash
mkdir -p /home/sveinnoli/backups 2> /dev/null

backup_dir="/home/sveinnoli/backups"

timestamp=$(date +%Y%m%d%H%M%S)


sudo tar -czf "$backup_dir/home_backup_$timestamp.tar.gz" /home 2> /dev/null
