The amqp_publish node
=====================

Publish data to an amqp-broker exchange like rabbitmq.
Incoming data is converted to JSON before sending.

Example
-------
```dfs  

|amqp_publish()
.host('127.0.0.1') 
.routing_key('my.routing.key')
.exchange('x_xchange')

```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| Ip address or hostname of the broker|
port( `integer` )| The broker's port | 5672
vhost( `string` )| vhost to connect to on the broker| '/'
routing_key( `string` )| routing key for the published messages|
exchange( `string` )|name of the exchange to publish to|
ssl( is_set ) | whether to use ssl | false (not set)

