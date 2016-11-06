#!/bin/bash

# Be in the right place.
DIR=$(dirname $0)
cd $DIR/..

# Make sure our copy of these files is up to date
git pull -q
echo "Deploying `git log | head -1`"

# Loop through files, rsync aggressively, but ignore certain files
rsync -avd \
  --exclude '/etc/salt/keys/*' \
  --exclude '/etc/salt/pki/*' \
  ./etc/salt /etc/ 

rsync -avd \
  ./srv / 

# Populate the aws keys
AWS_ID=$(grep "aws_access_key_id" ~/.aws/credentials | head -1)
AWS_KEY=$(grep "aws_secret_access_key" ~/.aws/credentials | head -1)

if [ AWS_ID != '' ] ; then
  sed -i "s/@AWS_ACCESS_KEY_ID@/${AWS_ID}/" /etc/salt/cloud.providers.d/salt-demo.conf
  sed -i "s/@AWS_SECRET_ACCESS_KEY@/${AWS_KEY}/" /etc/salt/cloud.providers.d/salt-demo.conf
fi
