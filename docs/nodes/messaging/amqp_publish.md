The amqp_publish node
=====================

Publish data to an amqp-broker exchange. The most popular amqp-broker is [RabbitMQ](https://www.rabbitmq.com).

Incoming data is converted to JSON before sending.

This node accepts regular amqp routing keys as well as MQTT style topic strings for each of the `routing_key(...)` params.

-----------
The amqp `correlation-id` property will be set to phash2(routing_key + payload) using erlang's phash2 function on every published message:
    
    The erlang documentation on phash2:

    Portable hash function that gives the same hash for the same Erlang term regardless of machine architecture and ERTS version.

(phash2 outputs an integer which gets casted to a string to be used as a correlation-id)

The [amqp_consume](amqp_consume.md) node will use this values to perform deduplication on message receiving.

-----------

> Note: This node is a sink node and does not output any flow-data, therefore any node connected to it will not receive any data from this node.

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

| Parameter                      | Description                                                                             | Default                                          |
|--------------------------------|-----------------------------------------------------------------------------------------|--------------------------------------------------|
| host( `string` )               | Ip address or hostname of the broker                                                    | config: `amqp.host`/`FAXE_AMQP_HOST`             |
| port( `integer` )              | The broker's port                                                                       | config: `amqp.port`/`FAXE_AMQP_PORT`             |
| user( `string` )               | AMQP user                                                                               | config: `amqp.user`/`FAXE_AMQP_USER`             |
| pass( `string` )               | AMQP password                                                                           | config: `amqp.pass`/`FAXE_AMQP_PASS`             |
| vhost( `string` )              | vhost to connect to on the broker                                                       | '/'                                              |
| routing_key( `string` )        | routing key for the published messages                                                  | undefined                                        |
| routing_key_lambda( `lambda` ) | lambda expression producing a routing key for the published messages                    | undefined                                        |
| routing_key_field( `string` )  | path to a field in the current data-item, who's value should be used as the routing-key | undefined                                        |
| exchange( `string` )           | name of the exchange to publish to                                                      |                                                  |
| qos( `integer` )               | publish quality, see table below for details                                            | 1                                                |
| persistent( `bool` )           | whether to send the amqp messages with delivery-mode 2 (persistent)                     | false (delivery_mode = 1)                        |
| ssl( is_set )                  | whether to use ssl                                                                      | config: `amqp.ssl.enable`/`FAXE_AMQP_SSL_ENABLE` |

One of `routing_key`, `routing_key_lambda`, `routing_key_field` is required.

### Qos
| Qos | description                                                                                              | consequences                                                         |
|-----|----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| 0   | In memory queuing of messages, in case of network issues. Does not use publisher confirm on the channel. | Highest throuput.                                                    |
| 1   | On disc queuing of messages, in case of network issues. Does not use publisher confirm on the channel.   | Not yet published messages will survive a flow crash. At least once. |
| 2   | On disc queue + acknowledgment according to acknowledgement from the amqp broker (publisher confirm).    | Most safe data delivery. Aims at exactly once semantics.             |