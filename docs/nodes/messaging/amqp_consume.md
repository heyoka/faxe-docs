The amqp_consume node
=====================

Consume data from an amqp-broker like [RabbitMQ](https://www.rabbitmq.com).

This node accepts regular amqp routing keys as well as MQTT style topic strings for `bindings`/`routing_key`.

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

| Parameter                            | Description                                                                                                                                                                                        | Default                                          |
|--------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| host( `string` )                     | Ip address or hostname of the broker                                                                                                                                                               | config: `amqp.host`/`FAXE_AMQP_HOST`             |
| port( `integer` )                    | The broker's port                                                                                                                                                                                  | config: `amqp.port`/`FAXE_AMQP_PORT`             |
| user( `string` )                     | AMQP user                                                                                                                                                                                          | config: `amqp.user`/`FAXE_AMQP_USER`             |
| pass( `string` )                     | AMQP password                                                                                                                                                                                      | config: `amqp.pass`/`FAXE_AMQP_PASS`             |
| vhost( `string` )                    | vhost to connect to on the broker                                                                                                                                                                  | '/'                                              |
| routing_key( `string` ) _deprecated_ | routing key to use for queue binding                                                                                                                                                               | undefined                                        |
| bindings( `string_list` )            | list of [queue bindings](https://www.cloudamqp.com/blog/part4-rabbitmq-for-beginners-exchanges-routing-keys-bindings.html) keys                                                                    | []                                               |
| queue( `string` )                    | name of the queue to bind to the exchange                                                                                                                                                          | FlowName + '_' + NodeName                        |
| queue_prefix( `string` )             | prefix for the queue-name that will be ensured to exist for `queue`                                                                                                                                | from config                                      |
| exchange( `string` )                 | name of the exchange to bind to the source exchange                                                                                                                                                | FlowName + '_' + NodeName                        |
| exchange_prefix( `string` )          | prefix for the exchange-name that will be ensured to exist for `exchange`                                                                                                                          | from config                                      |
| prefetch( `integer` )                | [prefetch](https://www.rabbitmq.com/consumer-prefetch.html) count to use                                                                                                                           | 70                                               |
| consumer_tag( `string` )             | Identifier for the queue consumer                                                                                                                                                                  | 'c_' + FlowName + '_' + NodeName                 |
| ack_every( `integer` )               | number of messages to consume before acknowledging them to the broker                                                                                                                              | 20                                               |
| ack_after( `duration` )              | timeout after which all currently not acknowledged messages will be acknowledged, regardless of the `ack_every` setting                                                                            | 5s                                               |
| use_flow_ack( `bool` )               | special ack mode, where message acknowledgement is dependend on other nodes in the flow (see [crate_out](../database/crate_out.md)), `ack_every` and `ack_after` have no effect with this mode     | false                                            |
| dedup_size( `integer` )              | number of correlation-ids to hold in memory for message deduplication                                                                                                                              | 200                                              |
| dt_field( `string` )                 | name of the timestamp field that is expected                                                                                                                                                       | 'ts'                                             |
| dt_format( `string` )                | timestamp or datetime format that is expected (see [datetime-parsing](../../datetime-parsing.md))                                                                                                  | 'millisecond'                                    |
| include_topic ( `bool` )             | whether to include the routingkey in the resulting datapoints                                                                                                                                      | true                                             |
| topic_as ( `string` )                | if `include_topic` is true, this will be the fieldname for the routingkey value                                                                                                                    | 'topic'                                          |
| as ( `string` )                      | base object for the output data-point                                                                                                                                                              | undefined                                        |
| ssl( is_set )                        | whether to use tls, if true, ssl options from faxe's config for amqp connections will be used                                                                                                      | config: `amqp.ssl.enable`/`FAXE_AMQP_SSL_ENABLE` |
| confirm ( `boolean` )                | whether to acknowledge consumed messages to the amqp broker, when set to `false`, throughput can be increased with the danger of data-loss                                                         | true                                             |
| safe ( `boolean` )                   | whether to use faxe's internal queue. If `true`, messages consumed from the amqp broker will be stored in an internal ondisc queue before they get sent to downstream nodes, to avoid losing data. | false                                            |

> Exactly one of these must be provided: `routing_key`, `bindings`.
