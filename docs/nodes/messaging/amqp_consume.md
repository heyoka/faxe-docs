The amqp_consume node
=====================

Consume data from an amqp-broker like rabbitmq.
When `prefetch` is given and is > 1, then this node will emit a data_batch instead of a data_point.


Example
-------
```dfs  
|amqp_consume()
.host('deves-amqp-cluster1.internal') 
.routing_key('my.routing.key')
.exchange('x_xchange')
.queue('faxe_test')
.dt_field('UTC-Time')
.dt_format('float_micro')
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| Ip address or hostname of the broker|
port( `integer` )| The broker's port | 5672 / from config file
user( `string` )| AMQP user | from config file
pass( `string` )| AMQP password | from config file
vhost( `string` )| vhost to connect to on the broker| '/'
routing_key( `string` )| routing key to use for queue binding|
queue( `string` )|name of the queue to bind to the exchange|
exchange( `string` )|name of the exchange to bind to the source exchange |
prefetch( `integer` )|prefetch count to use| 1
dt_field( `string` )|name of the timestamp field that is expected|'ts'
dt_format( `string` )|timestamp or datetime format that is expected (see table below)| 'millisecond'
ssl( is_set ) | whether to use ssl | false (not set)



Available datetime formats
--------------------------

dt_format    | description                                  | example
-------------|----------------------------------------------|-------------
'millisecond'|timestamp UTC in milliseconds                 |1565343079000
'second'     |timestamp UTC in seconds                      |1565343079
'float_micro'|timestamp UTC float with microsecond precision|1565343079.173588
'float_millisecond'|timestamp UTC float with millisecond precision|1565343079.173
'ISO8601'    |ISO8601 Datetime format string                |'2011-10-05T14:48:00.000Z'
'RFC3339'    |RFC3339 Datetime format string                |'2018-02-01 15:18:02.088Z'
'convtrack_datetime'|special datetime format used in the conveyor tracking data stream|'19.08.01  17:33:44,867  '

