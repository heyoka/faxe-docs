The union node
=====================

Union of multiple streams.

The union node takes the union of all of its parents as a simple pass through.

Data points received from each parent are passed onto children nodes without modification.

Example
-------

```dfs  
in1
  |union(in2, in3) 
```

The union of 3 nodes (chain expressions)

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
_[node]_ nodes_in( `node_list` )|   | optional
 