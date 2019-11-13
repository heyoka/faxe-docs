The http_post node
=====================

Sends incoming data to a specified HTTP endpoint via the POST method as a JSON message.
If any errors occur during the request, the node will attempt to retry sending.



Example
-------

    |http_post()
    .host('remote.com')
    .port(8088)
    .path('/receive/json')

Sends all incoming data to http://remote.com:8088/receive/json in JSON format.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
host( `string` )| hostname or ip address of endpoint |
port( `integer` )|port number|
path( `string` )| URI path of the http endpoint | ''  