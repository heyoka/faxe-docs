The mqtt_subscribe node
=====================

Subscribe to an mqtt-broker and get data for a specific topic. 


Example
-------

    |mqtt_subscribe()
    .host('192.168.8.9')
    .port(1883)
    .topic('top/grips/#')
    .dt_field('UTC-Stamp')
    .dt_format('float_micro')


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| Ip address or hostname of the broker|
port( `integer` )| The broker's port | 1883
topic( `string` )| mqtt topic to use| 
qos( `integer` )|Quality of service, one of 0, 1 or 2| 1
retained( is_set )| whether the message should be retained on the broker| false (not set)
dt_field( `string` )|name of the timestamp field that is expected|'ts'
dt_format( `string` )|timestamp or datetime format that is expected (see table below)| 'millisecond'
ssl( is_set ) | whether to use ssl | false (not set)
 
 
Available datetime formats
--------------------------

dt_format    | description                                  | example
-------------|----------------------------------------------|-------------
'millisecond'|timestamp UTC in milliseconds                 |1565343079000
'second'     |timestamp UTC in seconds                      |1565343079
'float_micro'|timestamp UTC float with microsecond precision|1565343079.173588
'float_millisecond'|timestamp UTC float with millisecond precision|1565343079.173
'ISO8601'    |ISO8601 Datetime format string                |'2011-10-05T14:48:00.000Z'
'RFC3339'    |RFC3339 Datetime format string                |'2018-02-01 15:18:02.088Z'
'convtrack_datetime'|special datetime format used in the conveyor tracking data stream|'19.08.01  17:33:44,867  '

