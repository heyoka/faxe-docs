# Auto stop feature

> Since version 1.1.0

Normally a flow in faxe is supposed to run 24/7/365 and forever, but sometimes it is desirable to stop a flow under special conditions.

Faxe has a feature called `stop when idle`, that can be used in every flow and from every node.

### Example:

Suppose we have the following simple flow, that consumes from a [RabbitMQ Broker](https://rabbitmq.com) 
and writes data into a [CrateDB](https://crate.io) database:

```dfs

|amqp_consume()
.host('deves-amqp-cluster1.internal') 
.bindings('my.routing.key')
.exchange('x_xchange')
.queue('faxe_test')


|batch(30)
.timeout(5s)

|crate_out() 
.table('customer1')
.db_fields('stream', 'measurement')
.faxe_fields('stream', 'measurement') 

```

Say we know, that this flow will only get data for a limited amount of time and after that time, we want to stop the flow
to save resources.
What we do not know, is the exact time when we do not get any more data to write to the database.

The `stop when idle` feature can help us here:


```dfs

|amqp_consume()
.host('deves-amqp-cluster1.internal') 
.bindings('my.routing.key')
.exchange('x_xchange')
.queue('faxe_test')


|batch(30)
.timeout(5s)

|crate_out() 
.table('customer1')
.db_fields('stream', 'measurement')
.faxe_fields('stream', 'measurement') 

%% we use the stop when idle feature here
._stop_idle(true)
._idle_time(3m)

```

When the `_stop_idle` parameter is **true** for any node in a flow (could be used in more than on node in a flow), 
the nodes base process will check periodically, if the node is idle already for the given amount of time (3 minutes in the above example).

#### What does idle exactly mean ?

A node is idle, if we do not see any data going in or out for a given amount of time.

#### Result
If a node, where this feature is used (`_stop_idle` is set to true), is idle for the amount of time, it will tell the dataflow system to stop
the flow it is part of. The stop behavior is equivalent to [this stop call](./faxe_rest_api.html#/paths/~1task~1stop~1%7Btask_id%7D~1true/get) (permanently stopping a flow) via faxe's REST API.

#### Conditional 
Since version 1.1.6 a conditional lambda expression can be given with `_stop_when`.
If this is present, the expression must evaluate to true once for any data-item, before the idle-time is measured and the feature becomes active.

#### Using the feature

As mentioned above, this feature can be used on any node in a flow, including [custom nodes written in python](custom_nodes.md).
If more than one node in a flow has `_stop_idle` set to **true**, the first node that detects it is idle, will cause the whole flow to stop.


Parameters
----------

| Parameter              | Description                                                                                                    | Default   |
|------------------------|----------------------------------------------------------------------------------------------------------------|-----------| 
| _stop_idle(`boolean`)  | if set to true, the node will periodically check, if it was idle for at least the time given with `_idle_time` | false     |
| _idle_time(`duration`) | amount of time a node must be idle, before it initiates a stop procedure for the flow it is part of            | 5m        | 
| _stop_when(`lambda`)   | if given, the lambda expression must evaluate to true (once!), before the idle time is measured                | undefined | 


