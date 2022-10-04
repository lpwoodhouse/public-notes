# Set Up An Ansible Managed Environment

All actions are carried out on the control node.<br>
There should be no need to access a console on any managed node unless root password in unknown.

Add ansible user, config sudo, install Python
```shell
useradd ansible
echo "password" | passwd --stdin ansible
echo -e "ansible\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/ansible
yum install -y python3 python3-pip
alternatives --set python /usr/bin/python3
su - ansible
```
Install Ansible
```shell
# upgrade pip
pip3 install -U pip --user
# install ansible
pip3 install ansible --user

# with subscription-manager
subscription-manager repos --list
subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms
yum install -y ansible

# verifiy installation
ansible --version
```

> now configure /etc/hosts for name resolution of managed nodes

Configure tab spacing on vim when editing yaml (optional)
```shell
echo "autocmd FileType yaml setlocal ai ts=2 sw=2 et" > ~/.vimrc
```
Customize ansible.cfg
```conf
~/.ansible.cfg

[defaults]
inventory = ~/inventory
remote_user = ansible
host_key_checking = false
deprecation_warnings = false

[privilege escalation]
become = true
become_user = root
become_method = sudo
become_ask_pass = false
```
Customize default inventory
```ini
~/inventory
    
[nodes]
node1.example.com
node2.example.com
node3.example.com
```
```shell
# verify default inventory is working
ansible all --list-hosts
```
Write and run playbook to set up managed nodes
```yaml
# assuming I have root access and managed nodes are connected to a working repo I would write something like this.

~/setup_managed_nodes.yml

---
- name: setup managed nodes
  hosts: all
  gather_facts: no
  vars_prompt:
  - name: username
    prompt: new user name
    private: no
  - name: userpass
    prompt: new user password
    private: yes
  tasks:
  - raw: |
      useradd {{username}};
      echo {{userpass}} | passwd --stdin {{username}}
      echo -e "{{username}}\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/{{username}};
      yum install -y python3;
      alternatives --set python /usr/bin/python3
```
```shell
# run playbook
ansible-playbook setup_managed_nodes.yml -u root -k
```
```yaml
# an alternative to using the raw module in the above playbook would be to use the script module
  tasks:
  - script: setup_nodes.sh {{username}} {{userpass}}
    ignore_errors: yes
```
```shell
~/setup_nodes.sh

#!/bin/bash
useradd $1
echo $2 | passwd --stdin $1
echo -e "$1\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/$1
yum install -y python3
alternatives --set python /usr/bin/python3
```
Generate SSH keys and copy key to managed nodes
```shell
su - ansible
ssh-keygen
### do not use a passphrase ###
ssh-copy-id node1.example.com
...etc...
```
Run adhoc ping test
```shell
ansible all -m ping
```
