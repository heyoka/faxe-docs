The top node
=====================

Select the top num points.

See the [stats node](../stats.md)

Example
-------

```dfs      
|top()
.field('temperature') 
```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( `string` )|name of the field used for computation|
as( `string` )| name for the field for output values| defaults to the name of the stats-node
num( `integer` )| number of points to select|1
