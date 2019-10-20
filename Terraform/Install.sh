#!/bin/sh 

user=ubuntu
pem_path=../keys/Web_SP.pem
dockergit_v2_path=scripts/Install_Docker_Git_2.sh
up_jenkins_path=scripts/up_Jenkins.sh
ansible_path=../Ansible
scripts_path=scripts

echo "################# "
echo " Terraform init"
echo "################# "
echo " "
sleep 1

terraform init

echo "################# "
echo " terraform apply"
echo "################# "
echo " "
sleep 1

terraform apply -auto-approve


echo " "
echo "################# "
public_dns=`terraform output instance_public_dns`  
echo " "


echo " "
echo "*** Wait a moment ***"
echo " "

sleep 25

ssh-keyscan -T 240 $public_dns >> ~/.ssh/known_hosts 


echo " "
echo "########################################## "
echo "#  copy the public dns to ansible hosts  #"
echo "########################################## "
echo " "
sleep 1

echo "$public_dns ansible_python_interpreter=/usr/bin/python3 ansible_ssh_private_key_file=../keys/Web_SP.pem ansible_user=ubuntu" > $ansible_path/hosts  


echo "################################################################## "
echo "# installing the Docker, Docker-compose and Git with --- ANSIBLE #"
echo "################################################################## "
echo " "
sleep 1

ansible-playbook $ansible_path/docker_ubuntu.yml -i $ansible_path/hosts

echo " "
echo "################################ "
echo "#     change permission        #"
echo "################################ "
echo " "
sleep 1
scp -i $pem_path $scripts_path/permission.sh $user@$public_dns:

sleep 1
ssh -i $pem_path $user@$public_dns './permission.sh'

echo "################################ "
echo "# copy the script up_Jenkins   #"
echo "################################ "
echo " "
sleep 1

scp -i $pem_path $up_jenkins_path $user@$public_dns:

echo "################################## "
echo "# Start Script Container Jenkins #"
echo "################################## "
echo " "
sleep 1

ssh -i $pem_path $user@$public_dns 'nohup ./up_Jenkins.sh &'

echo ""
echo ""
echo ""
echo "############################# "
echo ""
echo "#  :::Script Finalizado:::  #"
echo ""
echo "############################# "
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "PARA ACESSAR SEU NOVO SERVIDOR EXECUTE: "
echo "--------------------------------------- "
echo "ssh -i $pem_path $user@$public_dns" 
echo ""
echo ""
echo "PARA VISUALIZAR OS CONTAINERS INICIADOS EXECUTE: "
echo "--------------------------------------- "
echo "ssh -i $pem_path $user@$public_dns 'docker ps -a'" 
echo ""
echo ""
echo "PARA ACESSAR A CONSOLE DO JENKINS EXECUTE: "
echo "--------------------------------------- "
echo "$public_dns:8080"
echo ""
echo ""
echo ""
