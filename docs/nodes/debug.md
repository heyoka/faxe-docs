The debug node
=====================

The debug node logs all incoming data with erlang's `lager` framework and emits it, without touching it.
Where the logs will be written, depends on the `lager` config.

See [rest api](./faxe_rest_api.html) for how to read the produced logs.


Example
-------
```dfs  
|debug()
    
    
|debug('error')
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
[node] level (`string`) | log level (see below) | 'notice'


The level parameter must have one of the following values:

log_level | |
----------|-|
debug
info
notice
warning
error
critical
alert