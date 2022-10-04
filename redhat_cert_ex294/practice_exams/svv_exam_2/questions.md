# Sample Exam 3 Questions for RHCE EX294

## Common Tasks

### Task 1: Setting up Inventory

- Configure the control host with a static inventory, as well as the ansible.cfg configuration file. In the static inventory, configue the following host groups:
  - Group 'test' with ansible1.example.com as a member
  - Group 'dev' with ansible2.example.com as a member
  - Group 'prod' with ansible3 and ansible4 as members
  - Group 'servers' with groups 'dev' and 'prod' as members
- Ensure that hosts can be reached through their FQDN, but also by using the short name (so ansible1.example.com as well as ansible1)

### Task 2: Setting up a Repository Server

- Create a playbook with the name 'setupreposerver.yml' to set up the control host as a repository host. Make sure this host meets the following requirements, which all must be done by the playbook:
  - The RHEL 8 installation ISO must be loop mounted on the directory /var/ftp/repo
  - The firewalld service is disabled
  - The vsftpd service is started as well as enabled, and allows anonymous user access to the /var/ftp/repo directory

### Task 3: Setting up Repositories

- Create a script that configures the managed servers as repository clients to the repository server that you have set up in the previous task. This script must use ad-hoc commands, and perform the following tasks:
  - Disable any currently existing repository
  - Enable access to the BaseOS repository on control.example.com
  - Enable access to the AppStream repository on control.example.com

### Task 4: Configuring Managed Hosts

- Create a script with the name 'setuphosts.sh' that uses ad hoc commands to complete configuration on the managed servers. This includes:
  - Installing Python
  - Creating a user with the name 'ansible'
  - Creating a sudo configuration that allows user ansible to run tasks with root privileges
  - As the last command in this script, an ad-hoc command should be used to call the appropriate module to test connectivity to the remote hosts

## Specific Tasks

### Task 1:

- Write a playbook that installs software packages:
  - Perl and php on servers in the groups dev, test, and prod
  - All packages from the package group "Virtualization Host" on the group prod
  - Servers in the group prod that are fully updated

### Task 2:

- Create a playbook that configures an LVM logical volume with the name lvdata in the volume group vgdata, according to the following requirements:
  - Only on servers in the group prod, create a 2 GiB volume group with the name "vgdata".
  - If the volume group vgdata does not exist, the playbook must return the massage "vgprod does not exist".
  - If the volume group exists but has less than 1 GiB storage availabled, the playbook must show the message "insufficient disk space available".

### Task 3:

- Create a playbook with the name sysreport.yml that generates a file on the ansible control server. The file should have the name hwtemplate.tst and the following contents:
```txt
NAME=
IPADDRESS=
TOTAL_MEMORY=
NIC_NAME=
SECOND_NIC_NAME=
```
- Use this file to generate a report on the managed servers. To do so, copy the file to /root/report.txt, and have your playbook modify it, but do not overwrite current settings. Apply the following requirements:
  - NAME= getst the FQDN of the managed host as argument.
  - IPADDRESS= gets the IP address of the managed host.
  - TOTAL_MEMORY= gets the total memory on the managed host.
  - NIC_NAME= gets the name of the network card on the host.
  - If the host has a second network card, SECOND_NIC_NAME should get the name of that network card. If the managed host has no second network card, the playbook should set SECOND_NIC_NAME=NONE.

### Task 4:

- Create a vault-encrypted file with the name anspass.txt. This file should set the variable devpass to the value 'password' and the variable prodpass to the value 'secret'.
- Set the vault password required to access this file to 'vaultpass'.
- Also create a vault password file with the name vaultpass.txt that can be used to automatically enter this password.
- After creating the vault-encrypted file, change the vault password to myvaultpass, and ensure it still can be used automatically.

### Task 5:

- Use the RHEL system role that manages time in a playbook with the name settime.yml.
- Ensure that control.example.com is used as the time server, and set the appropriate parameter that allows changing time even if a large difference exists between time on the managed machine and time on the time server.
- At the end of the playbook, verify that time is synchronized. If this is not the cse, the playbook should print the text 'Unfortunately time could not be synchronized".

### Task 6:

- Configure a playbook with the name runwebserver.yml that meets the following requirements:
  - Ensure that the webserver contents are accessible from other machines
  - Create a file /webcontent/index.html that contains the text "welcome to this webserver. The server is managed by USERNAME."
  - Use a variable to set USERNAME to anna. THe variable should be set by using inclusion of a file that is created for servers in the group prod only.
  - Create a symbolic link in /var/www/html/index.html that links to the file /webcontent/index.html, and ensure the contents of this file are visible from remote hosts.
