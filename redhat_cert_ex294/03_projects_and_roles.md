# Ansible Projects and Roles
## Project and Role Directory Structure, Ansible Galaxy, Collections, Dependencies, Requirements, RHEL System Roles

Example Project Directory Structure
```yaml
project_dir/
    roles/
      role1/
      role2/
        defaults/
          main.yml <-- default vars that may be overwritten
        files/
          file.txt
          file.sh
        meta/
          main.yml <-- role information and dependencies
        vars/
          main.yml <-- role vars not meant to be overwritten
        tasks/
          main.yml <-- role master playbook
        handlers/
          main.yml <-- role handlers
        templates/
          file.conf.j2 <-- jinja2 templates
          
    group_vars/
      group1.yml <-- vars applied to group1
      group2.yml
      all/
        vault.yml <-- vars applied to all groups (encrypted with vault)
    host_vars/
      host1.yml <-- vars applied to host1
      host2.yml

    ansible.cfg <-- custom ansible.cfg
    inventory <-- custom inventory file
    site.yml <-- master playbook
```
Ansible Galaxy Roles
```shell
ansible-galaxy search <search_term> --author --platforms EL --galaxy-tags
ansible-galaxy info <role.name>
ansible-galaxy install <role.name>,<version>
ansible-galaxy remove <role.name>
ansible-galaxy list
```
```shell
# build custom role
ansible-galaxy init <name>
```
Role Precedence
```shell
./roles <-- project roles
~/.ansible/roles <-- default location for galaxy installed roles, put custom roles here if used in multiple projects
/etc/ansible/roles
/usr/share/ansible/roles <-- default location for rhel system roles
```
Requirements
```yaml
requirements.yml

---
- src: geerlingguy.nginx
  name: nginx
  version: 1.1.3
- src: file:///opt/local/roles/myrole.tar
  name: myrole
  version: 1.0.0
```
```shell
# to install roles from requirements.yml
ansible-galaxy install -r requirements.yml -p <install_path>
```
Dependencies
```yaml
# role dependencies defined in ./meta/main.yml in same format as requirements
---
dependencies:
- src: geerlingguy.nginx
- src: file:///opt/local/roles/myrole.tar
  name: myrole
  version: 1.0.0

galaxy_info:
...etc...
```
Collections
```yaml
# can be defined in same requirements.yml file as roles.
---
roles:
  - src: geerlingguy.nginx
collections:
  - name: ansible.posix
  - name: f5networks.f5_modules
    src: https://cloud.redhat.com/api/automation-hub/
  - name: community.vmware
  - name: ansible.netcommon
    src: https://galaxy.ansible.com
```
```shell
# to install collections from requirements.yml
ansible-galaxy collection install -r requirements.yml
```
```yaml
# include installed collections in playbook header as required

---
- name: example playbook
  hosts: localhost
  gather_facts: no
  collections:
  - ansible.posix
  tasks:
  - name: config selinux
    selinux:
...etc...
```
RHEL System Roles
```shell
# install 
yum install -y rhel-system-roles
```
>default install location /usr/share/ansible/roles/\
>documentation and example files in /usr/share/doc/rhel-system-roles/<role>
```shell
# tip: copy example file to project dir and modify
cp /usr/share/doc/rhel-system-roles/selinx/example-selinux-playbook.yml ~/<project_dir>
```
```yaml
# tip: define role vars in group_vars or host_vars
~/<project_dir>/group_vars/all/selinux_vars.yml
---
selinux_policy: targeted
selinux_state: enforcing
selinux_booleans:
  - { name: 'samba_enable_home_dirs', state: 'on' }
  - { name: 'ssh_sysadm_login', state: 'on', persistent: 'yes' }
```
