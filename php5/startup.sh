#!/bin/bash

# Function to update the fpm configuration to make the service environment variables available
function setEnvironmentVariable() {
    echo "$1 => $2"
    if [ -z "$2" ]; then
            echo "Environment variable '$1' not set."
            return
    fi

    # Check whether variable already exists
    if grep -q "env\[$1\]" /etc/php5/fpm/pool.d/www.conf; then
        # Reset variable
        ESCAPED=`echo "$2" | sed -e 's/[\\/&]/\\\\&/g'`
        sed -i "s/^env\[$1\].*/env[$1] = $ESCAPED/g" /etc/php5/fpm/pool.d/www.conf
    else
        # Add variable
        echo "env[$1] = $2" >> /etc/php5/fpm/pool.d/www.conf
    fi
}

# Grep for variables that look like docker set them (_PORT_)
for _curVar in `env | grep _PORT_ | awk -F = '{print $1}'`;do
    # awk has split them by the equals sign
    # Pass the name and value to our function
    setEnvironmentVariable ${_curVar} ${!_curVar}
done

# start php-fpm
service php5-fpm start

# start nginx
nginx