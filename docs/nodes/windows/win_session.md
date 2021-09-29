The win_session node
=====================

_`Experimental`_.

Since 0.17.2
 

This window refers it's timing to the timestamp contained in the incoming data-items.

A session window aggregates records into a session, which represents a period of activity separated by a specified gap of inactivity.
Any data_points with timestamps that occur within the inactivity gap of existing sessions will be added to this session.
If a data_point's timestamp occurs outside the session gap, a new session is created.
A new session window starts if the last record that arrived is further back in time than the specified inactivity gap.

Example
-------

```dfs  
|value_emitter()
.every(500ms)
.jitter(4600ms)

|win_session()
.session_timeout(4500ms)

|debug('info')
```
 
Every data_point, that has a timestamp < last-timestamp + session_timeout, will be member of the current window.

Parameters
----------

Parameter           | Description | Default 
--------------------|-------------|------------------------------------------------------------
session_timeout( `duration` ) | also called `inactivity gap` | 3m 
