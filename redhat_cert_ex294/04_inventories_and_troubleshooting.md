# Inventories and Troubleshooting
## Inventory yaml/ini format, Host wildcard syntax, Parallelism, Ansible Logs, Useful Troubleshooting modules
Can have multiple inventory files in a directory as the source
```shell
~/ansible.cfg
inventory = ~/inventory/

~/inventory/
  /webservers.yml
  /fileservers.yml
```
Exmaple Inventory
```yaml
# yaml format
---
nodes:
  hosts:
    node1.example.com:
      ansible_host: 10.0.0.164
    node2.example.com:
      ansible_host: 10.0.0.166
    node3.example.com:
      ansible_host: 10.0.0.167
```
```ini
# ini format
[nodes]
node1.example.com ansible_host=10.0.0.164
node2.example.com ansible_host=10.0.0.166
node3.example.com ansible_host=10.0.0.167
```
> NB. View an inventory in json format: ansible-inventory --list

Hosts wildcard syntax:
- hosts: '*.example.com'  <- any hosts ending example.com
- hosts: '192.168.*'  <- any hosts with ip beginning 192.168
- hosts: 'web*'  <- any hosts with hostname beginning with web
- hosts: web1,db1,192.168.4.2  <- comma separated list of hosts
- hosts: web,&eastcoast  <- members of group web & eastcoast
- hosts: web,!web1  <- members of group web but not web1
- hosts: all,!web  <- all hosts but not members of group web

Parallelism
```shell
# in ansible.cfg (default is 5 but can be much higher)
forks = n

# from command line
-f n
```
```shell
# other examples of useful statements/arguments
serial: 3        <- set batch size number or percentage of hosts
throttle: 1      <- restrict number of workers, must be lower than forks value
order: sorted    <- determin order in which hosts are processed (sorted,reverse_sorted,shuffle,reverse_inventory)
run_once: true   <- only run task against first host or use in conjuction with delegate_to:
delegate_to: localhost  <- task is delegated to run on localhost
```
Ansible Logging
```shell
# in ansible.cfg add variable
log_path = ~/ansible.log
```
```shell
# and consider using log rotation
~/etc/logrotation.d/ansible

/home/ansible/ansible.log {
  weekly
  rotate 4
  create
  compress
  dateext
}
```
Troubleshooting: stat and assert
```yaml
# example playbook using stat and assert modules
---
- name: stat assert example
  hosts: localhost
  gather_facts: no
  tasks:

  - name: get stats on /etc/hosts
    stat:
      path: /etc/hosts
    register: result

  - debug:
      var: result
      verbosity: 1

  - name: test /etc/hosts mode
    assert:
      that: result.stat.mode == "0644"
      success_msg: "file mode is correct"
      fail_msg: "file mode is incorrect"
    ignore_errors: yes
```
Troubleshooting: uri module
```yaml
# example playbook using uri module to test http connection to web server

---
- name: uri example
  hosts: ansnode1
  gather_facts: yes
  tasks:
    - name: test web server
      uri:
        url: "http://{{ansible_fqdn}}/index.html"
      register: result

    - debug:
        var: result
```
