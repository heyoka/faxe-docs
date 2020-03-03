The distinct node
=====================

Select unique values.

See the [stats node](/nodes/stats)

Example
-------

```dfs     
|distinct()
.field('status') 
```

Parameters
----------
all statistics nodes have the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( string )|name of the field used for computation|
as( string )| name for the field for output values| defaults to the name of the stats-node
