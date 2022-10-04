#!/bin/bash

read -sp 'provide root password:' pwd

ansible all -u root -e "ansible_password=$pwd" -m yum \
-a 'name=python3 state=present'

ansible all -u root -e "ansible_password=$pwd" -m user \
-a "name=ansible state=present shell=/bin/bash groups=wheel"

ansible all -u root -e "ansible_password=$pwd" -m copy \
-a "dest=/etc/sudoers.d/ansible content='ansible ALL=(ALL) NOPASSWD: ALL'"

ansible all -u root -e "ansible_password=$pwd" -m authorized_key \
-a "user=ansible state=present key={{lookup('file', '/home/ansible/.ssh/id_rsa.pub') }}"

ansible all -u ansible -m ping
