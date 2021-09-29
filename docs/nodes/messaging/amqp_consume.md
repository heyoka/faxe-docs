The amqp_consume node
=====================

Consume data from an amqp-broker like `RabbitMQ`.

Once a data-item is received by the node, it will be immediately stored in an on-disk queue for data-safety.
Only after this will the item be acknowledged to the amqp broker.

At the moment this node can only setup and work with `topic` exchanges.


Example
-------
```dfs  
|amqp_consume()
.host('deves-amqp-cluster1.internal') 
.bindings('my.routing.key')
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
routing_key( `string` )| routing key to use for queue binding|undefined
bindings( `string_list` )| queue-bindings| [] 
queue( `string` )|name of the queue to bind to the exchange|
exchange( `string` )|name of the exchange to bind to the source exchange |
prefetch( `integer` )| prefetch count to use | 70
dt_field( `string` )|name of the timestamp field that is expected|'ts'
dt_format( `string` )|timestamp or datetime format that is expected (see table below)| 'millisecond'
include_topic ( `bool` ) |whether to include the routingkey in the resulting datapoints | true
topic_as ( `string` ) | if `include_topic` is true, this will be the fieldname for the routingkey value | 'topic' 
as ( `string` ) | base object for the output data-point | undefined
ssl( is_set ) | whether to use ssl | false (not set)
confirm ( `boolean` ) | whether to acknowledge consumed messages to the amqp broker, when set to `false`, throughput can be increased with the danger of data-loss| true
safe ( `boolean` ) | whether to use faxe's internal queue. If `true`, messages consumed from the amqp broker will be stored in an internal ondisc queue before they get sent to downstream nodes, to avoid losing data.| false

> Exactly one of these must be provided: `routing_key`, `bindings`.

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

