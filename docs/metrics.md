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
 

### Examples

some metric example datapoints in json-format
```json
{"ts":1592386096330,"id":"00000","df":"92.001",
"data":{"type":"counter","node_id":"default3",
"metric_name":"processing_errors",
"flow_id":"41ef642f-e5ee-4c48-8bd9-565de810f242","counter":0}}
```

```json
{"ts":1592386096330,"id":"00000","df":"92.001",
"data":{"type":"histogram","node_id":"default3","n":8,"min":0.011,
"metric_name":"processing_time","mean":0.016625,"max":0.028,
"flow_id":"41ef642f-e5ee-4c48-8bd9-565de810f242"}}
```

```json
{"ts":1592386076289,"id":"00000","df":"92.001",
"data":{"type":"gauge","node_id":"default3","metric_name":"msg_q_size",
"gauge":0,"flow_id":"41ef642f-e5ee-4c48-8bd9-565de810f242"}}
```

```json
{"ts":1592386076289,"id":"00000","df":"92.001",
"data":{"type":"meter","one":0.2,"node_id":"default3",
"metric_name":"items_out","instant":0.2,
"five":0.2,"fifteen":0.2,"count":2,
"flow_id":"41ef642f-e5ee-4c48-8bd9-565de810f242"}}

```

#### Common fields

field name| meaning
----------|---------
data.type | the metric type, see table below
data.node_id| the nodes id
data.flow_id| id of the flow, the node belongs to 

#### Fields by metrics-type

metric-type | field | meaning
------------|-------|---------
counter     |counter| total counted number
            |        |
meter       |instant| number of occurrences in the last 5 sec
meter       |one| 1 min exponentially weighted moving average 
meter       |five| 5 min exponentially weighted moving average 
meter       |fifteen| 15 min exponentially weighted moving average 
meter       |count| total number
            |       |
gauge       |gauge| point-in-time single value
            |       |
histogram   | mean  | mean value
histogram   | min  | minimum value
histogram   | max  | maximum value
histogram   | n  | number of values
  
## Flow Metrics

For every task there is a summary of the node metrics:

```json
{"ts":1592393302700,"id":"00000","df":"92.002",
"data":{
    "processing_time":0.129,
    "processing_errors":0,
    "msg_q_size":0,
    "mem_used":53976,
    "items_out":4,
    "items_in":4,
    "flow_id":"e6450a2b-0b71-4d10-8011-67dfac1ce676"}
}
```
            
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
 
### Examples

connecting to an mqtt-broker on ip 10.14.204.3 and port 2883 ...
```json
{"ts":1592386056299,"id":"00000","df":"92.003",
"data":{"status":2,"port":2883,"peer":"10.14.204.3","node_id":"sys",
"flow_id":"sys","connected":false,"conn_type":"mqtt"}}
```

connected to the mqtt-broker 
```json
{"ts":1592386056319,"id":"00000","df":"92.003",
"data":{"status":1,"port":1883,"peer":"10.14.204.3","node_id":"sys",
"flow_id":"sys","connected":true,"conn_type":"mqtt"}}
```



The connection status is represented by the boolean value `connected` and an enum `status`.


`connected` | `status` | meaning
----------|--------|-------------
false     | 0      | not connected
false     | 2      | connecting
true      | 1      | connected
 
### Configuration

As stated above, FAXE has 2 different conn_status-handlers that can be configured :
See [config](configuration.md) section for details.


## Debug 

For debugging purposes faxe flows can expose events on items going in and out of every node in a flow.
Like with metrics and conn_status events, these events can be published to an mqtt/amqp broker. 
See [config](configuration.md) section for details.