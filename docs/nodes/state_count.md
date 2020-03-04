The state_count node
=====================

Computes the number of consecutive points in a given state. 
The state is defined via a lambda expression.
For each consecutive point for which the expression evaluates as true,
the state count will be incremented.

When a point evaluates to false, the state count is reset.
The state count will be added as an additional int field to each point.
If the expression evaluates to false, the value will be -1.

If the expression generates an error during evaluation, the point is discarded
and does not affect the state count.

Example
-------

```dfs       
|state_count(lambda: "val" < 7)
.as('val_below_7')
```

Counts the number of consecutive points which have the value of the `val` field `below 7`.

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
[node] lambda( `lambda` )| state lambda expression | 
as( `string` )|name for the added count field| 'state_count'
