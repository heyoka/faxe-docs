The kurtosis node
=====================

Compute the kurtosis of data.

See the [stats node](/nodes/stats)

Example
-------

```dfs  
|kurtosis()
.field('temperature') 
```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( string )|name of the field used for computation|
as( string )| name for the field for output values| defaults to the name of the stats-node
