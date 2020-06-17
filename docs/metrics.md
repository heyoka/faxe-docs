# Metrics

Faxe exposes internal metric as well as connection status events.

Faxe will collect and periodically emit various metrics to configurable endpoints.
Metrics are collected for each individual node and a summery for whole tasks.

## Node Metrics

These are the metrics that will be collected for every node running in a task:

metric name | description | metric fields
------------|-------------|---------------
`items_in`    | number of items a node received from other nodes or over the network | 
`items_out`   | number of items a node emitted to other nodes or over some network connection
`processing_errors`| the number of errors that occurred during processing |
`mem_used`    | memory usage in Kib |
`msg_q_size`  | number of items currently in the node-process' message-queue |
`processing_time`| time in milliseconds it took the node to process 1 item|

Nodes that start a network connection have additional metrics 
(such as the modbus, s7read, mqtt, ... - nodes): 

metric name | description | metric fields
------------|-------------|---------------
`reading_time`|the time in milliseconds it took the node to read data from a network port|
`bytes_read`  |the number of bytes read from a network port |
`sending_time`|the time in milliseconds it took the node to send data to some network endpoint|
`bytes_sent`  |the number of bytes send over the network
 

### Configuration

Faxe has 2 different metrics-handlers that can be configured.
MQTT and AMQP metrics emitter. See [config](configuration.md) section for details.

### Use metrics in tasks

Faxe's internal metrics can be used in tasks(flows) with the [metrics](nodes/metrics.md) node.

---------------------------------------
# Connection status

Faxe tracks the status of every external connection it opens and exposes events.
These events can be used in tasks with the [conn_status](nodes/conn_status.md) node.

They can also be sent to a mqtt and/or amqp broker. 
 
### Configuration

As stated above, FAXE has 2 different conn_status-handlers that can be configured :
See [config](configuration.md) section for details.