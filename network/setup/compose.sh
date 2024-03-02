#!/bin/bash

# Introduced in 1-4.3
sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
 
sudo chmod +x /usr/bin/docker-compose


echo "======= Done. PLEASE LOG OUT & LOG Back In ===="
echo "Then validate by executing    'docker-compose version'"