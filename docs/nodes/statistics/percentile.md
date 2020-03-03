The percentile node
=====================

Select a point at the given percentile. This is a selector function, no interpolation between points is performed.

See the [stats node](/nodes/stats)

Example
-------

```dfs   
|percentile()
.perc(95)
.field('temperature') 
```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( `string` )|name of the field used for computation|
as( `string` )| name for the field for output values| defaults to the name of the stats-node
perc ( `integer` )| select percentile | 95
