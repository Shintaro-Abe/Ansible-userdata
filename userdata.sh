#!/bin/bash

Region=ap-northeast-1
Output=table

amazon-linux-extras enable ansible2
yum install -y ansible                       
yum install -y pip                          
sudo -u ec2-user -i pip install --upgrade pip
sudo -u ec2-user -i pip install boto
yum install -y expect
expect -c "
spawn sudo -u ec2-user -i aws configure
expect \"AWS Access Key ID : \"
send \"\n\"
expect \"AWS Secret Access Key : \"
send \"\n\"
expect \"Default region name : \"
send \"${Region}\n\"
expect \"Default output format : \"
send \"${Output}\n\"
expect \"$\"
exit 0
"
sed -i '12i interpreter_python = /usr/bin/python' /etc/ansible/ansible.cfg 
sed -i '13i host_key_checking = False' /etc/ansible/ansible.cfg 
sed -i '14i remote_user = ec2-user' /etc/ansible/ansible.cfg 
sed -i '15i private_key_file = ~/.ssh/abetest.pem' /etc/ansible/ansible.cfg 

sudo -u ec2-user -i mkdir ansible