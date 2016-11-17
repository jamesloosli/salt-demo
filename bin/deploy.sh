#!/bin/bash

# This deploys code to a saltmaster, running locally on macOS
# It does not restart the salt-master daemon

# Be in the right place.
DIR=$(dirname $0)
cd $DIR/..

# Make sure our copy of these files is up to date
git pull -q
echo "Deploying `git log | head -1`"

# Loop through files, rsync aggressively, but ignore certain files
echo "Syncing salt configs"
sudo rsync -aid \
  --exclude '/etc/salt/keys/*' \
  --exclude '/etc/salt/pki/*' \
  ./etc/salt /etc/

sudo rsync -aid \
  ./srv / 

# Populate the aws keys
echo "Populating aws keys"
AWS_ID=$(grep "aws_access_key_id" ~/.aws/credentials | head -1 | awk '{ print $3 } ')
AWS_KEY=$(grep "aws_secret_access_key" ~/.aws/credentials | head -1 | awk '{ print $3}')

if [[ ! -z $AWS_ID ]] ; then
  bash -c "sed -i '' 's^@AWS_ACCESS_KEY_ID@^${AWS_ID}^' /etc/salt/cloud.providers.d/salt-demo.conf"
  bash -c "sed -i '' 's^@AWS_SECRET_ACCESS_KEY@^${AWS_KEY}^' /etc/salt/cloud.providers.d/salt-demo.conf"
fi
