#!/bin/bash

repo=$1
name=$2

echo "publish $name from $repo"
cd /home

rm -rf $name
if [[ ! -d "/$name" ]]
then
  echo "New project $name and $repo"
else
  cd $name
  git reset --hard origin/main
  git clean -f
  git pull
  git checkout main
fi

chmod 755 `/home/$name/deploy.sh`
`/home/$name/deploy.sh`
