#!/bin/bash

set -x
#####################################################################################
# Author: Anil
# Date: 26-8-23
# Version : 1.0
# Ansible Playbook Automation
#
# Pre-requisites:
# Create new Ubuntu EC2 instance for installing Ansible, just open port 22.
#####################################################################################
# Change Host Name to AnsibleMgmtNode
sudo hostnamectl set-hostname AnsibleMgmtNode

# Update Repository
sudo apt-get update

#Install Ansible:
sudo apt-get install -y ansible

# Install Python-pip3:
sudo apt install python3-pip -y
# ( this is just comment -  Package manager for python)

# Install Boto Framework - AWS SDK
sudo pip3 install boto boto3
# Ansible will access AWS resources using boto SDK.

sudo apt-get install python3-boto -y
pip list boto | grep boto
# (the above command should display below output)
# Ignore warning in Red color.

ansible --version

#####################################################################################
# Author: Anil
# Date: 26-8-23
# Version : 1.0
# Ansible Playbook Automtaion
#
# Pre-requisites:
# Ansible Playbook for provisioning a new EC2 instance in AWS | 
#Create new EC2 instance in AWS cloud using Ansible Playbook
#####################################################################################
# Steps to create EC2 instance using Ansible:

# Login to EC2 instance using Git bash or ITerm/putty where you installed Ansible.

# Here provide EC2adminfullacces : IAM role and attach it to your ansible ec2 machine
# Execute the below command:


# Create an Inventory file first
sudo mkdir /etc/ansible

# Edit Ansible hosts or inventory file
sudo vi /etc/ansible/hosts
# Add the below two lines in the end of the file:
# [localhost]
# local                   (output)

cd ~
mkdir playbooks  
cd playbooks


# Create Ansible playbook
sudo vi create_ec2.yml 
# (copy the below content in green color)
# edit the create_jenkins_ec2.yml to make sure you update the key which is red marked below:

---
# - name:  provisioning EC2 instances using Ansible
#   hosts: localhost
#   connection: local
#   gather_facts: False
#   tags: provisioning
#
#   vars:
#     keypair: anil2
#     instance_type: t2.small
#     image: ami-0f5ee92e2d63afc18
#     wait: yes
#     group: webserver
#     count: 1
#     region: ap-south-1
#     security_group: my-jenkins-security-grp
   
#   tasks:

#     - name: Task # 1 - Create my security group
#       local_action: 
#         module: ec2_group
#         name: "{{ security_group }}"
#         description: Security Group for webserver Servers
#         region: "{{ region }}"
#         rules:
#            - proto: tcp
#              from_port: 22
#              to_port: 22
#              cidr_ip: 0.0.0.0/0
#            - proto: tcp
#              from_port: 8080
#              to_port: 8080
#              cidr_ip: 0.0.0.0/0
#            - proto: tcp
#              from_port: 80
#              to_port: 80
#              cidr_ip: 0.0.0.0/0
#         rules_egress:
#            - proto: all
#              cidr_ip: 0.0.0.0/0
#       register: basic_firewall
#     - name: Task # 2 Launch the new EC2 Instance
#       local_action:  ec2 
#                      group={{ security_group }} 
#                      instance_type={{ instance_type}} 
#                      image={{ image }} 
#                      wait=true 
#                      region={{ region }} 
#                      keypair={{ keypair }}
#                      count={{count}}
#       register: ec2
#     - name: Task # 3 Add Tagging to EC2 instance
#       local_action: ec2_tag resource={{ item.id }} region={{ region }} state=present
#       with_items: "{{ ec2.instances }}"
#       args:
#         tags:
#           Name: MyTargetEc2Instance

# now execute the ansible playbook by
ansible-playbook create_ec2.yml

#####################################################################################
# Author: Anil
# Date: 26-8-23
# Version : 1.0
# Ansible Playbook Automtaion
#
# Pre-requisites:
# Terminate EC2 instances Ansible Playbook Example | How to terminate EC2 instances using Ansible playbook?
#####################################################################################

# Login to EC2 instance using Git bash or ITerm/putty where you installed Ansible. Execute the below command to edit Ansible hosts or inventory file
sudo vi /etc/ansible/hosts 

# Add the below two lines in the end of the file:
[localhost]
local

# save the file and come out of it.

# sudo vi terminate.yml 
---
# - name: ec2 provisioning using Ansible
#   hosts: local
#   connection: local
#   gather_facts: False
#
# - hosts: local
#   gather_facts: False
#   connection: local
#   vars:
#     - region: 'us-east-1'
#     - ec2_id: 'i-05f39cfb80c97df38'
#   tasks:
#     - name: Terminate instances
#       local_action: ec2
#         state='absent'
#         instance_ids='{{ ec2_id }}'
#         region='{{ region }}'
#         wait=True
#
# This playbook can be executed by two ways. Either mention instance ID in the ansible playbook or pass as an argument. Intstance Id can be taken from AWS mgmt console.

