Installing instructions for spinning up a new AWX server.

1.	Install OS (minimal RedHat preferred or Centos 8 Stream)
2.	Configure with static IP
3.	dnf update -y
4.	systemctl disable firewalld --now
5.	setenforce 0
6.	vi /etc/selinux/config #disable selinux
7.	hostnamectl set-hostname <hostname>
8.	vi /etc/hosts #edit hosts
9.	#reboot server
10.	curl -sfL https://get.k3s.io | sudo bash -  #install kubernetes (k3s version from rancher)
11. install git make
12. git clone https://github.com/ansible/awx-operator.git
13. cd awx-operator
14. git checkout <branch number> e.g. 0.20.0
15. git branch
16. export NAMESPACE=awx
17. make deploy
18. kubectl get pods -n awx #check pod status
19. git clone https://github.com/ompragash/awx-deploy
20. cd awx-deploy
  # secrets 01-secret.yaml
21. cp /mnt/data-ssd/leewoodhouse.com.* ./ #copy cert into awx-deploy
22. kubectl -n awx create secret tls awx-secret-tls --cert=./leewoodhouse.com.pem --key=./leewoodhouse.com.key --dry-run=client -o yaml
23. # copy output and paste into 01-secret.yaml
24. kubectl apply -f 01-secret.yaml
  # persistent vols 02-pv.yaml
25. mkdir -p /data/postgres
26. mkdir -p /data/projects
27. chmod 755 /data/postgres
28. chown 1000:0 /data/projects
29. kubectl apply -f 02-pv.yaml
  # persistent volume claim 03-pvc.yaml
30. kubectl apply -f 03-pvc.yaml
  # awx object 04-awx.yaml
31. # edit hostname entry in manifest file 04-awx.yaml
23. # set replicas count default 3
34. kubectl apply -f 04-awx.yaml
  # check deployment logs whilst deploying
35. kubectl -n awx logs -f deployments/awx-operator-controller-manager -c awx-manager
  # check awx objects on completion of deployment
36. kubectl get awx -n awx
37. kubectl get all -n awx
