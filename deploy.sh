#!/bin/bash

repo=$1
name=$2

cd "/home"
rm -rf $name
git clone $repo $name
cd $name
./deploy.sh
