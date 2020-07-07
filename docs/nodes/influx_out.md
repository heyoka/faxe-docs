The influx_out node
=====================

Write data to [InfluxDB](https://docs.influxdata.com/influxdb/v1.8/) via it's HTTP API.
This node supports InfluxDB up to version 1.8.
 
If any errors occur during the request, the node will attempt to retry sending.



Example
-------
```dfs   

|influx_out()
.host('127.0.0.1')
.port(8086)
.measurement('m1')
.database('mydb') 

```


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
host( `string` )| hostname or ip address of endpoint | from config file
port( `integer` )|port number| from config file
user( `string` )| username| from config file
pass( `string` )|password| from config file
tls( `is_set` ) | whether to use tls ie. https | false (not set)
database( `string` )| database name |  
measurement( `string` )| measurement name |
retpol( `string` ) | `retention policy` to write to | default
 