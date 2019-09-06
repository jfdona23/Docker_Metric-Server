from influxdb
copy ./files/influxdb.conf /etc/influxdb/
copy ./files/init.sh /init.sh
copy ./files/types.db /usr/share/collectd/types.db
entrypoint ["/init.sh"] 
cmd ["influxd"]
