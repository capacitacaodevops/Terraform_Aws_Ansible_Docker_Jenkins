#!/bin/bash

nohup docker run -i --name mario -p 8081:8080 pengbai/docker-supermario &
