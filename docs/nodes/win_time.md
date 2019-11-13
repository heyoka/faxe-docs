The win_time node
=====================

A window node is for batching data_points.

This window refers it's timing to the timestamp contained in the incoming data-items.

With `fill_period` given, the window will not emit before "period" time has elapsed (for the first time).

Note that, since this window type does not rely on wall clock, but on the points timestamps,
it is possible that no data is emitted, if there are no new points coming in.

Example
-------
    
    |win_time()
    .every(5s)
    .period(15s) 
     
The window will emit it's contents every 5 seconds.

    |win_time()
    .every(1m) 
   
Period is 1 minute here (period defaults to every)

Parameters
----------

Parameter           | Description | Default 
--------------------|-------------|------------------------------------------------------------
period( `duration` ) | Window length|defaults to `every`
every( `duration` )| Output window contents every | 
fill_period( is_set )|Window output only when period time has accumulated| false (not set)
