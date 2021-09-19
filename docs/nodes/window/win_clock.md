The win_clock node
=====================

A window node is for batching data_points.

This window-type has wall-clock timing, timestamps contained in incoming events are not relevant here.

When the `align` option is true, window boundaries are aligned according to the `every` option, this means
when every is 5s and an event comes into the window at time 15:03:27, this event will be member of the window
that starts at 15:03:25, otherwise the window would start at 15:03:27.
By default, the boundries are defined relative to the first data point the window node receives.

With `fill_period` given, the window will not emit before "period" time has elapsed (for the first time).
This only applies if the `period` is greater than the `every` value.

Example
-------

```dfs   

|win_clock()
.every(5s)
.period(15s)
.fill_period()
.align()

```
     
The window will emit every 5 seconds, but only after initially 15 seconds have passed (due to `fill_period`),
it has its boundaries aligned to 5 second intervals.

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
period( `duration` ) | Window length| defaults to `every` (giving us a tumbling window)
every( `duration` )| Output window contents every |
align( is_set )|Align the window boundaries | false (not set)
fill_period( is_set )|Window output only when period time has elapsed| false (not set)
