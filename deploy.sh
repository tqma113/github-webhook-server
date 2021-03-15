#!/bin/bash

app_name="webhook"
yarn install
yarn build
pm2 stop $app_name
pm2 delete $app_name
pm2 start "node ./index.js" --name $app_name
