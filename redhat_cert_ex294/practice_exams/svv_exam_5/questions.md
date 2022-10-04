# Practice D Exam Questions for RHCE EX294

## Tasks 1-4 Same as Practice Exam C

## Task 5:

- Create playbooks to set up an http server, an http client, and a site playbook to run these playbooks according to the following requirements:
  - Configure the inventory file, such that ansible1 is part of the group webservers and ansible2 is part of the group webclients. (Add this to the existing inventory file.)
  - Ensure that the webclient.yml playbook installs the curl package. From the webserver.yml playbook, you need to install the httpd.conf web server.
  - Create a variables file that is called from both playbooks and is stored in the vars directory. In this file, the following variables must be set:
    - web_client: curl
    - web_server: httpd
    - web_config_file: /etc/httpd/conf/httpd.conf
  - Create a template file in templates/httpd.j2 and use the template module to deploy this template to the location that is defined by the web_config_file variable. No specific modifications are required in the template file.
  - Configure a handler that restarts the web server after successfully copying over the template.
  - Also, from the webclient.yml playbook, do the following:
    - Install the web server using the variables you have defined.
    - Open a port in the firewalld firewall to allow access to the web server.
    - In your project directory, create a site.yml file that includes these two playbook files.

## Task 6:

- Convert the playbook that you created in the previous task into an Ansible role.
- You will create a new playbook that calls this role in the next task.
- Create the role in the http project directory.

## Task 7:

- In the http project directory, create a playbook that activates the role and sets up storage according to the following requirements:
  - If a second disk is available, set up the second disk with a partition. The partition should use 100% of available disk space. If no second disk is available, the playbook should print the message “no second disk
available.”
  - Mount the new partition on the /web directory.
  - Set the SELinux type to httpd_sys_content_t on the /web directory.
  - Ensure that the file /web/index.html is created and shows the text “welcome to my custom web server.”
  - Use variables to refer to some items:
    - web_dir is set to /web.
    - welinux_type is set to httpd_sys_content_t.
    - web_file points to /web/index.html.
