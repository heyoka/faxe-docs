The mqtt_publish node
=====================

Publish data to a mqtt-broker.
Incoming data is converted to JSON before sending.

If the `save()` parameter is given, every message first gets stored to an on-disk queue before sending,
this way we can make sure no message gets lost when disconnected from the broker.


> Note: This node is a sink node and does not output any flow-data, therefore any node connected to this node will not get any data.

Example
-------
```dfs  
def topic = 'top/track/pressure'

|mqtt_publish() 
.topic(topic)
.retained()

```    
    
Using a lambda expression for the topic:
```dfs  
def topic_base = 'top/'

|mqtt_publish()
.topic_lambda(lambda: str_concat([topic_base, "type", '/', "measurement"])
```

Here the topic string is built with a lambda expression using the `topic_base` declaration, the `string '/'` and
two fields from the current data_point.
The topic string may be a different one with every data_point that gets published.


-------------------------------------------------------
## Sequence check
since version 1.5.5

This node can add **meta data** to each data-item it sends to an mqtt broker.
This data will include a sequence number that will be checked by a receiving [mqtt_subscribe](mqtt_subscribe.md) node.
The check will be performed after n number of items received by the [mqtt_subscribe](mqtt_subscribe.md) node to see, if data has been lost along the way.
In case of missing data, a new mqtt message will be sent out to report this.
To enable this sequence check, the config value `seq_check.enable`/`FAXE_SEQ_CHECK_ENABLE` must be set to `on`.
For more information see [configuration](../../configuration.md).

#### Example data_point with meta data:
```json
{
	"ts": 1748438360000,
	"data": {
		...
		}
	},
	"_meta": {
		"topic": "data/test/seq_check/v1",
		"started": false,
		"seq": 4392,
		"nodeid": "mqtt_publish3",
		"flowid": "test1",
		"device": "3a79daae29a28b4e2f754720a2bcd31c"
	}
}
```

Parameters
----------

| Parameter                          | Description                                                                                                    | Default                                                      |
|------------------------------------|----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| host( `string` )                   | Ip address or hostname of the broker                                                                           | config: `mqtt.host`/`FAXE_MQTT_HOST`                         |
| port( `integer` )                  | The broker's port                                                                                              | config: `mqtt.port`/`FAXE_MQTT_PORT`                         |
| user( `string` )                   | username                                                                                                       | config: `mqtt.user`/`FAXE_MQTT_USER`                         |
| pass( `string` )                   | password                                                                                                       | config: `mqtt.pass`/`FAXE_MQTT_PASS`                         |
| client_id( `string` )              | mqtt client id, defaults to a combination of flow-id and node-id                                               | undefined                                                    |
| topic( `string` )                  | mqtt topic to use                                                                                              | undefined                                                    |
| topic_lambda( `lambda` )           | mqtt topic to use evaluated via a lambda expression                                                            | undefined                                                    |
| topic_field( `string` )            | [since 0.19.9] path to a field in the current data-item, who's value should be used as the topic               | undefined                                                    |
| qos( `integer` )                   | Quality of service, one of 0, 1 or 2                                                                           | 1                                                            |
| retained( is_set )                 | whether the message should be retained on the broker                                                           | false (not set)                                              |
| save( is_set )                     | send save (on-disk queuing)                                                                                    | false (not set)                                              |
| ssl( is_set )                      | whether to use ssl                                                                                             | config: `mqtt.ssl.enable`/`FAXE_MQTT_SSL_ENABLE`             |
| max_mem_queue_size( `integer` )    | Number of data_items that can be stored in memory, in case a connection is not available                       | 700                                                          |
| use_pool( `bool` )                  | Whether to use a connection pool for the mqtt connection. If false, then the node will use its own connection. | config: `mqtt_pub_pool.enable`/`FAXE_MQTT_PUB_POOL_ENABLE`                                                         |
| add_seq_check( `bool` )            | whether to add meta data to each data_item sent to an mqtt broker (see ) for more info                         | config: `seq_check.enable`/`FAXE_SEQ_CHECK_ENABLE`           |
| seq_check_topic_depth( `integer` ) | see for more info                                                                                              | config: `seq_check.topic_depth`/`FAXE_SEQ_CHECK_TOPIC_DEPTH` |

`topic` or `topic_lambda` or `topic_field` must be provided.
 