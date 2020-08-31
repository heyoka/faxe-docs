The where node
=====================

Filter points and batches with a lambda expression, which returns a boolean value.

Data-items for which the lambda expression evaluates as `false` will be discarded. 

Example
-------

```dfs  
  
|where(lambda: hour("ts") < 18 AND hour("ts") > 8 )

```
     
Discards every point who's timestamp is not between 09:00 and 18:00 UTC.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
_[node]_ lambda( `lambda` ) | The lambda filter expression|
