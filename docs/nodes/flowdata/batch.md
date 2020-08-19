The batch node
=====================

Used to batch a number of points. 
As soon as the node has collected `size` number of points it will emit them in a data_batch.

* A timeout can be set, after which all points currently in the buffer will be emitted, regardless of the number of collected points.
* The timeout is started on the first datapoint coming in to an empty buffer.

Example
-------
```dfs  
|batch(12)

|batch(5)
.timeout(3s)
```

The second example will output a batch with 5 points. 
A data-batch message will be emitted, if either 5 points have been collected 
or 3 seconds have past since the first data-point came in.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
_[node]_ size( `integer` )| Number of points to batch |
timeout( `duration` )|   | 1h 
 