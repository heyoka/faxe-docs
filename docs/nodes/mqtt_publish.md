The mqtt_publish node
=====================

Publish data to an mqtt-broker.
Incoming data is converted to JSON before sending.

If the `save()` parameter is given, every message first gets stored to an on-disk queue before sending,
this way we can make sure no message gets lost when disconnected from the broker.


Example
-------

    def topic = 'top/track/pressure'
    def mqtt_host = '101.14.123.23'
    
    |mqtt_publish()
    .host(mqtt_host)
    .port(1883)
    .qos(1)
    .topic(topic)
    .retained()


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| Ip address or hostname of the broker|
port( `integer` )| The broker's port | 1883
topic( `string` )| mqtt topic to use| 
qos( `integer` )|Quality of service, one of 0, 1 or 2| 1
retained( is_set )| whether the message should be retained on the broker| false (not set)
save( is_set )|send save (on-disk queuing)|false (not set)
ssl( is_set ) | whether to use ssl | false (not set)
 