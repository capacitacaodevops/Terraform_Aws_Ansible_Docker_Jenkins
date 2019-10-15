#!/bin/sh


echo "########################"
echo " Pull container Jenkins"
echo "########################"
echo""
sleep 1

docker pull diellyr/docker_jenkins_v4

sleep 1

nohup docker run -e JENKINS_INSTALL=$(pwd) -i --name jenkins -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50000:50000  diellyr/docker_jenkins_v4 &

