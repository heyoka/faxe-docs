The mqtt_amqp_bridge node
=====================

The mqtt_amqp-bridge node provides a message-order preserving and fail-safe mqtt-to-amqp bridge.
It is designed for minimized overhead, high throughput and fault-tolerant message delivery.
Receives data from an mqtt-broker and writes each indiviual topic with an amqp-publisher via an internal on-disk queue.

This node starts 1 mqtt-subscriber and up to `max_publishers` number of amqp-publishers.

The node does only work standalone at the moment, meaning you cannot connect it to other nodes.

The mqtt_amqp_bridge is completely unaware of the message content.
For performance reasons the node does not parse incoming data or use data_items as every other node
in faxe does, instead internally it will work with the raw binaries received from the mqtt broker and pass them through to the amqp publishers.


Example
-------
```dfs  
def topic = 'my/topic/#'
|mqtt_amqp_bridge() 
.topics(topic)
%% amqp params
.amqp_host('10.11.12.13') 
.amqp_user('user')
.amqp_pass('pass')
.amqp_exchange('x_exchange')
.amqp_ssl()
.max_publishers(5) 
 
```


Parameters
----------
Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| Ip address or hostname of the mqtt broker| from config 
port( `integer` )| The mqtt broker's port | 1883 from config 
user( `string` )| username for the mqtt connection| from config 
pass( `string` )| password for the mqtt connection| from config 
ssl( is_set ) | whether to use ssl for the mqtt connection | false (not set)
topics( `string_list` )| mqtt topic to use| 
qos( `integer` )|Quality of service for mqtt, one of 0, 1 or 2| 1
amqp_host( `string` )| Ip address or hostname of the amqp broker| from config file
amqp_port( `integer` )| The amqp broker's port | 1883 from config file
amqp_user( `string` )| username for amqp connections| from config file
amqp_pass( `string` )| password for amqp connections| from config file
amqp_ssl( is_set ) | whether to use ssl for the amqp connection | false (not set)
amqp_vhost( `string` )| VHost for the amqp broker| '/'
amqp_exchange( `string` )| name of the amqp exchange to publish to| 
max_publishers( `integer` )| max number of amqp publishers that will be started | 3
safe( is_set) | whether to use queue acknowledgement for the internal on-disc queue | false (not set)
reset_timeout( `duration` )| when the bridge does not see any new message for a topic for this amount of time, it will try to stop the corresponding queue and amqp-publisher process, if appropiate | 5m
 

