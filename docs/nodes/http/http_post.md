The http_post node
=====================

Sends incoming data to a specified HTTP endpoint via the POST method as a JSON message.
If any errors occur during the request, the node will attempt to retry sending.

Content-type header `application/json` will be used.

> Note: This node will only output flow-data, if the (POST) request was successful.

Example
-------
```dfs  

|http_post()
.host('remote.com')
.port(8088)
.path('/receive/json') 

```

Sends all incoming data to http://remote.com:8088/receive/json in JSON format.


```dfs  

|http_post()
.host('remote.com')
.port(8088)
.path('/receive/json') 
.header_names('X-Api-key')
.header_values('0000-0000-0000-000') 
```

Custom header `X-Api-key`.



Parameters
----------

| Parameter                      | Description                                                                                   | Default         |
|--------------------------------|-----------------------------------------------------------------------------------------------|-----------------|
| host( `string` )               | hostname or ip address of endpoint                                                            |                 |
| port( `integer` )              | port number                                                                                   |                 |
| tls( `is_set` )                | whether to use tls ie. https                                                                  | false (not set) |
| user( `string` )               | username for Basic Authentication                                                             | undefined       |
| pass( `string` )               | password for Basic Authentication                                                             | undefined       |
| path( `string` )               | URI path of the http endpoint                                                                 | '/'             |
| field( `string` )              | if given, only data from the specified field gets sent, otherwise the whole data-item is used | undefined       |
| header_names( `string_list` )  | list of names for custom headers, that should be sent                                         | undefined       |
| header_values( `string_list` ) | list of corresponding values for custom headers (must be the same length as `header_names`)   | undefined       |
| without( `string_list` )       | list of field-paths, that should not be sent                                                  | undefined       |
| response_as( `string` )        | field-path that should be used as the key for the emitted response data                       | 'data'          |