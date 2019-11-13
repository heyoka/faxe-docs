The change_detect node
=====================

Emits new point-values only if different from the previous point.

* Normal (non-exclusive) behaviour is: the node emits every value that is either not in the fields list or it has changed
* Multiple fields can be monitored by this node
* If reset_timeout is given, all previous values are reset, if there are no points coming in for this amount of time
* With the exclusive flag set, every given monitor field has to have a changed value in order for the node to emit anything
* For value comparison erlang's strict equals (=:=) is used, so 1.0 is not equal to 1


Example
-------

    |change_detect()
    .fields('val')
    .reset_timeout(3s)


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
fields( `string_list` )| List of fields to monitor|
reset_timeout( `duration` )| Previous values TTL | 3h
exclusive( is_set )| whether exclusive mode in on| false (not set) 
 