Mediawiki Installation on AWS using Ansible Playbook: 
========================================================


What's Covered:
----------------
 - Terraform Module that does the following: 
 	- 1 VPC
 	- 4 Subnets  
 	- 1 Keypair 
 	- 2 EC2 Instances - 1 Web and 1 DB
 	- 1 Elastic Load Balancer
   
 - Ansible Playbook that performs the following: 
    - Performs the Installation of the MySQL Database
    - Creates the Database and Users and other Validations. 
    - Role that installs Apache HTTPD, PHP from third-party repositories.
    - Configures the webserver
    - Makes it ready for the Launch on the browser. 


Assumptions/Pre-Requisites: 
---------------------------
1. Terraform is installed and the PATH is set. 
	Tip:
	```
	If not, download the setup using the instructions in the link below: 
	https://www.terraform.io/intro/getting-started/install.html
	```
2. AWS Secret variables are set: 
	Tip:
	```
	export AWS_ACCESS_KEY_ID='****'
	export AWS_SECRET_ACCESS_KEY='***'
	```
3. Python 2.7+ and Ansible 2.x is installed
	Tip: If you are on centos like platform, perform the below with sudo privs. 
	```
	wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	rpm -ivh epel-release-6-8.noarch.rpm
	yum install ansible -y
	```
	More info on: 
	https://docs.ansible.com/ansible/devel/installation_guide/intro_installation.html

Steps to setup
---------------
1. Clone and switch the directory to the Repository. 

2. Navigate to the folder: mediawiki_infra:

	``` cd mediawiki_infra```
3. Initialize the working directory.:

    ```terraform init```
4. Create a plan and save it to the local file tfplan: 

	```terraform plan -out=tfplan``` 
5. Apply the plan stored in the file tfplan.
	```terraform apply -input=false tfplan -auto-approve``` 
6. Run Ansible Playbook:

	```cd ..\ansible ```

  ```ansible-playbook main.yml```

7. Open the Browser and complete the installation wizard. 