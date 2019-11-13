The shift node
=====================

The shift node shifts points and batches in time. 
This is useful for comparing batches or points from different times.

Example
-------
    
    |shift(5m)
  
Shift all data point 5m forward in time.

    |shift(-10s)
    
Shift all data points 10s backwards in time.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
node-param **offset**( `duration` )| time offset | 
