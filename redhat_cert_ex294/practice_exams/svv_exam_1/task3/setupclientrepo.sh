#!/bin/bash

#put root password in variable to save entering password for each task
read -sp 'root password?: ' pwd

#remove existing repos
ansible servers,test -u root -e "ansible_password=$pwd" -m file \
-a "path=/etc/yum.repos.d/*.repo state=absent"

#add BaseOS repo
ansible servers,test -u root -e "ansible_password=$pwd" -m yum_repository \
-a "file=control name=BaseOS description=BaseOS baseurl=ftp://control.example.com/repo/BaseOS gpgcheck=no enabled=yes"

#add AppStream repo
ansible servers,test -u root -e "ansible_password=$pwd" -m yum_repository \
-a "file=control name=AppStream description=AppStream baseurl=ftp://control.example.com/repo/AppStream gpgcheck=no enabled=yes"
