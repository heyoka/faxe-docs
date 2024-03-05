The metrics node
=====================
 
Subscribe to internal metric events of running tasks.
For more information on these events make yourself familiar with faxe's [metrics](../../metrics.md).

Note: It is not possible to subscribe to metrics for the task the metrics node belongs to.


Example
-------
```dfs  
%% get all metrics for task "flow1" and node "amqp_publish13"
|metrics()
.flow('flow1')
.node('amqp_publish13')


%% get total number of bytes read and written for task "flow32"
|metrics()
.flow('flow32')
.metrics('bytes_read', 'bytes_sent')

```

Parameters
----------

| Parameter                | Description                              | Default   |
|--------------------------|------------------------------------------|-----------|
| flow( `string` )         | Id of task                               |           |
| node( `string` )         | Id of node                               | undefined |
| metrics( `string_list` ) | List of [metric_names](../../metrics.md) | undefined |
 