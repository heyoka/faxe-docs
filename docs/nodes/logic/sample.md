The sample node
=====================

Samples the incoming points or batches.
One point will be emitted every count or duration specified.

When a duration is given, this node will emit the first data-item arriving after the timeout, 
then the timeout starts again.

Example
-------
```dfs  
|sample(5)
```
Keep every 5th data_point or data_batch.

```dfs  
|sample(10s)
```

Keep the first point or batch after a 10 second interval.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
_[node]_ **rate**( `integer` `duration` )| sample rate | 
