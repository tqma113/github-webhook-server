#!/bin/bash

repo=$1
name=$2

echo "publish $name from $repo"
cd /home

if [[ ! -d "/$name" ]]
then
  git clone $repo $name
  cd $name
else
  cd $name
  git_repo_remote=$(git remote -v)
  if [[ $git_repo_remote == *$repo* ]]
  then
    git reset --hard origin/master
    git clean -f
    git pull
    git checkout main
  else
    cd ..
    rm -rf $name
    cd $name
  fi
fi

chmod 755 ./deploy.sh
./deploy.sh
