#!/bin/bash

home=$HOME

sudo rm -rf /etc/motd
sudo rm -rf /etc/update-motd.d
sudo mkdir -p /etc/update-motd.d
sudo find "$home/repos/misc/motd/files" -type f -exec cp {} /etc/update-motd.d \;
sudo chmod -R 0777 /etc/update-motd.d
