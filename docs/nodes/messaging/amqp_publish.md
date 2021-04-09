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
host( `string` )| Ip address or hostname of the broker| from config
port( `integer` )| The broker's port | 5672 / from config file
user( `string` )| AMQP user | from config file
pass( `string` )| AMQP password | from config file
vhost( `string` )| vhost to connect to on the broker| '/'
routing_key( `string` )| routing key for the published messages|
routing_key_lambda( `lambda` )| lambda expression producing a routing key for the published messages|
exchange( `string` )|name of the exchange to publish to|
safe( `is_set` ) | whether to use acknowledgement for the on-disk queue | false (not set)
persistent( `bool` ) | whether to send the amqp messages with delivery-mode 2 (persistent) | false (delivery_mode = 1)
ssl( is_set ) | whether to use ssl | false (not set)

