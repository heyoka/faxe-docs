The state_duration node
=====================

Computes the duration of a given state. The state is defined via a lambda expression.

For each consecutive point for which the lambda expression evaluates as true,
the state duration will be incremented by the duration between points.

When a point evaluates as false, the state duration is reset.

The state duration will be added as an additional field to each point and it's unit is `milliseconds`.
If the expression evaluates to false, the value will be -1.

When the lambda expression generates an error during evaluation, the point is discarded
and does not affect the state duration..

Example
-------

```dfs       
|state_duration(lambda: "val" < 7)
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
[node] lambda( `lambda` )| state lambda expression | 
as( `string` )|name for the added duration field|'state_duration'
