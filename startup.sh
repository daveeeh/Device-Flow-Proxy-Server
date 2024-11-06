#!/bin/bash

echo "Copying custom nginx.conf over to /etc/nginx/sites-available/default.conf"

NGINX_CONF=/home/site/wwwroot/nginx.conf

if [ -f "$NGINX_CONF" ]; then
    cp $NGINX_CONF /etc/nginx/sites-available/default
    service nginx reload
else
    echo "File does not exist, skipping cp."
fi

php composer.phar