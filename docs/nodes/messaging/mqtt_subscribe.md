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


Parameters
----------

| Parameter                | Description                                                                                       | Default                                          |
|--------------------------|---------------------------------------------------------------------------------------------------|--------------------------------------------------|
| host( `string` )         | Ip address or hostname of the broker                                                              | config: `mqtt.host`/`FAXE_MQTT_HOST`             |
| port( `integer` )        | The broker's port                                                                                 | config: `mqtt.port`/`FAXE_MQTT_PORT`             |
| user( `string` )         | username                                                                                          | config: `mqtt.user`/`FAXE_MQTT_USER`             |
| pass( `string` )         | password                                                                                          | config: `mqtt.pass`/`FAXE_MQTT_PASS`             |
| client_id( `string` )    | mqtt client id, defaults to a combination of flow-id and node-id                                  | undefined                                        |
| topics( `string_list` )  | mqtt topic(s) to use                                                                              | undefined                                        |
| topic( `string` )        | mqtt topic to use                                                                                 | undefined                                        |
| qos( `integer` )         | Quality of service, one of 0, 1 or 2                                                              | 1                                                |
| dt_field( `string` )     | name of the timestamp field that is expected                                                      | 'ts'                                             |
| dt_format( `string` )    | timestamp or datetime format that is expected (see [datetime-parsing](../../datetime-parsing.md)) | 'millisecond'                                    |
| include_topic ( `bool` ) | whether to include the mqtt-topic in the resulting datapoints                                     | true                                             |
| topic_as ( `string` )    | if `include_topic` is true, this will be the fieldname for the mqtt-topic value                   | 'topic'                                          |
| as ( `string` )          | base object for the output data-point                                                             | undefined                                        |
| ssl( is_set )            | whether to use ssl                                                                                | config: `mqtt.ssl.enable`/`FAXE_MQTT_SSL_ENABLE` |

> One of `topic`, `topics` must be specified.
  