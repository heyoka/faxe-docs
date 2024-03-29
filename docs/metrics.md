# Metrics, Connection status, Debug events and Logs

For debugging and observability Faxe exposes internal metric as well as connection status events.
Furthermore, every running flow can emit debugging and log events.

All these events can be published to a mqtt broker.

### Topics and routing keys
Topics for the mqtt emitters can be prefixed with the config-value `base_topic` (see [config](configuration.md)).
Note: MQTT topics should not start with a `/` character.


type | topic | base_topic default
-----|-------|-------------------
metrics per node| {`base_topic`}/metrics/{flow_id}/{node_id}/{metric_name} | sys/
metrics per flow| {`base_topic`}/metrics/{flow_id} | sys/
conn_status| {`base_topic`}/conn_status/{flow_id}/{node_id} | sys/
debug per node| {`base_topic`}/debug/{flow_id}/{node_id}/{debug_type} | sys/
logs per node| {`base_topic`}/log/{flow_id}/{node_id} | sys/


## Node Metrics

Faxe will collect and periodically emit various metrics to configurable endpoints.
Metrics are collected for each individual node and a summery for whole tasks.

These are the metrics that will be collected for every node running in a task:

metric name | description | metric fields
------------|-------------|---------------
`items_in`    | number of items a node received from other nodes or over the network | 
`items_out`   | number of items a node emitted to other nodes or over some network connection
`processing_errors`| the number of errors that occurred during processing |
`mem_used`    | memory usage in bytes |
`msg_q_size`  | number of items currently in the node-process' message-queue |
`processing_time`| time in milliseconds it took the node to process 1 item|

Nodes that start a network connection have additional metrics 
(such as the modbus, s7read, mqtt, ... - nodes): 

metric name | description | metric fields
------------|-------------|--------------- 
`bytes_read`  |the number of bytes read from a network port | see meter
`bytes_read_size` |the size of packets read or received from a network port in bytes | see histogram
`bytes_sent`  |the number of bytes send over the network | see meter
`bytes_sent_size`  |the size of packets sent over a network port in bytes | see histogram
 

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
  "ts": 1631557230000,
  "processing_time": 0.088,
  "processing_errors": 0,
  "msg_q_size": 0,
  "mem_used": 17768,
  "items_out": 60,
  "items_in": 60,
  "bytes_sent_avg": 123,
  "bytes_sent": 24.6,
  "bytes_read_avg": 104,
  "bytes_read": 20.8,
  "flow_id": "http_get_test"
  }
}
```

### Fields in flow metrics


metric name | description | note
------------|-------------|--------------- 
`processing_time` | average processing time for the flow in milliseconds |  
`processing_errors` | sum of errors for all flow nodes |  
`msg_q_size` | total number of items currently in process-queues for all flow nodes |  
`mem_used` | total number of bytes the flow and all of its nodes are currently using |  
`items_out` | maximum of all nodes' `items_out` value |  
`items_in` |  maximum of all nodes' `items_in` value|  
`bytes_sent_avg` | sum of bytes sent over the network for all nodes in the flow |  
`bytes_sent` | sum of the 5-minute exponential moving averages from all nodes' `bytes_sent` metrics |  
`bytes_read_avg` | sum of bytes received from the network for all nodes in the flow |  
`bytes_read` | sum of the 5-minute exponential moving averages from all nodes' `bytes_read` metrics |



### Configuration

With the configuration setting `metrics.handler.mqtt.enable` you can turn on/off publishing of metrics for a faxe instance.
If this setting is set to `on` flow metrics get published with the interval set with `metrics.publish_interval`.

To additionally enable publishing of single node metrics for a faxe flow, use the [RestAPI](./faxe_rest_api.html) endpoint `/v1/task/start_metrics_trace/:task_id/[:duration_minutes]`.

`duration_minutes` defaults to the config setting `debug.time`.

#### Publish metrics events

Faxe has 2 different metrics-handlers that can be configured.
MQTT and AMQP metrics emitter. See [config](configuration.md) section for details.

### Use metrics in tasks

Faxe's internal metrics can be used in tasks(flows) with the [metrics](nodes/debug/metrics.md) node.

---------------------------------------
# Connection status

Faxe tracks the status of every external connection it opens and exposes events.
These events can be used in tasks with the [conn_status](nodes/debug/conn_status.md) node.

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


#### Publish connection status events

As stated above, FAXE has 2 different conn_status-handlers that can be configured :
See [config](configuration.md) section for details.


## Debug and Logs

For debugging purposes faxe flows can expose events on items going in and out of every node in a flow.
Like with metrics and conn_status events, these events can be published to a mqtt/amqp broker. 
Debug and Log events must be started explicitly, and they will be published for a certain configurable amount of time.

To enable publishing of debug events for a faxe flow, use the [RestAPI](./faxe_rest_api.html) endpoint `/v1/task/start_debug/:task_id/[:duration_minutes]`.
`duration_minutes` defaults to the config setting `debug.time`.

(This is for debugging purposes).

See [config](configuration.md) section for details.

Example debug data item:
```json
{"ts":1594627419206,"id":"00000","df":"00.000", 
"data":
    {"meta":
        {"type":"item_in","port":1,"node_id":"win_time6","flow_id":"trace_test"},
    "data_item":"{\"ts\":1594627419205,\"id\":\"00000\",\"df\":\"00.000\",\"data\":{\"val\":4.770044683775623}}"}}

```

Example log

```json

{"ts":1595317825817,"id":"00000","df":"00.000",
    "data":
        {"node_id":"eval26","meta":
            {"pid":"<0.1750.0>","node":"faxe@ubuntu",
            "module":"df_component","line":316,
            "function":"handle_info","application":"faxe"},
            "message":"'error' in component esp_eval caught when processing item: 
            {1,{data_point,1595317823813,#{<<\"esp_avg\">> => 6.0685635225505425,
                <<\"factored\">> => 3.0342817612752713},#{},<<>>}} -- \"\\n    
                gen_server:try_dispatch/4 line 637\\n    df_component:handle_info/2 line 314\\n    
                esp_eval:process/3 line 39\\n    esp_eval:eval/4 line 44\\n    lists:foldl/3 line 1263\\n    
                esp_eval:'-eval/4-fun-0-'/4 line 47\\n    faxe_lambda:execute/3 line 34\\n    
                erlang:'/'(undefined, 2)\\nEXIT:badarith\"","level":"error","flow_id":"script5"}}


```

A data_point caused an error in an [eval](nodes/logic/eval.md) node.