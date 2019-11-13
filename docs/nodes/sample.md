The sample node
=====================

Samples the incoming points or batches.
One point will be emitted every count or duration specified.

Example
-------
    
    |sample(5)
  
Keep every 5th data_point or data_batch.

    |sample(10s)
    
Keep every point or batch, that falls in a 10 second boundary.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
node-param **rate**( `integer` `duration` )| sample rate | 
