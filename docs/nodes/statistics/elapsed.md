The elapsed node
=====================

Compute the elapsed time between points.

See the [stats node](/nodes/stats)

Example
-------
    
```dfs  

|elapsed()
.field('trigger') 

```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( string )|name of the field used for computation|
as( string )| name for the field for output values| defaults to the name of the stats-node
