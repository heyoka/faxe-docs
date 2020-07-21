The mqtt_publish node
=====================

Publish data to an mqtt-broker.
Incoming data is converted to JSON before sending.

If the `save()` parameter is given, every message first gets stored to an on-disk queue before sending,
this way we can make sure no message gets lost when disconnected from the broker.


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

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| Ip address or hostname of the broker| from config file
port( `integer` )| The broker's port | 1883 from config file
user( `string` )| username| from config file
pass( `string` )| password| from config file
topic( `string` )| mqtt topic to use| 
topic_lambda( `lambda` )| mqtt topic to use evaluated via a lambda expression| 
qos( `integer` )|Quality of service, one of 0, 1 or 2| 1
retained( is_set )| whether the message should be retained on the broker| false (not set)
save( is_set )|send save (on-disk queuing)|false (not set)
ssl( is_set ) | whether to use ssl | false (not set)

`topic` or `topic_lambda` must be provided.
 