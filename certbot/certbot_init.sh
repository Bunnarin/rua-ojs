#!/bin/sh


set -e

# Use netcat (nc) to check port 80, and keep checking every 5 seconds
# until it is available. This is so nginx has time to start before
# certbot runs.
until nc -z ojs 80; do
    echo "Waiting for apache..."
    sleep 5s & wait ${!}
done

echo "Getting certificate..."

certbot certonly \
    --webroot \
    --webroot-path "/vol/www/" \
    -d "$PROJECT_DOMAIN" \
    --email $CERTBOT_EMAIL \
    --rsa-key-size 4096 \
    --agree-tos \
    --noninteractive