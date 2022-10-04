# Sample Exam Questions for RHCE EX294

## Task 1: Setting up Inventory

- Configure the control host with a static inventory, as well as the ansible.cfg configuration file. In the static inventory, configue the following host groups:
  - Group 'test' with ansible1.example.com as a member
  - Group 'dev' with ansible2.example.com as a member
  - Group 'prod' with ansible3 and ansible4 as members
  - Group 'servers' with groups 'dev' and 'prod' as members
- Ensure that hosts can be reached through their FQDN, but also by using the short name (so ansible1.example.com as well as ansible1)

## Task 2: Setting up a Repository Server

- Create a playbook with the name 'setupreposerver.yml' to set up the control host as a repository host. Make sure this host meets the following requirements, which all must be done by the playbook:
  - The RHEL 8 installation ISO must be loop mounted on the directory /var/ftp/repo
  - The firewalld service is disabled
  - The vsftpd service is started as well as enabled, and allows anonymous user access to the /var/ftp/repo directory

## Task 3: Setting up Repositories

- Create a script that configures the managed servers as repository clients to the repository server that you have set up in the previous task. This script must use ad-hoc commands, and perform the following tasks:
  - Disable any currently existing repository
  - Enable access to the BaseOS repository on control.example.com
  - Enable access to the AppStream repository on control.example.com

## Task 4: Configuring Managed Hosts

- Create a script with the name 'setuphosts.sh' that uses ad hoc commands to complete configuration on the managed servers. This includes:
  - Installing Python
  - Creating a user with the name 'ansible'
  - Creating a sudo configuration that allows user ansible to run tasks with root privileges
  - As the last command in this script, an ad-hoc command should be used to call the appropriate module to test connectivity to the remote hosts

## Task 5: Managing File Content

- Use an automated solution to create the contents of the /etc/hosts file on all managed hosts based on information that was found from the Inventory.<br>
Tip! Use Templates and Ansible Facts

## Task 6: Working with Roles

- Create a custom role to configure SSH. Make sure that it contains the following elements:
  - A template file for the sshd_config, where the SSH port, AllowedUsers, and PermitRoot parameters are managed through variables (which must be set when calling the role from the playbook)
- Create a playbook that calls the roles before calling the role, the playbook should ensure that SELinux is in enforcing state. Further, the playbook must define variables to set the SSH port to 2022, and AllowedUsers to the user Ansible.
- Ensure the role is only called when the OS family is set to RedHat.
- Also ensure that the firewall is opened, and the appropriate SELinux context is set on the port.

## Task 7: Creating Playbooks

- Create a playbook to set up ansible1.example.com as a web server. User another playbook to install wget and elinks on ansible2 and ansible3. For the playbooks, use the following instructions:
  - Create a host group webservers and a host group webclients to run the playbooks on the appropriate hosts.
  - Provide a sample vhost.conf file as a Jinja2 template. Copy it to the web/templates directory and ensure it is copied to all webservers. Use variables and/or facts to ensure the local hostname is used in the name of the vhost file, as well as all references to the local host.
  - Define the follwing variables and use them while setting up the web servers:
    - web_package: httpd
    - web_service: httpd
    - web_config_file: /etc/httpd/conf/httpd.conf
    - firewall_service: http
  - Ensure that the web server package is installed.
  - Ensure that the service is enabled and started.
  - Open a port in the firewalld firewall.
  - Copy the httpd.conf template file, using the following properties.
    - owner: root
    - group: root
    - permission mode: 0644
    - SELinux context: httpd_config_t
  - Use as handler to restart the web server after copying the configuration file.
- Create a playbook that sets up the web-client machines and installs curl and wget on them.
- Create a generic playbook with the name "web" which you can use to run both playbooks by using includes or imports.

## Task 8: Installing Roles from Galaxy

- Write a playbook with the name galaxyroles.yml. This playbook should meet the following requirements:
  - Use a requirements file to install the geerlingguy.redis and geerlingguy.nginx roles.
  - Make sure the current version of the role is installed, but if a newer version becomes available, this will NOT automatically be installed.
- Configure the playbook such that after running it, redis as well as nginx are available on ansible4.example.com

## Task 9: Generating a File

- Write a playbook that generates the motd file using a template. The motd file should write a welcome message, and a small report that lists the following items:
  - System memory
  - Processor count
  - Primary disk size
  - Secondary disk size
- The playbook should use facts to fill in the appropriate values. If the secondary disk is not available, the secondary disk size should be set to NOT AVAILABLE.

## Task 10: Using Encrypted Passwords

- Write a playbook with the name userpw.yml that creates a user lisa with an AES256 encoded password. Make sure this password is included from an Ansible Vault encrypted file.

## Task 11: Managing Storage

- Write a playbook with the name createvg.yml. It should create a 1GiB partition /dev/sdb1 on ansible1, and a 3 GiB partition /dev/sdb1 on ansible3. Next, it should setup a volume group on all hosts on which the disk /dev/sdb is defined.
- Write a playbook setuplv.yml that configures an LVM volume with the name lvdata in the vgdata volume group. The size of the volume must be 2000 MiB and the playbook should run on all servers. If the volume group vgdata does not exist, the playbook must show the message "vgdata does not exist". If the requested size is not available, the playbook must return the message "insufficient size".



