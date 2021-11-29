The amqp_consume node
=====================

Consume data from an amqp-broker like [RabbitMQ](https://www.rabbitmq.com).

### In safe mode
Once a data-item is received by the node, it will be immediately stored in an on-disk queue for data-safety.
Only after this will the item be acknowledged to the amqp broker.

### Message deduplication
If the amqp `correlation-id` property is set (to a unique value per message), this node can perform efficient message deduplication.

See [amqp_publish](amqp_publish.md) for details on this.

-----------

## Prefetch count, ack_every and dedup_size
For a description of these settings, see table below.

As they relate to one another in some kind, here is a rule of thumb for how to set `ack_every` and `dedup_size`
when `prefetch` is changed:

* set `ack_every` to one third of `prefetch`
* set `dedup_size` to 3 times the `prefetch` value

Example: prefetch = 100, ack_every = 35, dedup_size = 300

-------------

At the moment this node can only set up and work with `topic` exchanges.


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
host( `string` )| Ip address or hostname of the broker| from config
port( `integer` )| The broker's port | 5672 / from config 
user( `string` )| AMQP user | from config 
pass( `string` )| AMQP password | from config 
vhost( `string` )| vhost to connect to on the broker| '/'
routing_key( `string` ) _deprecated_ | routing key to use for queue binding|undefined
bindings( `string_list` )| list of [queue bindings](https://www.cloudamqp.com/blog/part4-rabbitmq-for-beginners-exchanges-routing-keys-bindings.html) keys| [] 
queue( `string` )|name of the queue to bind to the exchange|
exchange( `string` )|name of the exchange to bind to the source exchange |
prefetch( `integer` )| [prefetch](https://www.rabbitmq.com/consumer-prefetch.html) count to use | 70
consumer_tag( `string` ) | Identifier for the queue consumer, defaults to a combination of flow-id and node-id | undefined
ack_every( `integer` )| number of messages to consume before acknowledging them to the broker | 20
ack_after( `duration` )| timeout after which all currently not acknowledged messages will be acknowledged, regardless of the `ack_every` setting | 5s
dedup_size( `integer` )| number of correlation-ids to hold in memory for message deduplication | 200
dt_field( `string` )|name of the timestamp field that is expected|'ts'
dt_format( `string` )|timestamp or datetime format that is expected (see table below)| 'millisecond'
include_topic ( `bool` ) |whether to include the routingkey in the resulting datapoints | true
topic_as ( `string` ) | if `include_topic` is true, this will be the fieldname for the routingkey value | 'topic' 
as ( `string` ) | base object for the output data-point | undefined
ssl( is_set ) | whether to use ssl, if true, ssl options from faxe's config for amqp connections will be used | false (not set)
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

