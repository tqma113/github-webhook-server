#!/bin/bash

repo=$1
name=$2

cd /home
rm -rf $name
git clone $repo $name
cd $name
chmod 755 ./deploy.sh
./deploy.sh
