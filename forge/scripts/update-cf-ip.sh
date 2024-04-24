#!/bin/bash

CONFIG_FILE=/etc/nginx/conf.d/cloudflare.conf
ipv4=$(curl -L https://www.cloudflare.com/ips-v4)
ipv6=$(curl -L https://www.cloudflare.com/ips-v6)

echo '' > $CONFIG_FILE

for ip in $ipv4
do
    echo "set_real_ip_from $ip;" >> $CONFIG_FILE
done

for ip in $ipv6
do
    echo "set_real_ip_from $ip;" >> $CONFIG_FILE
done

echo "real_ip_header X-Forwarded-For;" >> $CONFIG_FILE
echo "" >> $CONFIG_FILE

nginx -t && systemctl restart nginx
