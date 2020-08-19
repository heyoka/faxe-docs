The conn_status node
=====================

Subscribe to internal connection status events of running tasks.
For more information on these events make yourself familiar with faxe's [metrics](../../metrics.md).

Example
-------
```dfs  
%% get connection status events for task "flow1" and node "amqp_publish13"
|conn_status()
.flow('flow1')
.node('amqp_publish13') 

%% get connection status events for every node in task "flow1"  
|conn_status()
.flow('flow1') 

```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
flow( `string` )| Id of task|
node( `string` )| Id of node| undefined
 