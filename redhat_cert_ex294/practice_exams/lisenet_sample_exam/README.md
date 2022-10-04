# Sample Exam for RHCE EX294
# copied from [www.lisenet.com](https://www.lisenet.com/2019/ansible-sample-exam-for-ex294/)

## Requirements

There are 18 questions in total.\
You will need five RHEL 8 virtual machines to be able to successfully complete all questions.\
One VM will be configured as an Ansible control node.\
Other four VMs will be used to apply playbooks to solve the sample exam questions.

The following FQDNs will be used throughout the sample exam:
- ansible-control.hl.local – Ansible control node
- ansible2.hl.local – managed host
- ansible3.hl.local – managed host
- ansible4.hl.local – managed host
- ansible5.hl.local – managed host

There are a couple of requirements that should be met before proceeding further:
- ansible-control.hl.local server has passwordless SSH access to all managed servers (using the root user).
- ansible5.hl.local server has a 1GB secondary /dev/sdb disk attached.
- There are no regular users created on any of the servers.
