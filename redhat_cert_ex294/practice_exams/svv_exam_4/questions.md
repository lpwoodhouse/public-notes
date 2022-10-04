# Practice C Exam Questions for RHCE EX294

## Taskk 1: Setting up Inventory

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

## Practice Exam C Specific Tasks

## Task 1:

- Write a playbook that detects storage devices and writes a report with device names to the file /tmp/devices.txt. This file should meet the following requirements:
  - Support must be offered for a diversity of storage device names, such as /dev/sda and /dev/vda.
  - For each host, the file should have the line “primary device DEVICENAME found on HOSTNAME,” where DEVICENAME is replaced with the actual name of the device and HOSTNAME is replaced with the actual name of the host.
  - If a second disk device is found, the file should have the line “second device DEVICENAME found on HOSTNAME.”
  - If no second disk device is found, the file should have the line “no seconddevice found on HOSTNAME.”

## Task 2:

- Write a playbook that sets up storage and meets the following requirements:
  - If a second disk is found, a volume group with the name vgfiles should be created. This volume group may use all available disk space.
  - If no second disk is found, the playbook should print the line “no work to do” and fail further task execution on this host.
  - An LVM logical volume with the name lvfiles and a size of 1 GB should be created.
  - The LVM logical volume should be formatted with an XFS file system.
  - The LVM logical volume should be persistently mounted on the directory /lvfiles.

## Task 3:

- Write a playbook that generates a file with the name /tmp/hosts, based on discovered inventory information.
- The file must have the same format as the /etc/hosts file.

## Task 4:

- Write a requirements file that installs the nginx role and the docker role created by geerlingguy and is available on galaxy.ansible.com.

## Task 5:

- Write a playbook that installs, starts, and enables the httpd service.
- Ensure the httpd service is listening on port 88 and is accessible through the firewall.
- In the same playbook, write a play that tests access to the service and prints an error message if the service could not be accessed.

## Task 6:

- Write a playbook that uses the RHEL system role to synchronize time on all managed servers.
- Ensure that time is synchronized with the pool.ntp.org servers.
