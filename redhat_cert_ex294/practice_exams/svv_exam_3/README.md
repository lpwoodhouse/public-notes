# Sample Exam 3 for RHCE EX294
### taken from Sander von Vugt video course

## Basic Setup
To work through this exam, you need a total of 5 servers running RHEL 8 or CentOS 8.
- One server needs to be configured as control host
- The other 4 servers are configured as managed servers, using the names:
  - ansible1.example.com
  - ansible2.example.com
  - ansible3.example.com
  - ansible4.example.com
- The IP addresses used on the managed servers are not important, youcan pick anything that matches your configurations
- Make sure the servres meet the following requirements:
  - 1 GB or RAM
  - 20 GB disk space on the primary disk /dev/sda
  - 5 GB disk space on the secondary disk /dev/sdb (on ansible1 and ansible 3 only)
  - The root user account has been configured with the password 'password' on each server
  - The control server has a user account 'ansible'. SSH public and private keys have been generated for this user on control.example.com. No further configuration has been done yet.
  - In the assignments in this exam, you'll need to create scripts and yaml files. Make sure that all of these scripts are stored in the directory /home/anisble.
