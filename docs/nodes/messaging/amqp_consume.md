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

## Queue migration
_Since v1.4.2_

This feature can be used to migrate the flow of data to a new queue.

The reasons for migrating a queue could be: 

* `Rename` a queue (maybe to use a different policy)
* Use a different `type of queue`
* Migrate a queue to a `different vhost`

For this to work without losing any data, that is still
living in the existing queue, the node will temporarily setup a second consumer for this queue and consumes from both queues in parallel,
until it sees the same messages coming in on both queues (duplicates will be removed). At this point the consumer for the existing queue will be stopped
and the queue will be deleted from the broker.
If a flow that is setup to do a queue migration is restarted **after** the migration has already finished, the takeover_queue is **not** declared again, because the
takeover_queue declaration is done in [passive mode](https://www.rabbitmq.com/client-libraries/dotnet-api-guide#passive-declaration), which means that a queue can only be used, if it already exists on the broker.

New node parameters are added (See [parameters](#Parameters) table below):

* `takeover_queue`: Name of the existing queue from which to takeover the data stream.
* `takeover_queue_type`: "x-queue-type" amqp argument
* `takeover_vhost` 

All other parameters are the same for both consumers, except:

* `queue_prefix`: Does not affect the takeover_queue, you must use the full (existing) queue name.
* `exchange` and `exchange_prefix`: This will always be the same for both consumers.
* `consumer_tag`: a postfix will be added for the take-over consumer.

>When `vhost` and `takeover_vhost` are different, you must make sure, that the data is published to both vhosts.
The name of the exchanges must be the same on each vhost.
Exchanges and queues are specific to a vhost, so we cannot bind a queue on one vhost to an exchange on another vhost.

--------------

At the moment this node can only set up and work with `topic` exchanges.


Examples
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

-----------------------
```dfs  
|amqp_consume()
.host('deves-amqp-cluster1.internal') 
.bindings('my.routing.key')
.exchange('x_xchange')
.queue('faxe_test')
.queue_type('quorum')
.takeover_queue('existing_queue') 
.dt_field('UTC-Time')
.dt_format('float_micro')
```
Migrate from a queue named 'exisiting_queue' to a new queue named 'faxe_test' with type 'quorum'.

Parameters
----------

| Parameter                            | Description                                                                                                                                                                                                                                         | Default                                     |
|--------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|
| host( `string` )                     | Ip address or hostname of the broker                                                                                                                                                                                                                | config: `amqp.host`/`FAXE_AMQP_HOST`        |
| port( `integer` )                    | The broker's port                                                                                                                                                                                                                                   | config: `amqp.port`/`FAXE_AMQP_PORT`        |
| user( `string` )                     | AMQP user                                                                                                                                                                                                                                           | config: `amqp.user`/`FAXE_AMQP_USER`        |
| pass( `string` )                     | AMQP password                                                                                                                                                                                                                                       | config: `amqp.pass`/`FAXE_AMQP_PASS`        |
| vhost( `string` )                    | vhost to connect to on the broker                                                                                                                                                                                                                   | '/'                                         |
| routing_key( `string` ) _deprecated_ | routing key to use for queue binding                                                                                                                                                                                                                | undefined                                   |
| bindings( `string_list` )            | list of [queue bindings](https://www.cloudamqp.com/blog/part4-rabbitmq-for-beginners-exchanges-routing-keys-bindings.html) keys                                                                                                                     | []                                          |
| queue( `string` )                    | name of the queue to bind to the exchange                                                                                                                                                                                                           | FlowName + '_' + NodeName                   |
| queue_prefix( `string` )             | prefix for the queue-name that will be ensured to exist for `queue`                                                                                                                                                                                 | from config                                 |
| queue_type( `string` )               | Queue type, Valid values are: `''`, `'quorum'`, `'classic'`. The value will be used for the "x-queue-type" argument while declaring a queue. With `''`, the type of the queue will be the default type defined for the vhost.                       | ''                                      |
| exchange( `string` )                 | name of the exchange to bind to the source exchange                                                                                                                                                                                                 | FlowName + '_' + NodeName                   |
| exchange_prefix( `string` )          | prefix for the exchange-name that will be ensured to exist for `exchange`                                                                                                                                                                           | from config                                 |
| prefetch( `integer` )                | [prefetch](https://www.rabbitmq.com/consumer-prefetch.html) count to use                                                                                                                                                                            | 70                                          |
| consumer_tag( `string` )             | Identifier for the queue consumer                                                                                                                                                                                                                   | 'c_' + FlowName + '_' + NodeName            |
| ack_every( `integer` )               | number of messages to consume before acknowledging them to the broker                                                                                                                                                                               | 20                                          |
| ack_after( `duration` )              | timeout after which all currently not acknowledged messages will be acknowledged, regardless of the `ack_every` setting                                                                                                                             | 5s                                          |
| use_flow_ack( `bool` )               | special ack mode, where message acknowledgement is dependend on other nodes in the flow (see [crate_out](../database/crate_out.md)), `ack_every` and `ack_after` have no effect with this mode                                                      | false                                       |
| dedup_size( `integer` )              | number of correlation-ids to hold in memory for message deduplication                                                                                                                                                                               | 200                                         |
| dt_field( `string` )                 | name of the timestamp field that is expected                                                                                                                                                                                                        | 'ts'                                        |
| dt_format( `string` )                | timestamp or datetime format that is expected (see [datetime-parsing](../../datetime-parsing.md))                                                                                                                                                   | 'millisecond'                               |
| include_topic ( `bool` )             | whether to include the routingkey in the resulting datapoints                                                                                                                                                                                       | true                                        |
| topic_as ( `string` )                | if `include_topic` is true, this will be the fieldname for the routingkey value                                                                                                                                                                     | 'topic'                                     |
| as ( `string` )                      | base object for the output data-point                                                                                                                                                                                                               | undefined                                   |
| ssl( is_set )                        | whether to use tls, if true, ssl options from faxe's config for amqp connections will be used                                                                                                                                                       | config: `amqp.ssl.enable`/`FAXE_AMQP_SSL_ENABLE` |
| confirm ( `boolean` )                | whether to acknowledge consumed messages to the amqp broker, when set to `false`, the channel will be set to auto-ack , throughput can be increased with the danger of data-loss                                                                    | true                                        |
| safe ( `boolean` )                   | whether to use faxe's internal queue. If `true`, messages consumed from the amqp broker will be stored in an internal ondisc queue before they get sent to downstream nodes, to avoid losing data.                                                  | false                                       |
| takeover_queue ( `string` )          | Name for the take-over queue.                                                                                                                                                                                                                       | undefined                                   |
| takeover_queue_type ( `string` )     | Queue type for the take-over queue. Valid values are: `''`, `'quorum'`, `'classic'`. The value will be used for the "x-queue-type" argument while declaring a queue. With '', the type of the queue will be the default type defined for the vhost. | ''                                          |
| takeover_vhost ( `string` )          | Name of the vhost for the take-over queue.                                                                                                                                                                                                          | value of `vhost`                            |

> Exactly one of these must be provided: `routing_key`, `bindings`.
