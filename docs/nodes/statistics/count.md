The count node
=====================

Count the number of points.

See the [stats node](../stats.md)

Example
-------

```dfs  
|count()
.field('over_ts') 
```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( `string` )|name of the field used for computation|
as( `string` )| name for the field for output values| defaults to the name of the stats-node
