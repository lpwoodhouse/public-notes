# Advanced Ansible Control
## Documentation, Vault, Local Facts, Handlers, Errors, SELinx Context, Jinja2 Templates

Adhoc Syntax
```shell
ansible -i <inventory> <group/host> -m <module> -a "<arguments>" -u <user> -k <ask-pass>
```
Documentation
```shell
# search list of modules
ansible-doc -l | grep <search_term>
# show module snippet
ansible-doc -s <module>
# show module use examples (quick - show 100 lines)
ansible-doc <module> | grep EXAMPLES -A 100
# show module use examples (elegant - show all examples)
ansible-doc <module> | sed -n '/EXAMPLES/,/RETURN/{/RETURN/!p}'
```
Ansible Vault
```shell
# command line switches
--ask-vault-pass 
--vault-password-file=<path>

# vault password file variable
# ensure file is protected ie. chmod 600
vault-password-file: <path>
```
Custom Local Facts (on managed node)
```ini
/etc/ansible/facts.d/<name>.fact

[fact_name]
var1: value
var2: value
...etc...
```
```shell
# addressing a local fact variable
ansible_local.<name>.<fact_name>.var1
```
Handlers
```shell
notify: <handler_task> #notify a handler to run at end of current play
changed_when: <condition> #allow handler to run when normally it wouldn't
force_handlers: yes #forces a notified handler to run even if another task fails
- meta: flush_handlers #runs notified handlers before end of current play
```
Error Handling
```yaml
# basic
ignore_errors: yes
failed_when: <conditional>
```
```yaml
# fail module example
- name: print error message
  fail:
    msg: the task failed because.....
  when: "'condition' in registered_var.err"
```
```yaml
# using blocks
block:
rescue:
always:
```
SELinux File Context
```yaml
~/sefcontext_example.yml

---
- name: show selinux
  hosts: all
  tasks:
  - name: install required packages
    yum:
      name: policycoreutils-python-utils
      state: present
  - name: set selinux context
    sefcontext:
      target: /tmp/testdir
      setype: tmp_t
      state: present
    notify:
      - run restorecon
  handlers:
  - name: run restorecon
    command: restorecon -vR /tmp/testdir
```
```shell
# verify result with adhoc play
ansible all -a "ls -lZ /tmp/testdir"
```
Jinja2 Templates and Control Structures
```shell
# control structure (for loop) helps build an /etc/hosts jinja2 template from all hosts in inventory

{% for host in groups['all'] %}
{{ ansible_default_ipv4.address }} {{ ansible_fqdn }} {{ ansible_hostname }}
{% endfor %}
```
```shell
# control structure (if statement) on variable logrotate_compress

{% if logrotate_compress %}
# Logs compressed
compress
{% else %}
# Logs not compressed
{% endif %}
```
> N.B. Use ansible_managed = "Managed by Ansible" as a variable in ansible.cfg and include the variable {{ansible_managed}} in a template to inform users the file is managed by ansible.

