#!/bin/bash

#put root password in variable to save entering password for each task
read -sp 'root password?: ' pwd

#config /etc/hosts otherwise repos will not resolve to the control server
ansible servers,test -u root -e "ansible_password=$pwd" -m shell \
-a "echo -e '10.0.0.176\tcontrol.example.com control' >> /etc/hosts"

#install python
ansible servers,test -u root -e "ansible_password=$pwd" -m yum \
-a "name=python3 state=present"
ansible servers,test -u root -e "ansible_password=$pwd" \
-a "alternatives --set python /usr/bin/python3"

#create user
ansible servers,test -u root -e "ansible_password=$pwd" -m user \
-a "name=ansible state=present"

#config sudoers
ansible servers,test -u root -e "ansible_password=$pwd" -m shell \
-a "echo -e 'ansible\tALL=(ALL)\tNOPASSWD: ALL' > /etc/sudoers.d/ansible"

#config ssh key (now that ansible user exists I can configure passwordless access)
ansible servers,test -u root -e "ansible_password=$pwd" -m authorized_key \
-a "user=ansible state=present key={{ lookup('file', '/home/ansible/.ssh/id_rsa.pub') }}"

#ping test will test connectivity using ansible user for first time
ansible servers,test -m ping
