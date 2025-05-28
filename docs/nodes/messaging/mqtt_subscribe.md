The mqtt_subscribe node
=====================

Subscribe to an mqtt-broker and get data from one or more topics. 


Example
-------
```dfs  
|mqtt_subscribe()
.topics('top/grips/#')
.dt_field('UTC-Stamp')
.dt_format('float_micro')

```

-------------------------------------------------------
## Sequence check
since version 1.5.5


This node can perform a check on data based on **meta data**, that gets added to each data-item by an [mqtt_publish](mqtt_publish.md) node.
This data will include a sequence number that will be checked.
The check will be performed after n number of items to see, if data has been lost along the way.
In case of missing data, a new mqtt message will be sent out to report this.
If no meta data is present in a data_point, it will be ignored in regards of the check.
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

| Parameter                 | Description                                                                                                       | Default                                              |
|---------------------------|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| host( `string` )          | Ip address or hostname of the broker                                                                              | config: `mqtt.host`/`FAXE_MQTT_HOST`                 |
| port( `integer` )         | The broker's port                                                                                                 | config: `mqtt.port`/`FAXE_MQTT_PORT`                 |
| user( `string` )          | username                                                                                                          | config: `mqtt.user`/`FAXE_MQTT_USER`                 |
| pass( `string` )          | password                                                                                                          | config: `mqtt.pass`/`FAXE_MQTT_PASS`                 |
| client_id( `string` )     | mqtt client id, defaults to a combination of flow-id and node-id                                                  | undefined                                            |
| topics( `string_list` )   | mqtt topic(s) to use                                                                                              | undefined                                            |
| topic( `string` )         | mqtt topic to use                                                                                                 | undefined                                            |
| qos( `integer` )          | Quality of service, one of 0, 1 or 2                                                                              | 1                                                    |
| dt_field( `string` )      | name of the timestamp field that is expected                                                                      | 'ts'                                                 |
| dt_format( `string` )     | timestamp or datetime format that is expected (see [datetime-parsing](../../datetime-parsing.md))                 | 'millisecond'                                        |
| include_topic ( `bool` )  | whether to include the mqtt-topic in the resulting datapoints                                                     | true                                                 |
| topic_as ( `string` )     | if `include_topic` is true, this will be the fieldname for the mqtt-topic value                                   | 'topic'                                              |
| as ( `string` )           | base object for the output data-point                                                                             | undefined                                            |
| ssl( is_set )             | whether to use ssl                                                                                                | config: `mqtt.ssl.enable`/`FAXE_MQTT_SSL_ENABLE`     |
| remove_meta_field( `bool` ) | whether to remove meta data added by an mqtt_publish node for the seq_check feature (see [here](#Sequence check)) | config: `seq_check.cleanup`/`FAXE_SEQ_CHECK_CLEANUP` |

> One of `topic`, `topics` must be specified.
  