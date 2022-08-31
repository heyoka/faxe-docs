The http_post node
=====================

Sends incoming data to a specified HTTP endpoint via the POST method as a JSON message.
If any errors occur during the request, the node will attempt to retry sending.

Content-type header `application/json` will be used.

> Note: This node is a sink node and does not output any flow-data, therefore any node connected to this node will not get any data.

Example
-------
```dfs  

|http_post()
.host('remote.com')
.port(8088)
.path('/receive/json') 

```

Sends all incoming data to http://remote.com:8088/receive/json in JSON format.


Parameters
----------

| Parameter         | Description                        | Default         |
|-------------------|------------------------------------|-----------------|
| host( `string` )  | hostname or ip address of endpoint |                 |
| port( `integer` ) | port number                        |                 |
| tls( `is_set` )   | whether to use tls ie. https       | false (not set) |
| user( `string` )  | username for Basic Authentication  | undefined       |
| pass( `string` )  | password for Basic Authentication  | undefined       |
| path( `string` )  | URI path of the http endpoint      | ''              |