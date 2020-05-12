The shift node
=====================

The shift node shifts points and batches in time. 
This is useful for comparing batches or points from different times.

Example
-------
```dfs  
|shift(5m)
```

Shift all data points 5 minutes forward in time.

```dfs  
|shift(-10s)
```

Shift all data points 10 seconds backwards in time.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
_[node]_ **offset**( `duration` )| time offset | 
