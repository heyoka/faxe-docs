The http_get node
=====================

Since 0.16.0

Requests data from a specified HTTP(s) endpoint via the GET method.
If any errors occur during the request, the node will attempt to retry sending.

Request are made periodically, if `every` is given and/or triggered via incoming data-items.



Example
-------
```dfs  

|http_get()
.host('127.0.0.1')
.port(8081)
.path('/v1/stats/faxe')
.every(4s)
.align()
.as('get_response') 

```

Sends a GET request every 4 seconds to the specified host with the URI path `/v1/stats/faxe`.
Response data will be interpreted as JSON and 'get_response' will be the root object for the resulting data-point.

Example in json format

Http response body:
```json

{"id": 2233, "name": "takahashu", "mode": 123}

```

Resulting data-point

```json

{"ts": 1629812164152, 
  "get_response":  
      {"id": 2233, "name": "takahashu", "mode": 123}
}

```

Without the `as` parameter, the resulting data-point would be:
```json

{"ts": 1629812164152, 
  "id": 2233, "name": "takahashu", "mode": 123
}

```


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
host( `string` )| hostname or ip address of endpoint |
port( `integer` )|port number|80
tls( `is_set` ) | whether to use tls ie. https | false (not set)
path( `string` )| URI path of the http endpoint | '/'  
every( `duration` )|interval at which requests are made | undefined
align( `is_set` )|align read intervals according to every|false (not set)
payload_type ( `string` )| how to interpert the response body, `'json'` or `'plain'` | 'json'
retries( `integer` )|number of retries, if request failed|2
as( `string` )|Root-path for the resulting data-point. If not given and `payload-type` is `plain`, defaults to 'data'.|undefined|'data'