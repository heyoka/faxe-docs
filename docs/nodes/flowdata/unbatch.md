The unbatch node
=====================

Used to unbatch data_batch items. 
This node only emits data_point items. 

If it receives a `data_point` item, it will simply pass it on to connected nodes. 

If the node receives `data_batch` items, it will emit every single data_point from the batch in sequence.
 

Example
-------
```dfs  
|unbatch()
```
 


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
 