#!/bin/bash
set -e

# Function to safely modify a file
safe_sed() {
    # Arguments: 1=sed_expression, 2=filename
    # This method avoids the inode change that causes the "Device or resource busy" error
    sed "$1" "$2" > "$2.tmp"
    cp "$2.tmp" "$2"
    rm "$2.tmp"
}

# Apply fixes to apache config files
safe_sed "s/www.example.com/localhost/g" /etc/apache2/conf-enabled/pkp.conf
safe_sed "s/^#ServerName.*/ServerName localhost/g" /etc/apache2/apache2.conf

# Apply fixes to OJS config file
safe_sed "s/restful_urls = Off/restful_urls = On/g" config.inc.php
safe_sed "s/enable_cdn = On/enable_cdn = Off/g" config.inc.php

# Execute the original entrypoint logic (if any)
# Note: You may need to replace this with the original entrypoint's logic
# This is a placeholder for any other commands that need to run
exec "$@"