#!/bin/bash

app_name="webhook"
pm2 start "node ./index.js" --name $app_name
