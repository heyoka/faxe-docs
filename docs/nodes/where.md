The where node
=====================

Filter points and batches with a lambda expression, which returns a boolean value.

Data-items for which the lambda expression evaluates as false will be discarded. 

Example
-------
    
    |where()
    lambda(lambda: hour("ts") < 18 AND hour("ts") > 8)
     
Filters points who's timestamp is not between 09:00 and 17:00.

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
lambda( `lambda` ) | The lambda filter expression|
