#!/bin/bash

read -sp 'root password?: ' pwd

ansible all -u root -e "ansible_password=$pwd" -m user \
-a "name=automation state=present shell=/bin/bash"

ansible all -u root -e "ansible_password=$pwd" -m lineinfile \
-a "path=/etc/sudoers.d/automation create=true line='automation ALL=(ALL) NOPASSWD: ALL'"

ansible all -u root -e "ansible_password=$pwd" -m authorized_key \
-a "user=automation state=present key={{ lookup('file', '/home/automation/.ssh/id_rsa.pub') }}"

ansible all -u automation -m ping
