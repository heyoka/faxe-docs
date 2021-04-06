The count_change node
=====================

Count the number value changes.

See the [stats node](../stats.md)

Example
-------

```dfs  
|count_change()
.field('value')
.as('changed') 
```

Parameters
----------
all statistics nodes have (at least) the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( `string` )|name of the field used for computation|
as( `string` )| name for the field for output values| defaults to the name of the stats-node
