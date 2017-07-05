#!/bin/sh

export director_name=$1
export internal_ip=$2

echo "Getting latest BOSH CLI v2"
wget https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.26-linux-amd64 -P /home/vcap/app -O bosh2
sleep 5

echo "Setting proper permissions on Bosh CLI"
cd /home/vcap/app && chmod +x bosh2 

/usr/bin/git clone https://github.com/cloudfoundry/bosh-deployment && echo "Done cloning bosh-deployment" 
sleep 5

echo "Creating new BOSH Environment"
/home/vcap/app/bosh2 create-env /home/vcap/app/bosh-deployment/bosh.yml \
    --state=state.json \
    --vars-store=creds.yml \
    -o bosh-deployment/aws/cpi.yml \
    -v director_name=${director_name} \
    -v internal_cidr=${internal_cidr} \
    -v internal_gw=${internal_gw} \
    -v internal_ip=${internal_ip} \
    -v access_key_id=${access_key_id} \
    -v secret_access_key=${secret_access_key} \
    -v region=${region} \
    -v az=${az} \
    -v default_key_name=${default_key_name} \
    -v default_security_groups=[${default_security_group}] \
    --var-file private_key=/home/vcap/app/${private_key} \
    -v subnet_id=${subnet_id}
