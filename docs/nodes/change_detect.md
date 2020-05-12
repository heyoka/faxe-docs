The change_detect node
=====================

Emits new point-values only if different from the previous point.
 
* Multiple fields can be monitored for change by this node
* If no fields are given, the complete data-item is compared to the last one
* If reset_timeout is given, all previous values are reset, if there are no points coming in for this amount of time 
* For value comparison erlang's strict equals (=:=) is used, so 1.0 is not equal to 1


Example
-------
```dfs  
%% detects any changes
|change_detect()


%% detect changes in one field, with timeout
|change_detect('val')
.reset_timeout(3s)



% in-example json notation: 
% {"data": {"x": {"temp": 32.4564}, "y" : {"temp" : 31.15155}} }

|change_detect('data.x.temp', 'data.y.temp')

```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
_[node]_ fields( `string_list` )| List of fields to monitor| optional
reset_timeout( `duration` )| Previous values TTL | 3h 
 