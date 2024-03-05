The http_listen node
=====================

Since 0.16.0

The http_listen node provides an http endpoint, that is listening for incoming data via `POST` or `PUT`.

Response
--------

| Status                     | Description                                                                                                  | Body                       |
|----------------------------|--------------------------------------------------------------------------------------------------------------|----------------------------|
| 200 OK                     | OK                                                                                                           | json : {"success": "true"} |
| 401 Unauthorized           | BasicAuth was defined with `user and pass` options, but Authorization header not present or has wrong value. |                            |
| 405 Method not allowed     | Http method other than `OPTIONS`, `POST` or `PUT` used.                                                      |                            |
| 415 Unsupported Media Type | Body is missing or wrong content-type is used.                                                               |                            |

Example 1
-------
```dfs  

|http_listen()

```

Will set up an `http` endpoint, waiting for data coming in on `port 8899` and path '/' and as
`application/json` data. The body will be interpreted as json and inserted with the root-object 'data' in the resulting data-point.


Example 2
-------
```dfs  

|http_listen() 
.path('/SInterface/MaintenanceInterface_SaveMaintenanceAlert') 
.as('data.http_res')
.content_type('application/x-www-form-urlencoded')
.payload_type('json')
.tls()

```

Will set up an `https` endpoint, waiting for data coming in on `port 8899` and with path '/SInterface/MaintenanceInterface_SaveMaintenanceAlert' and as
`application/x-www-form-urlencoded` data. 

Every field in this urlencoded body will be interpreted as a json string.
For example: if there is a field called `alert_type` in the incoming body with a value of: `{"id": 0, "name": "notice"}`, 
there will be a field `data.http_res.alert_type` in the resulting data-item:
```json

{"ts": 1629812164152, 
  "data": 
    {"http_res":  
      {"alert_type":  {"id": 0, "name": "notice"}}
    }
}

```  
--------------------------------------------------------------------------

Example 3
-------
```dfs  

|http_listen()
.port(8898)
.content_type('text/plain')
.as('data.http_res')
.payload_type('json')

```
Will set up an `http` (no tls) endpoint, listening on `port 8898` and path '/'.
The body of the message will be interpreted as a json string. The resulting data-structure will be set under `data.http_res` in the resulting data-item.

Example:
Raw body value: `{"id": 2233, "name": "takahashu", "mode": 123}`.

Resulting data-point in json format:
```json

{"ts": 1629812164152, 
  "data": 
    {"http_res":
      {"id": 2233, "name": "takahashu", "mode": 123}
    }
}

```


Parameters
----------

| Parameter                | Description                                                                                                                               | Default            |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|--------------------|
| port( `integer` )        | port to listen on                                                                                                                         | 8899               |
| tls( `is_set` )          | whether to use tls (https), For ssl options used (tls version, ciphers suites, etc.) see faxe's http API [config](../../configuration.md) | false (not set)    |
| path( `string` )         | URI path of the http endpoint                                                                                                             | '/'                |
| payload_type( `string` ) | how to interpret incoming data, valid values: `'plain'` or `'json'`                                                                       | 'plain'            |
| content_type( `string` ) | how the message-body will be interpreted, `'application/x-www-form-urlencoded'`, `'text/plain'`, `'application/json'`                     | 'application/json' |
| as( `string` )           | base path for resulting data-items, if not given and content_type is `text/plain` or `application/json`, 'data' is the default value      | undefined / 'data' |
| user( `string` )         | If given, `BasicAuth Authorization` is to be used in requests to this endpoint.                                                           | undefined          |
| pass( `string` )         | If user is given, pass must be given also.                                                                                                | undefined          |
