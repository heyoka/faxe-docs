The min node
=====================

Compute the minimum of data.

See the [stats node](../stats.md)

Example
-------

```dfs     
|min()
.field('temperature') 
```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( string )|name of the field used for computation|
as( string )| name for the field for output values| defaults to the name of the stats-node
