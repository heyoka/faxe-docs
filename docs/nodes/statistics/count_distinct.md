The count node
=====================

Count the number of distinct values.

See the [stats node](../stats.md)

Example
-------

```dfs  
|count()
.field('product') 
.as('distinct_products')
```

Parameters
----------
all statistics nodes have (at least) the following parameters

Parameter     | Description | Default 
--------------|-------------|--------- 
field( `string` )|name of the field used for computation|
as( `string` )| name for the field for output values| defaults to the name of the stats-node