# ansible-playbook terminate.yml -e ec2_id=i-xxxx
# PLAY [ec2 provisioning using Ansible] *********************************************************************
# PLAY [local] **********************************************************************************************
# TASK [Terminate instances] ********************************************************************************
# ok: [local -> localhost]

# PLAY RECAP ************************************************************************************************
# local                      : ok=1    changed=0    unreachable=0    failed=0



#####################################################################################
# Author: Anil
# Date: 26-8-23
# Version : 1.0
# Ansible Playbook Automation
#
# Pre-requisites:
# How to setup Jenkins on Ubuntu using Ansible playbook | Setup Java, Jenkins, Maven on Ubuntu EC2 using Ansible Playbook
#####################################################################################

# Pre-requisites:
# Setup Ansible on your EC2 instance.
# Java 11 Playbook
# https://www.cidevops.com/2020/04/ansible-playbook-for-java-11.html

# Jenkins Playbook
# http://www.cidevops.com/2018/05/install-jenkins-using-ansible-playbook.html

# Maven Playbook
# https://www.cidevops.com/2019/01/install-maven-using-ansible-playbook-on.html


#####################################################################################
# Author: Anil
# Date: 26-8-23
# Version : 1.0
# Ansible Playbook Automation
#
# Pre-requisites:
# How to run Ansible playbook from Jenkins pipeline job | Automate EC2 provisioning in AWS using Jenkins and Ansible Playbook |
# Create new EC2 instance in AWS cloud using Ansible Playbook and Jenkins Pipeline
#####################################################################################

# Pre-requisites:

# Ansible is installed and Boto is also installed on Jenkins instance
# Ansible plug-in is installed in Jenkins. 

# Make sure you create an IAM role with AmazonEC2FullAccess policy and attach the role to Jenkins EC2 instance.
# Playbook for creating new EC2 instance needs to be created but you can refer my GitHub Repo

# Create Jenkins Pipeline 
# pipeline {
#    agent any

#    stages {
#        
#        stage ("checkout") {
#            steps {
#                        checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [],                                                     
#                        userRemoteConfigs: [[url: 'https://github.com/akannan1087/myAnsibleInfraRepo']]])         
#            }
#        }
#        stage('execute') {
#            steps {
#                //to suppress warnings when you execute playbook    
#                sh "pip install --upgrade requests==2.20.1"
#                // execute ansible playbook
#                ansiblePlaybook playbook: 'create-EC2.yml'
#            }
#        }
#    }
# }

# Execute Pipeline



#####################################################################################
# Author: Anil
# Date: 26-8-23
# Version : 1.0
# Ansible Playbook Automation
#
# Pre-requisites:
# Ansible playbook for AWS S3 bucket creation | How to create S3 bucket using Ansible in AWS Cloud
#####################################################################################

# We will learn how to create new S3 bucket using Ansible playbook and automate the execution using Jenkins Pipeline. 
# Pre-requisites:

# Ansible is installed and Boto is also installed on Jenkins instance
# Ansible plug-in is installed in Jenkins

# Make sure you create an IAM role with AmazonS3FullAccess policy and attach the role to Jenkins EC2 instance.

# Ansible playbook for AWS S3 bucket creation

# Steps:

# 1. Create Ansible playbook for S3 bucket creation

# (Sample playbook is available in my GitHub Repo, you can use that as a reference)

# 2. Create Jenkins Pipeline 

# pipeline {
#    agent any
#    stages {
#        
#        stage ("checkout") {
#            steps {
#                        checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [],                                                     
#                        userRemoteConfigs: [[url: 'https://github.com/akannan1087/myAnsibleInfraRepo']]])         
#            }
#        }
#        stage('execute') {
#            steps {
#                //to suppress warnings when you execute playbook    
#                sh "pip install --upgrade requests==2.20.1"
#                // execute ansible playbook
#                ansiblePlaybook 'create-s3.yml'
#            }
#        }
#    }
#}

Execute Pipeline
Pipeline Console output


# Playbook for creating S3 for your reference:

# create-s3.yml

# ---
# - name:  provisioning S3 Bucket using Ansible playbook
#   hosts: localhost
#   connection: local
#   gather_facts: False
#   tags: provisioning
#
#   tasks:
#     - name: create S3 bucket
#       s3_bucket:
#         name: myansibles3bucket312
#         state: present
#         region: us-east-1
#         versioning: yes
#         tags:
#           name: myansiblebucket
#           type: example
#       register: s3_url
#
#     - name: Display s3 url
#       debug: var=s3_url





















