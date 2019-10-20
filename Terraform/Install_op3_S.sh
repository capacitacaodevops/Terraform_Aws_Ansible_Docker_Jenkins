#!/bin/sh 

user=ubuntu
pem_path=../keys/Web_SP.pem
dockergit_v2_path=scripts/Install_Docker_Git_2.sh
up_jenkins_path=scripts/up_Jenkins.sh

echo "################# "
echo " Terraform init"
echo "################# "

terraform init

echo "################# "
echo " terraform apply"
echo "################# "

terraform apply


echo "################# "
public_dns=`terraform output instance_public_dns`  
echo "################# "



echo " "
echo "wait a moment ***"
echo " "

sleep 25

ssh-keyscan -T 240 $public_dns >> ~/.ssh/known_hosts 


echo "######################################## "
echo "#  copy the script docker instalation  #"
echo "######################################## "
sleep 1

scp -i $pem_path $dockergit_v2_path $user@$public_dns:


echo "################################ "
echo "# copy the script up_Jenkins   #"
echo "################################ "
sleep 1

scp -i $pem_path $up_jenkins_path $user@$public_dns:

echo "################################################## "
echo "# installing the Docker, Docker-compose and Git  #"
echo "################################################## "
sleep 2

ssh -i $pem_path $user@$public_dns './Install_Docker_Git_2.sh'

echo "############################# "
echo "Start Script Container Jenkins"
echo "############################# "
sleep 10

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
