The influx_out node
=====================

Write data to [InfluxDB](https://docs.influxdata.com/influxdb/v1.8/) via it's HTTP API.
This node supports InfluxDB up to version 1.8.
 
If any errors occur during the request, the node will attempt to retry sending.

Since FAXE and InfluxDB share the notion of `tags`, this node will write all fields to InfluxDB fields and all tags as
Influx tags.

If you want to control which fields and tags get written to the database, use one of the flowdata-nodes,
ie. use [delete](../flowdata/delete.md) to
delete some fields and/or tags before writing data with this node.


Note: it is recommended to [batch](../flowdata/batch.md) single data-points.

Example
-------

Simple:
```dfs   

|influx_out()
.host('127.0.0.1')
.port(8086)
.measurement('m1')
.database('mydb') 

```


Use delete and batch before writing to InfluxDB:
```dfs 

|delete()
.fields('calc.avg_temp')
.tags('is_on', 'color')

|batch(25)
.timeout(3s)

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
 