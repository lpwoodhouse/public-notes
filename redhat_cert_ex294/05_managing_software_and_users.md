# Managing Software and Users

### Managing Software
Useful software to install on control node:<br>
dnf-utils<br>
createrepo<br>
vsftpd<br>

Userful modules for managing packages:<br>
package/yum/dnf:<br>
yum_repository:<br>
package_facts:<br>
rpm_key<br>
redhat_subscription:<br>
rhn_register:<br>
rhn_channel:<br>

### Managing Users
Useful modules for managing users:<br>
user:<br>
group:<br>
pamd:<br>
openssh_keypair:<br>
authorized_key:<br>
lineinfile:<br>

Create Encrypted Password
```shell
ansible localhost -m debug -a "msg={{ 'password' | password_hash('sha512', 'mysecretsalt') }}
```
Example using authorized_key module
```yaml
tasks:
- name: distribute public key
  authorized_key:
    user: "{{ user }}"
    key: "{{ lookup( 'file', '/home/' + {{ user }} + '/.ssh/id_rsa.pub' ) }}"
```
Example Jinja2 Template for sudoers config
```yaml
# variables defining groups to be created on managed node
sudo_groups:
  - name: devs
    sudo: false
  - name: admins
    sudo: true
  - name: dbas
    sudo: false
```
```ini
# jinja2 control template incorporating if statement embedded in for loop
{% for item in sudo_groups %}
{% if item.sudo %}

%{{item.name}} ALL=(ALL) NOPASSWD: ALL

{% endif %}
{% endfor %}
```
