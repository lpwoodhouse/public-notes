#!/bin/bash

#put root password in variable to save entering password for each task
read -sp 'root password?: ' pwd

#remove existing repos
ansible all -u root -e "ansible_password=$pwd" -m file \
-a "path=/etc/yum.repos.d/*.repo state=absent"

#add BaseOS repo
ansible all -u root -e "ansible_password=$pwd" -m yum_repository \
-a "file=control name=BaseOS description=BaseOS baseurl=ftp://10.0.0.185/pub/repo/BaseOS gpgcheck=no enabled=yes"

#add AppStream repo
ansible all -u root -e "ansible_password=$pwd" -m yum_repository \
-a "file=control name=AppStream description=AppStream baseurl=ftp://10.0.0.185/pub/repo/AppStream gpgcheck=no enabled=yes"
