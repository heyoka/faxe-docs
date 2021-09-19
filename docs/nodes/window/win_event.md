The win_event node
=====================

A window node is for batching data_points.

This window holds `period` number of data_points and emits every `every` incoming point. 

With `fill_period` given, the window will only emit when it is filled with period points.
This only applies if the `period` is greater than the `every` value.

Examples
-------
```dfs  
|win_event()
.every(5)
.period(15)
.fill_period() 
``` 

The window will emit it's contents every 5 incoming points, but only after the window is filled with 15 points.

```dfs  
|win_event()
.every(5)
.period(15)
```

The window will emit it's contents every 5 incoming points. On first emit 5 points will be outputted, on the second emit 10
points will be emitted. From the third emit onwards, the window will output 15 points. Starting with the 4th emit, the window
will output 15 data_points - with 10 old and 5 new  points (Sliding window).

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
period( `integer` ) | Window length, number of points| defaults to `every` (tumbling window)
every( `integer` )| Output window contents every n incoming points| 
fill_period( is_set )|Output only when window is filled| false (not set)
