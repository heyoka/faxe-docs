The union node
=====================

Union of multiple streams.

The union node takes the union of all of its parents as a simple pass through.

Data items received from each parent are passed onto child nodes without modification.

Example
-------

```dfs  
in1
  |union(in2, in3) 
```

The union of 3 nodes (chain expressions)



```dfs 
def in1 = 
|mqtt_subscribe()
.host ... 

def in2  = 
|amqp_consume()
.host ....

def in3 = 
...

in1
  |union(in2, in3) 
```
with chain expressions

Parameters
----------

| Parameter                        | Description | Default  |
|----------------------------------|-------------|----------|
| _[node]_ nodes_in( `node_list` ) |             | optional |
 