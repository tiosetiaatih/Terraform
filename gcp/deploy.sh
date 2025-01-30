### Provisioning digunakan didalam container
### Menggunakan ssh-key metadata bukan os-login

#!/bin/bash

VM_NAME="$1"
ZONE="$2"
VM_IP="$3"
CONF_DIR="conf"  
USER="myuser"

if [ -z "$VM_IP" ]; then
  echo "Error: No VM IP provided."
  echo "Usage: ./provision_nginx.sh <vm-name> <zone> <vm-ip>"
  exit 1
fi

echo "Using VM IP: $VM_IP"

if [ ! -d "$CONF_DIR" ]; then
  echo "Error: Configuration directory $CONF_DIR not found."
  exit 1
fi

echo "Copying configuration files to VM..."
scp -r -i ~/.ssh/id_rsa "$CONF_DIR" $USER@$VM_IP:/tmp/

echo "Provisioning NGINX container..."
ssh -i ~/.ssh/id_rsa $USER@$VM_IP << EOF
  echo "Checking if NGINX container is running..."
  sudo docker ps -q -f name=nginx || { echo 'NGINX container not running'; exit 1; }

  echo "Copying nginx.conf to container..."
  sudo docker cp /tmp/conf/nginx.conf \$(sudo docker ps -q -f name=nginx):/etc/nginx/nginx.conf

  echo "Copying vhosts/ to container..."
  sudo docker cp /tmp/conf/vhosts \$(sudo docker ps -q -f name=nginx):/etc/nginx/conf/vhosts

  echo "Verifying NGINX configuration..."
  if ! sudo docker exec \$(sudo docker ps -q -f name=nginx) nginx -t; then
    echo "NGINX configuration test failed. Aborting reload."
    exit 1
  fi

  echo "Reloading NGINX configuration..."
  sudo docker exec \$(sudo docker ps -q -f name=nginx) nginx -s reload

  echo "Cleaning up temporary files..."
  rm -rf /tmp/conf/nginx.conf /tmp/conf/vhosts
EOF

echo "Provisioning completed successfully."