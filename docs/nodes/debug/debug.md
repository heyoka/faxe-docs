The debug node
=====================

The debug node logs all incoming data with erlang's `lager` framework and emits it, without touching it.
Where the logs will be written, depends on the `lager` config.

The debug message will include the current data-item converted to a string.

See [rest api](./faxe_rest_api.html) for how to read the produced logs.


Example
-------
```dfs  
|debug()
    
    
|debug('error')


%% [since 0.19.13]
|debug('warning')
.where(lambda: empty("data.topic") OR empty("data.stream_id"))
.message('Topic or StreamId is empty!')

```

Parameters
----------

| Parameter                          | Description                                                             |  Default  |
|------------------------------------|-------------------------------------------------------------------------|:---------:|
| _[node]_ level (`string`)          | log level (see below)                                                   | 'notice'  |
| message (`string`) [since 0.19.13] | custom message that is written to the log                               |    ''     |
| where (`lambda`) [since 0.19.13]   | lambda expression, if evaluates as true, then logging will be performed | undefined |

The level parameter must have one of the following values:

|log_level | |
|----------|:-:|
|debug | |
|info | |
|notice | |
|warning | |
|error | |
|critical | |
|alert | |