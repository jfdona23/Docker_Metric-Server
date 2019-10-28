#!/bin/bash
set -e

# Ensure access to influxdb user
chown -R influxdb:influxdb /var/lib/influxdb/data
chown -R influxdb:influxdb /var/lib/influxdb/meta
chown -R influxdb:influxdb /var/lib/influxdb/wal

# Patch init script in the start function
sed -i '142s/cat\ \$PIDFILE/pidof\ influxd/' /etc/init.d/influxdb

# Check for InfluxDB parameters
if [ "${1:0:1}" == '-' ]; then
    set -- influxd "$@"
fi

if [ "$1" == 'influxd' ]; then
  # Start InfluxDB in background
  /etc/init.d/influxdb start
  # Create default DB with Retention Policy
  echo "Creating DB..."
  influx -execute 'create database "home" with duration 365d name "casa_RP"'
  # Stop InfluxDB
  /etc/init.d/influxdb stop
fi

# Not Used
#influx -execute 'create database "rpi" with duration 7d name "rpi_RP"'
#influx -execute "create user \"collectd\" with password 'mypassword1234'"
#influx -execute 'grant all on "rpi" to "collectd"'

# Default
exec "$@"
