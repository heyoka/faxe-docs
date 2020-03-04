The where node
=====================

Filter points and batches with a lambda expression, which returns a boolean value.

Data-items for which the lambda expression evaluates as false will be discarded. 

Example
-------

```dfs  
  
|where(lambda: hour("ts") < 18 AND hour("ts") > 8 )

```
     
Filters points who's timestamp is not between 09:00 and 18:00.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
[node] lambda( `lambda` ) | The lambda filter expression|
