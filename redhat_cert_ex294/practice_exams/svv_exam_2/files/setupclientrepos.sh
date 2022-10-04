#!/bin/bash

read -sp 'provide root password:' pwd

ansible all -u root -e "ansible_password=$pwd" -m file \
-a 'path=/etc/yum.repos.d/*.repo state=absent'

ansible all -u root -e "ansible_password=$pwd" -m yum_repository \
-a "name=BaseOS description=BaseOS baseurl=ftp://10.0.0.176/repo/BaseOS gpgcheck=no enabled=yes"

ansible all -u root -e "ansible_password=$pwd" -m yum_repository \
-a "name=AppStream description=AppStream baseurl=ftp://10.0.0.176/repo/AppStream gpgcheck=no enabled=yes"
